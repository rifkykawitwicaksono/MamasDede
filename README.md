# Bubu & Dudu Finance

PWA dasar untuk tiga perangkat: Bubu, Dudu, dan Perangkat 3.

- `index.html`: login, dashboard, ringkasan bulanan, daftar catatan bersama, dan formulir catatan baru.
- `manifest.webmanifest`: metadata PWA.
- `sw.js`: cache dasar aplikasi.
- `LANGKAH_SETUP.txt`: panduan akun Supabase dan deploy GitHub Pages.

Penting: buat akun Supabase dan izinkan UUID di `private.user_device_allowlist` sebelum login. Jangan pernah menaruh `service_role` key di frontend.
