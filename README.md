# Bubu & Dudu — Catatan Keuangan

Aplikasi pencatat keuangan pribadi bertema pastel dengan maskot panda dan beruang cokelat. Dibuat sebagai SPA statis yang dapat dipublikasikan melalui GitHub Pages dan dipakai offline setelah aset utama berhasil di-cache.

## Fitur

- Dashboard saldo, pemasukan bulan ini, pengeluaran bulan ini, dan savings rate.
- Tambah, edit, hapus, cari, dan filter transaksi.
- Kategori pemasukan/pengeluaran dan ekspor CSV.
- Budget per kategori dengan progress bar dan peringatan visual.
- Grafik distribusi pengeluaran dan perbandingan pemasukan/pengeluaran.
- Wallpaper preset atau unggahan gambar, pengaturan blur dan overlay.
- Sinkronisasi cloud antarperangkat melalui Supabase Auth, tabel bersama, dan Realtime.
- Wallpaper tetap tersimpan lokal di masing-masing perangkat.
- PWA dengan manifest dan service worker untuk cache antarmuka; perubahan keuangan memerlukan internet untuk sinkronisasi.

## File proyek

- `index.html` — struktur aplikasi.
- `style.css` — desain responsif dan tema.
- `script.js` — logika transaksi, grafik, budget, wallpaper, login, dan sinkronisasi.
- `config.js` — URL dan publishable/anon key Supabase.
- `supabase-schema.sql` — skema tabel, kebijakan akses, dan pengaturan Realtime.
- `manifest.json` — konfigurasi instalasi PWA.
- `sw.js` — cache aset dan fallback offline.
- `icon.svg` — ikon aplikasi yang digunakan manifest.
- `README.md` — dokumentasi.

> Catatan: `icon.svg` disertakan sebagai file aset tambahan agar ikon instalasi PWA dapat ditampilkan dengan benar. Letakkan semua file di direktori root repositori yang sama.

## Publikasi ke GitHub Pages

1. Buat repositori GitHub baru, misalnya `bubu-dudu-finance`.
2. Unggah seluruh file proyek ke **root** repositori: `index.html`, `style.css`, `script.js`, `manifest.json`, `sw.js`, dan `icon.svg`.
3. Buka repositori → **Settings** → **Pages**.
4. Pada **Build and deployment**, pilih **Deploy from a branch**.
5. Pilih branch `main` dan folder `/ (root)`, lalu klik **Save**.
6. Tunggu proses deployment selesai. Buka URL yang diberikan GitHub, biasanya `https://USERNAME.github.io/NAMA-REPO/`.
7. Buka URL tersebut sekali ketika perangkat online. Service worker hanya dapat didaftarkan pada HTTPS atau localhost; GitHub Pages menggunakan HTTPS.

## Instalasi di Android

1. Buka URL GitHub Pages melalui Chrome.
2. Tunggu halaman selesai dimuat dan buka sekali saat online.
3. Tekan menu tiga titik Chrome.
4. Pilih **Install app** atau **Add to Home screen** (label dapat berbeda menurut perangkat).
5. Ikuti konfirmasi. Aplikasi akan muncul di layar utama.

## Instalasi di iPhone/iPad

1. Buka URL GitHub Pages melalui Safari.
2. Tekan tombol **Share**.
3. Pilih **Add to Home Screen**.
4. Ubah nama jika perlu, lalu tekan **Add**.

## Mengaktifkan sinkronisasi antarperangkat

1. Buat proyek baru di [Supabase](https://supabase.com/dashboard).
2. Buka `config.js`. Isi `url` dengan Project URL dan `anonKey` dengan publishable key (atau anon key lama) dari Supabase Project Settings → API Keys. Jangan pernah memasukkan `service_role`/secret key ke file frontend.
3. Di Supabase, buka SQL Editor → New query. Salin seluruh isi `supabase-schema.sql`, lalu tekan Run.
4. Di Authentication settings, nonaktifkan public sign-ups. Buat dua akun email/password secara manual di Authentication → Users (atau gunakan fitur invite/create user yang tersedia). Berikan kredensial masing-masing kepada dua pengguna secara privat. Jangan menaruh password di repositori.
5. Pastikan Realtime untuk tabel `public.shared_finance` aktif. SQL mencoba menambahkan tabel ke publikasi `supabase_realtime`; periksa Database → Publications jika event realtime belum diterima.
6. Unggah semua file proyek ke root repositori GitHub Pages, termasuk `config.js` dan `supabase-schema.sql`. Commit perubahan dan tunggu deployment selesai.
7. Buka URL GitHub Pages di perangkat pertama dan login. Jika belum ada data cloud, data lokal perangkat pertama akan digunakan untuk menginisialisasi ruang bersama. Perangkat kedua login dengan akun kedua; data cloud yang sama akan ditampilkan.

## Sinkronisasi dan keamanan

- Pemasukan, pengeluaran, dan budget kategori disimpan di satu ruang data bersama sehingga kedua perangkat melihat catatan yang sama dan perubahan normal tersinkron secara realtime.
- Akun harus dibuat manual dan public sign-ups harus tetap nonaktif. Kebijakan SQL mengizinkan pengguna yang sudah login; karena itu jangan membuat akun tambahan selain dua akun yang dimaksud.
- `config.js` memuat publishable/anon key yang memang digunakan oleh frontend. Keamanan bergantung pada autentikasi dan Row Level Security (RLS); jangan menonaktifkan RLS atau menambahkan secret/service-role key ke frontend.
- Data yang sudah ada di cloud akan menggantikan data lokal saat login. Jika cloud belum memiliki catatan, data lokal perangkat pertama akan menjadi data awal bersama. Ekspor CSV sebelum migrasi sebagai cadangan jika ada data penting.
- Sinkronisasi membutuhkan internet. PWA dapat membuka antarmuka yang tersimpan di cache saat offline, tetapi perubahan offline tidak dijamin akan digabung otomatis dengan perangkat lain. Hindari mengedit data dari dua perangkat secara bersamaan saat koneksi terputus.
- Wallpaper tetap lokal di perangkat masing-masing. Aplikasi ini bukan layanan perbankan; gunakan kata sandi kuat dan jangan berbagi kredensial di chat publik.

## Pengembangan lokal

Jangan membuka `index.html` langsung melalui `file://` jika ingin menguji PWA. Jalankan server lokal sederhana, misalnya dengan ekstensi Live Server di VS Code atau `python -m http.server`, lalu akses `http://localhost:8000`. Service worker mengizinkan `localhost` untuk pengembangan.
