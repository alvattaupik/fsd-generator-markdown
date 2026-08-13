---
name: markdown-to-docx
version: 1.0.14
description: Skill otomatis v1.0.14 untuk mengonversi berkas markdown (.md) use case ke dokumen Microsoft Word (.docx) berformat baku FSD. Menilai intent pengguna - jika pengguna meminta 1 berkas spesifik maka HANYA mengonversi 1 berkas tersebut, jika pengguna meminta semua maka mengonversi seluruh berkas. Menangani pembersihan otomatis UTF-8 BOM (\ufeff). Menyelaraskan struktur heading presisi 100% dengan berkas acuan (Heading 4 langsung diikuti Caption tanpa enter, Heading 5 diikuti 1 enter paragraph space). Seluruh teks pada tabel deskripsi usecase diset dengan Alignment Justify (Rata Kanan Kiri). Penomoran list native Microsoft Word pada tabel deskripsi usecase diset dengan instansi abstractNum & numId terisolasi serta startOverride=1 sehingga penomoran 100% MEMULAI ULANG (RESTART dari 1) untuk setiap elemen/bagian. Menggunakan XML Field SEQ Native Word (SEQ Tabel \* ARABIC dan SEQ Gambar \* ARABIC) sehingga caption otomatis terdeteksi dan terindeks di DAFTAR TABEL & DAFTAR GAMBAR Word.
---

# Skill: Konversi Markdown Ke Dokumen Word (.docx) - Versi 1.0.14

Skill ini digunakan untuk mengonversi file markdown (`.md`) use case menjadi dokumen Microsoft Word (`.docx`) yang rapi, sesuai template dan standar format FSD.

---

## 🎯 Aturan Eksekusi (Single vs Batch File):
1. **Mode Single File (JIKA DIMINTA 1 FILE SPESIFIK)**:
   - Apabila pengguna meminta konversi untuk 1 berkas spesifik (misal: `"markdown to doc untuk file no 1"`, `"konversi 23. Blokir user merchant owner.md"`), maka agent **HANYA BOLEH MENGONVERSI 1 BERKAS TERSERBUT**.
   - Dilarang keras mengonversi seluruh folder/berkas lain jika pengguna tidak memintanya.

2. **Mode Batch / All Files (JIKA DIMINTA SEMUA FILE)**:
   - Agent baru mengonversi seluruh berkas markdown secara kolektif apabila pengguna secara eksplisit meminta semua berkas (misal: `"konversi semua file ke docx"`, `"markdown to docx semua"`).

---

## 📋 Aturan Format & Transformasi Presisi (v1.0.14):

1. **Pembersihan Otomatis Character UTF-8 BOM (`\ufeff`)**:
   - Seluruh berkas markdown dibaca dengan `utf-8-sig` dan dibersihkan dari Byte Order Mark (`\ufeff`) agar penanda `#` pada baris pertama terdeteksi secara presisi sebagai Heading level 1.

2. **Struktur Heading Presisi (Heading 4 & Heading 5)**:
   - **`Heading 4` (Nama Use Case Utama)**:
     - Digunakan khusus untuk **Nama Use Case Utama** (contoh: `Heading 4: Login SSO`, `Heading 4: Checker verification onboarding calon merchant`).
     - **TIDAK** menyisipkan `Heading 2: Detail Spesifikasi` atau `Heading 3` tambahan yang dapat menyebabkan duplikasi judul.
     - Paragraf `Heading 4` **LANGSUNG DIIKUTI** oleh `Caption: Tabel N Deskripsi Use Case <Nama Use Case>` tanpa ada paragraf enter kosong di antaranya.
   - **`Heading 5` (Sub-bagian Use Case)**:
     - Digunakan untuk seluruh sub-bagian use case:
       - `Heading 5: Main Flow`
       - `Heading 5: Alternative Flow`
       - `Heading 5: Status Front-End`
       - `Heading 5: Activity Diagram <Nama Use Case>`
       - `Heading 5: Sequence Diagram <Nama Use Case>`
       - `Heading 5: Response Code`
       - `Heading 5: Desain Antarmuka`
     - Paragraf `Heading 5` **SELALU DIIKUTI** oleh 1 paragraf enter kosong (`p_enter`) sebelum `Caption` atau gambar diagram.

3. **Format Justify pada Seluruh Tabel Deskripsi Use Case**:
   - Seluruh isi teks dan paragraf pada tabel deskripsi use case (termasuk list poin bernomor native MS Word pada **Pre-condition**, **Post-condition**, **Integrasi**, **Asumsi**, **Keterbatasan**, **Aturan Bisnis/Sistem**) diset dengan **Alignment Justify (Rata Kanan Kiri)**.

4. **Penomoran Native Word ISOLATED RESTART PER BAGIAN**:
   - Pada kolom `Deskripsi Detail` untuk elemen **Pre-condition**, **Post-condition**, **Integrasi**, **Asumsi**, **Keterbatasan**, **Aturan Bisnis/Sistem**:
   - Setiap elemen menerima instansi `abstractNum` dan `numId` terisolasi baru secara otomatis di `numbering.xml` beserta tag `<w:startOverride w:val="1"/>`.
   - Hal ini **MENJAMIN 100%** bahwa Microsoft Word akan **SELALU MEMULAI ULANG (RESTART) DARI ANGKA 1** pada setiap bagian (`1, 2...`).

5. **Native Word SEQ Field Captions**:
   - Caption dibuat menggunakan struktur XML Field `SEQ` bawaan Microsoft Word (`SEQ Tabel \* ARABIC` dan `SEQ Gambar \* ARABIC`).
   - Caption **otomatis terdeteksi oleh fitur Microsoft Word DAFTAR TABEL dan DAFTAR GAMBAR** (Table of Tables & Table of Figures).
   - Menghapus tanda titik dua `:` pada penulisan caption sesuai format baku template (contoh: `Tabel 11 Deskripsi...`, `Gambar 3 Activity...`).

6. **Render Diagram PlantUML**:
   - Diagram Activity & Sequence Diagram berbasis PlantUML (` ```plantuml ... ``` `) dirender secara otomatis menjadi gambar PNG resolusi tinggi.
   - Gambar dimasukkan ke dokumen secara **Center Aligned** dengan caption gambar di bawahnya.

7. **Format & Perapihan Tabel Lanjutan**:
   - Style tabel: **Table Grid**.
   - Shading Judul Kolom (Header Row): **Blue, Accent Lighter 40%** (Hex `#9BC2E6`).
   - Teks Judul Kolom: **Bold**, Arial 11 pt, Spasi 1.5, Center Aligned.
   - **Pengulangan Header (`tblHeader`)**: Judul kolom otomatis muncul kembali di bagian atas halaman saat tabel terpotong halaman baru.
   - **Pencegahan Pemotongan Baris (`cantSplit`)**: Seluruh baris tabel diproteksi agar tidak terpotong secara canggung di tengah batas halaman.
   - **Padding Sel (`tblCellMar`)**: Memberikan margin dalam sel yang seimbang sehingga teks tidak menempel pada garis tabel.
   - **Alignment Kolom Pintar**: Kolom nomor/kode (`No.`, `Kode`, `HTTP Status`, `Response Code`, `ID Use Case`) otomatis **Center Aligned**, sedangkan seluruh kolom deskripsi/teks diset **Justify Aligned**.

---

## 🚀 Penggunaan Script:

### 1. Single File Mode:
```bash
python3 .agents/skills/markdown-to-docx/Convert-MdToDocx.py --template Template.docx --output "Back Office Hibank/Output" "Back Office Hibank/1. Login_SSO.md"
```

### 2. Batch Mode (Hanya jika pengguna meminta semua file):
```bash
python3 .agents/skills/markdown-to-docx/Convert-MdToDocx.py --template Template.docx --output "Back Office Hibank/Output" "Back Office Hibank/*.md"
```
