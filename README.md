# Simulasi Monte Carlo: Antrean Kedai Kopi (Single-Server Queue M/M/1)

Repositori ini dibuat untuk memenuhi tugas mata kuliah **Simulasi & Pemodelan**.

## 1. Deskripsi Simulasi dan Pemodelan
Proyek ini memodelkan sistem antrean pelanggan pada kasir dan barista tunggal di sebuah kedai kopi pada jam sibuk. Tujuannya adalah untuk menganalisis tingkat kesibukan (*utilitas*) barista, waktu tunggu pelanggan, dan efisiensi pelayanan menggunakan metode **Monte Carlo** dengan pendekatan stokastik.

## 2. Sumber Data
* **Jenis Data:** Data bangkitan artifisial (*Synthetic/Generated Data*) menggunakan bangkitan bilangan acak (*Pseudo-Random Number Generator*).
* **Distribusi Probabilitas:** 
  * Waktu Antar-Kedatangan (*Inter-arrival time*): Berdistribusi Eksponensial dengan rata-rata 3,0 menit ($\lambda = 1/3$).
  * Waktu Pelayanan Barista (*Service time*): Berdistribusi Eksponensial dengan rata-rata 2,5 menit ($\mu = 1/2,5$).
* **Ukuran Sampel:** Simulasi dilakukan untuk $N = 25$ orang pelanggan pertama.

## 3. Bahasa Pemrograman & Tools
* **Bahasa Pemrograman:** R (Versi 4.6.1)
* **Environment:** RStudio
* **Library Pendukung:** Menggunakan fungsi bawaan (*base R*) tanpa paket eksternal tambahan agar mudah dikompilasi.

## 4. Analisis Keterlibatan Tools AI (15%)
* **Persentase Keterlibatan AI:** **15%**
* **Bagian yang Dibantu AI:** AI digunakan sebatas untuk *brainstorming* struktur logika perulangan (*looping*) waktu tunggu antrean dan pembuatan templat dokumentasi Markdown.
* **Pembuktian (Proof of AI Limitations & Human Control):** Seluruh parameter sistem (seperti nilai laju kedatangan $\lambda$, penyesuaian logika batas maksimum, dan validasi visualisasi grafik *barplot* serta *line chart*) divalidasi, diuji coba, dan disesuaikan secara manual oleh penulis melalui *debugging* di Console RStudio.

## 5. Visualisasi Hasil Simulasi
![Grafik Simulasi](grafik_simulasi.png)

## 6. Cara Menjalankan Program
1. Unduh atau *clone* repositori ini.
2. Buka file `simulasi_antrean.R` menggunakan **RStudio**.
3. Jalankan seluruh baris kode untuk melihat tabel simulasi di Console dan grafik di tab *Plots*.
