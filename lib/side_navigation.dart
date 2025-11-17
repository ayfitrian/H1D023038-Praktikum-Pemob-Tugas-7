import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({super.key});

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  String _username = 'Tamu';
  String _role = 'Belum Login';

  @override
  void initState() {
    super.initState();
    _loadUserSession(); // Ambil data saat widget diinisialisasi
  }

  // Fungsi untuk mengambil data username dan role dari local storage
  void _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Tamu';
      _role =
          prefs.getString('role') ?? 'Standard'; // Ambil role yang tersimpan
    });
  }

  // Fungsi untuk logout
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data sesi (username, role)
    // Kembali ke halaman Login dan hapus semua rute sebelumnya
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Kreativitas: Menggunakan UserAccountsDrawerHeader
          UserAccountsDrawerHeader(
            accountName: Text(
              _username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('Role: $_role'), // Tampilkan role
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.deepPurple,
                size: 50,
              ),
            ),
            decoration: const BoxDecoration(color: Colors.deepPurple),
          ),

          // Menu Dashboard
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                // Sudah benar
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
          ),

          // Menu Profile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                // Sudah benar
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),

          const Divider(), // Garis pemisah
          // Menu Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
