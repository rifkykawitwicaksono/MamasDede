# Bubu & Dudu Finance — PWA Starter

PWA catatan keuangan untuk akun Bubu, Dudu, dan Perangkat 3. Versi ini mempertahankan koneksi Supabase dan kebijakan keamanan yang sudah dipakai aplikasi sebelumnya.

## Yang ditambahkan
- Tampilan logo Bubu & Dudu dengan animasi gerak ringan. Gambar rujukan berasal dari [halaman FAQ GetBubuDudu](https://getbubududu.com/faq-all-about-bubu-and-dudu/). Gambar sumber yang ditemukan berupa PNG statis, bukan GIF animasi; animasi ringan diterapkan pada tampilan logo.
- Bubu ditandai sebagai karakter putih, Dudu cokelat sesuai preferensi proyek.
- Daftar kategori diperluas untuk kehidupan sehari-hari.
- Pengguna dapat menambah kategori sendiri melalui form; kategori tambahan disimpan di browser/perangkat yang dipakai.
- Service worker cache diperbarui agar browser memuat versi terbaru.
- Manifest PWA disiapkan untuk instalasi ke layar utama.

## Kustomisasi
- Nama aplikasi dan gaya visual: edit `index.html`.
- URL gambar logo: cari `brandLogo` dan URL gambar `Bubu-and-Dudu-300x291.png` di `index.html`.
- Kategori bawaan: cari `DEFAULT_CATEGORIES` di `index.html`.
- Kategori tambahan yang dibuat dari aplikasi tersimpan pada perangkat lokal, bukan otomatis tersinkron ke perangkat lain.

## Instalasi PWA
1. Unggah isi folder ini ke repository GitHub Pages yang sama (pertahankan konfigurasi proyek).
2. Tunggu deployment selesai.
3. Buka URL GitHub Pages melalui Chrome di Android.
4. Buka menu Chrome lalu pilih **Install app** atau **Tambahkan ke layar utama**.

Catatan: ini adalah PWA Starter, bukan file APK Android native. Untuk membuat APK diperlukan pembungkus Android seperti Trusted Web Activity/Capacitor dan proses build terpisah. PWA perlu diakses melalui HTTPS agar service worker berjalan.
