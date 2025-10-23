## [1.0.0] - 2025-10-02

### Added
- Rilis pertama aplikasi
- Halaman login & register
- Halaman profil dengan avatar, chip
- Push ke GitHub main

### Updated

### Fixed

### Changed

### Removed

## [1.1.0] - 2025-10-23

### Added
- File `main_page.dart` yang berisi **Bottom Navigation Bar** untuk navigasi antar halaman:
  - `home_page.dart` → Halaman utama.
  - `chat_page.dart` → Halaman percakapan.
  - `add_post_page.dart` → Halaman untuk menambah postingan.
  - `notification_page.dart` → Halaman notifikasi.
  - `profile_page.dart` → Halaman profil pengguna.
- Fitur navigasi dari `home_page.dart` ke `post_detail_page.dart` ketika ikon **komentar** ditekan.
- Halaman `post_detail_page.dart` untuk menampilkan **detail postingan** secara lengkap.
- Fitur **komentar langsung pada detail postingan**:
  - Tekan ikon komentar → membuka **form komentar** menggunakan `showModalBottomSheet`.
  - Komentar yang dikirim akan muncul di bawah postingan secara dinamis.