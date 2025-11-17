# H1D023038_Tugas7: Aplikasi Flutter Sederhana

Proyek ini dibuat untuk memenuhi tugas mata kuliah Pemrograman Mobile dengan fokus pada implementasi fitur autentikasi (Login), penyimpanan sesi (Local Storage), navigasi antar halaman (Routes), dan menu samping (Side Menu) dalam *framework* Flutter.

**Nama Mahasiswa:** Ayu Fitrianingsih
**NIM:** H1D023038
**Mata Kuliah:** Pemrograman Mobile

---

## 🚀 Fitur Utama & Modifikasi Kreatif

Proyek ini telah dikembangkan dengan memodifikasi konsep dasar dari modul, khususnya pada aspek *login* dan struktur navigasi, untuk mendapatkan nilai kreativitas yang lebih baik.

### Komponen Wajib

| Fitur Wajib | Implementasi | Modifikasi Kreatif |
| :--- | :--- | :--- |
| **Login** | Menggunakan `StatefulWidget` (`LoginScreen`). | **Role-Based Login:** Membedakan akses berdasarkan peran (`admin` dan `user`). |
| **Local Storage** | Menggunakan *package* `shared_preferences`. | Menyimpan dua nilai sesi: `username` dan `role` (bukan hanya *username*). |
| **Routes** | Menggunakan `Navigator.pushReplacement` dan `MaterialPageRoute`. | Navigasi mencakup tiga layar (`Login`, `Dashboard`, `Profile`). |
| **Side Menu** | Menggunakan *Widget* `Drawer` (`SideNavigation`). | Menggunakan `UserAccountsDrawerHeader` untuk menampilkan **Username & Role** yang diambil dari Local Storage. |

---

## 🔑 Panduan Penggunaan Aplikasi

### Skema Login

Aplikasi ini menggunakan skema login statis dengan dua peran (Role) yang berbeda. Silakan gunakan kredensial berikut untuk menguji coba fitur Role-Based Login:

| Peran (Role) | Username | Password |
| :--- | :--- | :--- |
| **Administrator** | `admin` | `123` |
| **Standard User** | `user` | `123` |

### Struktur File Proyek

Struktur folder `lib/` yang digunakan:

   ###     lib/ 
   ###     ├── main.dart # Titik masuk aplikasi & konfigurasi tema. 
   ###     ├── login_screen.dart # Halaman Login (Mengandung logika penyimpanan sesi). 
    ├── dashboard_screen.dart # Halaman utama setelah login (Menampilkan Username & Role). 
    ├── profile_screen.dart # Halaman detail profil (Menampilkan data yang diambil dari Local Storage). 
    └── side_navigation.dart # Side Menu (Drawer) yang berfungsi sebagai navigasi utama dan tombol Logout.


---

## ⚙️ Cara Menjalankan Aplikasi

### 1. Dependencies

Pastikan *package* `shared_preferences` sudah terinstal dalam `pubspec.yaml`:

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2 # Versi stabil terbaru

### 2. Langkah Eksekusi
- Buka terminal di direktori proyek (h1d023038_tugas7).
- Jalankan perintah untuk mengunduh dependencies:

flutter pub get

- Jalankan aplikasi pada perangkat atau emulator:

flutter run
