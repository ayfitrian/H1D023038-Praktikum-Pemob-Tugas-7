import 'package:flutter/material.dart';
import 'login_screen.dart'; // Mengarah ke halaman login yang dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H1D023038_Tugas7 App', // Modifikasi judul
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Kreativitas: Ganti primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Arahkan ke LoginScreen
    );
  }
}
