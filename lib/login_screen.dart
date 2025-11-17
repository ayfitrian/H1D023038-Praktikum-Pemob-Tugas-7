import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menyimpan sesi pengguna (username dan role)
  void _saveUserSession(String username, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('role', role); // Simpan role ke local storage
  }

  // Fungsi untuk menampilkan alert
  void _showAlert(String title, String message, {Widget? navigateTo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                if (navigateTo != null) {
                  // Jika ada halaman tujuan, navigasi
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => navigateTo),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi validasi login (Modifikasi/Kreativitas: Skema Login dengan Role)
  void _handleLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    String role = 'Standard';
    bool success = false;

    if (username == 'admin' && password == '123') {
      role = 'Administrator';
      success = true;
    } else if (username == 'user' && password == '123') {
      role = 'Standard User';
      success = true;
    }

    if (success) {
      // 1. Simpan sesi (username dan role)
      _saveUserSession(username, role);

      // 2. Tampilkan alert sukses dan navigasi ke Dashboard
      _showAlert(
        'Login Berhasil!',
        'Selamat datang, $username. Anda login sebagai $role.',
        navigateTo: const DashboardScreen(),
      );
    } else {
      // Tampilkan alert error
      _showAlert(
        'Login Gagal',
        'Username atau Password salah. Coba: admin/123 atau user/123.',
      );
    }
  }

  // Widget untuk input field (Kreativitas: menggunakan TextFormField)
  Widget _buildInputField(
    TextEditingController controller,
    String placeholder,
    bool isPassword,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(isPassword ? Icons.lock : Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$placeholder tidak boleh kosong';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Masuk ke Sistem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 30),

                // Input Username
                _buildInputField(
                  _usernameController,
                  'Masukkan Username',
                  false,
                ),
                const SizedBox(height: 15),

                // Input Password
                _buildInputField(
                  _passwordController,
                  'Masukkan Password',
                  true,
                ),
                const SizedBox(height: 30),

                // Tombol Login
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
