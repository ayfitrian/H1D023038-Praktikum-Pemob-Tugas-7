import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'side_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'Memuat...';
  String _role = 'Memuat...';

  @override
  void initState() {
    super.initState();
    _loadUserSession(); // Panggil fungsi untuk memuat data
  }

  // Fungsi untuk mengambil data username dan role
  void _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna Tidak Dikenal';
      _role = prefs.getString('role') ?? 'Tidak Ada Role';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Profil'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const SideNavigation(),

      // SOLUSI: Bungkus konten dengan SingleChildScrollView dan HAPUS Center
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            // Penting: mainAxisAlignment.start untuk konten di dalam scroll view
            mainAxisAlignment: MainAxisAlignment.start,
            // Untuk menengahkan konten secara horizontal
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Sedikit mengurangi tinggi awal
              // Tampilan Foto Profil
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Menampilkan Informasi Pengguna
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Data Username
                      _buildInfoRow(
                        Icons.account_circle,
                        'Username',
                        _username,
                      ),
                      const Divider(),
                      // Data Role
                      _buildInfoRow(
                        Icons.shield_outlined,
                        'Status/Role',
                        _role,
                      ),
                      const Divider(),
                      // Contoh data tambahan (statis)
                      _buildInfoRow(
                        Icons.email,
                        'Email',
                        '$_username@example.com',
                      ),
                    ],
                  ),
                ),
              ),

              // SOLUSI: Tambahkan ruang ekstra yang memadai di bagian bawah
              const SizedBox(height: 50),
              const Text(
                'Anda dapat logout melalui Side Menu.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // Tambahkan SizedBox yang besar agar tidak terjadi overflow di Web/Desktop
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk baris informasi
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 24),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // Gunakan Flexible atau Overflow.ellipsis jika ada kemungkinan username sangat panjang
              SizedBox(
                width: 200, // Beri batasan lebar agar aman dari overflow
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
