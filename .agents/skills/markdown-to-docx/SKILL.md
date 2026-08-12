---
name: markdown-to-docx
version: 1.0.12
description: Skill otomatis v1.0.12 untuk mengonversi berkas markdown (.md) use case ke dokumen Microsoft Word (.docx) berformat baku FSD. Seluruh teks pada tabel deskripsi usecase (termasuk list poin bernomor native MS Word untuk Pre-condition, Post-condition, Integrasi, Asumsi, Keterbatasan, Aturan Bisnis/Sistem) diset dengan Alignment Justify (Rata Kanan Kiri). Penomoran list native Microsoft Word pada tabel deskripsi usecase diset dengan instansi abstractNum & numId terisolasi serta startOverride=1 sehingga penomoran DIJAMIN 100% MEMULAI ULANG (RESTART dari 1) untuk setiap elemen/bagian. Menggunakan XML Field SEQ Native Word (SEQ Tabel \* ARABIC dan SEQ Gambar \* ARABIC) sehingga caption otomatis terdeteksi dan terindeks di DAFTAR TABEL & DAFTAR GAMBAR Word. Memindai isi dokumen (body text) untuk mendeteksi penomoran Tabel N (terakhir Tabel 10) dan Gambar N (terakhir Gambar 2) secara akurat sehingga penomoran baru dilanjutkan menjadi Tabel 11..., Gambar 3... Memiliki revisi jarak enter otomatis setelah heading jika langsung diikuti gambar/diagram PlantUML, enter setelah heading jika diikuti caption, DAN enter setelah caption jika diikuti heading. Dilengkapi perapihan tabel tingkat lanjut (cantSplit rows, repeating header rows, padding sel/tblCellMar, alignment kolom otomatis, dan Elemen Spesifikasi bold).
---

# Skill: Konversi Markdown Ke Dokumen Word (.docx) - Versi 1.0.12

Skill ini digunakan untuk mengonversi sekumpulan file markdown (`.md`) use case menjadi dokumen Microsoft Word (`.docx`) yang rapi, sesuai template dan standar format FSD.

## 📋 Aturan Format & Transformasi (v1.0.12):
1. **Daftar File Markdown (Berurutan)**:
   - Membaca file markdown dari folder input yang diurutkan berdasarkan penomoran file (contoh: `1.Nama.md`, `2.Nama.md`).

2. **Format Justify pada Seluruh Tabel Deskripsi Use Case (v1.0.12)**:
   - Seluruh isi teks dan paragraf pada tabel deskripsi use case (termasuk list poin bernomor native MS Word pada **Pre-condition**, **Post-condition**, **Integrasi**, **Asumsi**, **Keterbatasan**, **Aturan Bisnis/Sistem**) diset dengan **Alignment Justify (Rata Kanan Kiri)**.

3. **Penomoran Native Word ISOLATED RESTART PER BAGIAN**:
   - Pada kolom `Deskripsi Detail` untuk elemen **Pre-condition**, **Post-condition**, **Integrasi**, **Asumsi**, **Keterbatasan**, **Aturan Bisnis/Sistem**:
   - Setiap elemen menerima instansi `abstractNum` dan `numId` terisolasi baru secara otomatis di `numbering.xml` beserta tag `<w:startOverride w:val="1"/>`.
   - Hal ini **MENJAMIN 100%** bahwa Microsoft Word akan **SELALU MEMULAI ULANG (RESTART) DARI ANGKA 1** pada setiap bagian (Pre-condition `1, 2...`, Post-condition `1, 2...`, dst).
   - Angka manual bawaan (`1. `, `2. `) dibersihkan agar dikelola secara otomatis oleh engine penomoran Word.

4. **Native Word SEQ Field Captions**:
   - Caption dibuat menggunakan struktur XML Field `SEQ` bawaan Microsoft Word (`SEQ Tabel \* ARABIC` dan `SEQ Gambar \* ARABIC`).
   - Caption **otomatis terdeteksi oleh fitur Microsoft Word DAFTAR TABEL dan DAFTAR GAMBAR** (Table of Tables & Table of Figures).
   - Menghapus tanda titik dua `:` pada penulisan caption sesuai format baku template (contoh: `Tabel 11 Deskripsi...`, `Gambar 3 Activity...`).
   - Penomoran baru dilanjutkan secara akurat dari angka body template (`Tabel 11...`, `Gambar 3...`).

5. **Template & Posisi Headings (Point 4.1.2)**:
   - Memasukkan konten markdown ke dalam template docx (setelah bagian 4.1.2 / bab Alur Proses).
   - Menggunakan style heading dari template Word.
   - **TIDAK** mengambil nomor heading bawaan dari markdown (nomor prefix `4.1.2.1` atau `4.1.2.1.1` dibersihkan, hanya menyisakan judul heading asli).
   - **Spasi Enter Heading, Gambar & Caption**:
     - Jika sebuah **heading** langsung diikuti oleh **gambar / diagram PlantUML**, otomatis diberikan spasi enter setelah heading.
     - Jika sebuah **heading** langsung diikuti oleh **caption**, otomatis diberikan spasi enter setelah heading.
     - Jika sebuah **caption** langsung diikuti oleh **heading**, otomatis diberikan spasi enter setelah caption.

6. **Render Diagram PlantUML**:
   - Diagram Activity & Sequence Diagram berbasis PlantUML (` ```plantuml ... ``` `) dirender secara otomatis menjadi gambar PNG resolusi tinggi.
   - Gambar dimasukkan ke dokumen secara **Center Aligned** dengan caption gambar di bawahnya.

7. **Format & Perapihan Tabel Lanjutan**:
   - Style tabel: **Table Grid**.
   - Shading Judul Kolom (Header Row): **Blue, Accent Lighter 40%** (Hex `#9BC2E6`).
   - Teks Judul Kolom: **Bold**, Arial 11 pt, Spasi 1.5, Center Aligned.
   - **Pengulangan Header (`tblHeader`)**: Judul kolom otomatis muncul kembali di bagian atas halaman saat tabel terpotong halaman baru.
   - **Pencegahan Pemotongan Baris (`cantSplit`)**: Seluruh baris tabel diproteksi agar tidak terpotong secara canggung di tengah batas halaman.
   - **Padding Sel (`tblCellMar`)**: Memberikan margin dalam sel (top/bottom/left/right) yang seimbang sehingga teks tidak menempel pada garis tabel.
   - **Alignment Kolom Pintar**: Kolom nomor/kode (`No.`, `Kode`, `HTTP Status`, `Response Code`, `ID Use Case`) otomatis **Center Aligned**, sedangkan seluruh kolom deskripsi/teks diset **Justify Aligned**.
   - **Elemen Spesifikasi Bold**: Nama elemen pada tabel deskripsi usecase otomatis diset **Bold** agar visual lebih tegas.

8. **Format Teks & Layout**:
   - **Font**: Arial
   - **Ukuran**: 11 pt
   - **Spasi Baris**: 1.5
   - **Warna Teks**: Black (`#000000`)
   - **Alignment Paragraf**: **Justify** (Rata Kanan Kiri), **KECUALI** caption tabel dan gambar diset ke **Center**.
   - Menjaga integritas dan struktur dokumen pendukung lainnya.

---

## 🚀 Penggunaan:

Jalankan script Python bawaan skill:
```bash
& "C:\Program Files\PostgreSQL\17\pgAdmin 4\python\python.exe" "C:\Users\AL\.gemini\antigravity\skills\markdown-to-docx\Convert-MdToDocx.py" "D:\Folder\Markdown" --template "D:\Contoh Format\Contoh Template.docx" --output "D:\Folder\Output"
```
