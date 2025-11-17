import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _username = '';
  String _role = '';

  @override
  void initState() {
    super.initState();
    _loadUserSession(); // Panggil fungsi saat widget pertama kali dibuat
  }

  // Fungsi untuk mengambil data username dan role
  void _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil Username dan Role yang sudah tersimpan
    final user = prefs.getString('username') ?? 'Pengguna';
    final role = prefs.getString('role') ?? 'Standard';

    // Set state untuk memperbarui UI
    setState(() {
      _username = user;
      _role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Utama'),
        backgroundColor: Colors.deepPurple,
      ),
      // Sematkan Side Menu
      drawer: const SideNavigation(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              Text(
                'Selamat Datang di Dashboard,',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
              const SizedBox(height: 5),
              // Tampilkan username dan role (Modifikasi/Kreativitas)
              Text(
                '$_username!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Anda login sebagai: $_role',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
