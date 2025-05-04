import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MaterialApp(home: AppSettingsScreen()));
}

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  String _username = "brendhaisya04";
  String _phone = "081234567890";
  File? _profileImage;
  List<Address> _addresses = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "brendhaisya04";
      _phone = prefs.getString('phone') ?? "081234567890";
      final imagePath = prefs.getString('profileImage');
      if (imagePath != null) {
        _profileImage = File(imagePath);
      }

      final addressesJson = prefs.getStringList('addresses');
      if (addressesJson != null) {
        _addresses =
            addressesJson.map((json) => Address.fromJson(json)).toList();
      } else {
        _addresses = [
          Address(
            name: "Rumah",
            recipient: "Brendha Isya",
            phone: _phone,
            street: "Jl. Merdeka No. 123",
            district: "Kec. Menteng",
            isDefault: true,
            latLng: const LatLng(-6.1955, 106.8260),
          )
        ];
      }
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    await prefs.setString('phone', _phone);
    if (_profileImage != null) {
      await prefs.setString('profileImage', _profileImage!.path);
    }
    await prefs.setStringList(
        'addresses', _addresses.map((address) => address.toJson()).toList());
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        setState(() {
          _profileImage = File(image.path);
        });
        await _saveUserData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memilih gambar: $e')),
        );
      }
    }
  }

  Widget _buildMenuSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.teal),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _username);
    final phoneController = TextEditingController(text: _phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil', style: TextStyle(color: Colors.teal)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const NetworkImage(
                            'https://randomuser.me/api/portraits/women/65.jpg')
                        as ImageProvider,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.edit, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: TextStyle(color: Colors.teal),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                labelStyle: TextStyle(color: Colors.teal),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.teal)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: () async {
              if (mounted) {
                setState(() {
                  _username = nameController.text;
                  _phone = phoneController.text;
                });
                await _saveUserData();
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _navigateToAddressList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressListScreen(
          addresses: _addresses,
          phone: _phone,
          onAddressUpdated: (updatedAddresses) async {
            if (mounted) {
              setState(() {
                _addresses = updatedAddresses;
              });
              await _saveUserData();
            }
          },
        ),
      ),
    );
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesScreen()),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar Akun', style: TextStyle(color: Colors.teal)),
        content: const Text('Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.teal)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Tambahkan logika logout di sini
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Pengaturan Akun', style: TextStyle(color: Colors.teal)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const NetworkImage(
                                'https://randomuser.me/api/portraits/women/65.jpg')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _username,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _phone,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildMenuSection(
                    title: "Profil",
                    items: [
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: "Data Diri",
                        onTap: _showEditProfileDialog,
                      ),
                      _buildMenuItem(
                        icon: Icons.location_on_outlined,
                        title: "Alamat Saya",
                        onTap: _navigateToAddressList,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMenuSection(
                    title: "Favorit",
                    items: [
                      _buildMenuItem(
                        icon: Icons.favorite_border,
                        title: "Produk Favorit",
                        onTap: _navigateToFavorites,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMenuSection(
                    title: "Akun",
                    items: [
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: "Keluar",
                        color: Colors.red,
                        onTap: _confirmLogout,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Address {
  final String name;
  final String recipient;
  final String phone;
  final String street;
  final String district;
  bool isDefault;
  LatLng latLng;

  Address({
    required this.name,
    required this.recipient,
    required this.phone,
    required this.street,
    required this.district,
    required this.isDefault,
    required this.latLng,
  });

  factory Address.fromJson(String json) {
    final data = json.split('|');
    return Address(
      name: data[0],
      recipient: data[1],
      phone: data[2],
      street: data[3],
      district: data[4],
      isDefault: data[5] == 'true',
      latLng: LatLng(double.parse(data[6]), double.parse(data[7])),
    );
  }

  String toJson() {
    return '$name|$recipient|$phone|$street|$district|$isDefault|${latLng.latitude}|${latLng.longitude}';
  }
}

class AddressListScreen extends StatefulWidget {
  final List<Address> addresses;
  final String phone;
  final Function(List<Address>) onAddressUpdated;

  const AddressListScreen({
    super.key,
    required this.addresses,
    required this.phone,
    required this.onAddressUpdated,
  });

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  late List<Address> _addresses;
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _addresses = List.from(widget.addresses);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _addNewAddress() {
    _editAddress(-1);
  }

  void _editAddress(int index) async {
    bool isNew = index == -1;
    Address address = isNew
        ? Address(
            name: "",
            recipient: "",
            phone: widget.phone,
            street: "",
            district: "",
            isDefault: false,
            latLng: const LatLng(-6.1955, 106.8260),
          )
        : _addresses[index];

    final nameController = TextEditingController(text: address.name);
    final recipientController = TextEditingController(text: address.recipient);
    final streetController = TextEditingController(text: address.street);
    final districtController = TextEditingController(text: address.district);
    LatLng selectedLocation = address.latLng;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(isNew ? "Tambah Alamat" : "Edit Alamat",
                style: const TextStyle(color: Colors.teal)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'Nama Alamat (Rumah/Kantor)'),
                  ),
                  TextField(
                    controller: recipientController,
                    decoration:
                        const InputDecoration(labelText: 'Nama Penerima'),
                  ),
                  TextField(
                    controller: streetController,
                    decoration: const InputDecoration(
                        labelText: 'Jalan/Alamat Lengkap'),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: districtController,
                    decoration: const InputDecoration(labelText: 'Kecamatan'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Pilih lokasi di peta:'),
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: selectedLocation,
                        zoom: 15,
                      ),
                      onTap: (LatLng location) {
                        setState(() {
                          selectedLocation = location;
                        });
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('selected_location'),
                          position: selectedLocation,
                        ),
                      },
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.teal)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  final newAddress = Address(
                    name: nameController.text,
                    recipient: recipientController.text,
                    phone: widget.phone,
                    street: streetController.text,
                    district: districtController.text,
                    isDefault: isNew && _addresses.isEmpty,
                    latLng: selectedLocation,
                  );

                  if (isNew) {
                    _addresses.add(newAddress);
                  } else {
                    _addresses[index] = newAddress;
                  }

                  widget.onAddressUpdated(_addresses);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child:
                    const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Alamat', style: TextStyle(color: Colors.teal)),
        content: const Text('Anda yakin ingin menghapus alamat ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.teal)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (mounted) {
                setState(() {
                  _addresses.removeAt(index);
                });
                widget.onAddressUpdated(_addresses);
                Navigator.pop(context);
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _setDefaultAddress(int index) {
    if (mounted) {
      setState(() {
        for (var i = 0; i < _addresses.length; i++) {
          _addresses[i].isDefault = (i == index);
        }
      });
      widget.onAddressUpdated(_addresses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Saya', style: TextStyle(color: Colors.teal)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _addresses.isEmpty
          ? const Center(child: Text('Belum ada alamat tersimpan'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: address.isDefault
                          ? Colors.teal
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Icon(
                      address.isDefault ? Icons.home : Icons.work,
                      color: Colors.teal,
                      size: 30,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(address.recipient),
                        Text(address.phone),
                        Text(address.street),
                        Text(address.district),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.teal),
                          onPressed: () => _editAddress(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAddress(index),
                        ),
                      ],
                    ),
                    onTap: () => _setDefaultAddress(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _addNewAddress,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Produk Favorit', style: TextStyle(color: Colors.teal)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.teal, width: 1.5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/product_${index + 1}.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              title: Text(
                'Produk Favorit ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Deskripsi produk singkat'),
              trailing: const Icon(Icons.chevron_right, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}
