# SIMULASI MONTE CARLO: ANTREAN KEDAI KOPI (SINGLE SERVER QUEUE M/M/1)

# 1. Mengunci angka acak agar hasil simulasi konsisten saat dipresentasikan
set.seed(2026)

# 2. Parameter Sistem
jumlah_pelanggan <- 25
rata_antar_datang <- 3.0   # Rata-rata pelanggan datang tiap 3 menit
rata_pelayanan    <- 2.5   # Rata-rata barista meracik kopi 2.5 menit

# 3. Membangkitkan Variabel Acak (Distribusi Eksponensial)
selisih_datang  <- round(rexp(jumlah_pelanggan, rate = 1 / rata_antar_datang), 2)
durasi_layanan  <- round(rexp(jumlah_pelanggan, rate = 1 / rata_pelayanan), 2)

# 4. Inisialisasi Vektor untuk Menyimpan Hasil Simulasi
waktu_datang    <- numeric(jumlah_pelanggan)
mulai_dilayani  <- numeric(jumlah_pelanggan)
waktu_tunggu    <- numeric(jumlah_pelanggan)
selesai_layanan <- numeric(jumlah_pelanggan)
total_di_sistem <- numeric(jumlah_pelanggan)
barista_menganggur <- numeric(jumlah_pelanggan)

# 5. Proses Iterasi Simulasi (Pelanggan ke-1 sampai ke-N)
for (i in 1:jumlah_pelanggan) {
  if (i == 1) {
    # Pelanggan pertama datang dan langsung dilayani tanpa mengantre
    waktu_datang[i]       <- selisih_datang[i]
    mulai_dilayani[i]     <- waktu_datang[i]
    barista_menganggur[i] <- waktu_datang[i]
  } else {
    # Pelanggan berikutnya
    waktu_datang[i]   <- waktu_datang[i - 1] + selisih_datang[i]
    
    # Dilayani saat pelanggan datang ATAU menunggu pelanggan sebelumnya selesai
    mulai_dilayani[i] <- max(waktu_datang[i], selesai_layanan[i - 1])
    
    # Waktu kosong barista jika pelanggan baru datang setelah pelanggan lama selesai
    barista_menganggur[i] <- max(0, waktu_datang[i] - selesai_layanan[i - 1])
  }
  
  # Menghitung metrik per pelanggan
  waktu_tunggu[i]    <- round(mulai_dilayani[i] - waktu_datang[i], 2)
  selesai_layanan[i] <- round(mulai_dilayani[i] + durasi_layanan[i], 2)
  total_di_sistem[i] <- round(selesai_layanan[i] - waktu_datang[i], 2)
}

# 6. Menyusun Tabel Hasil Simulasi (Data Frame)
tabel_simulasi <- data.frame(
  Pelanggan       = 1:jumlah_pelanggan,
  Selisih_Datang  = selisih_datang,
  Waktu_Datang    = waktu_datang,
  Mulai_Layanan   = mulai_dilayani,
  Durasi_Racik    = durasi_layanan,
  Waktu_Tunggu    = waktu_tunggu,
  Selesai_Layanan = selesai_layanan,
  Total_Waktu     = total_di_sistem
)

# 7. Menampilkan Tabel dan Ringkasan Evaluasi Kinerja Sistem
cat("================ TABEL SIMULASI ANTREAN KEDAI KOPI ================\n")
print(tabel_simulasi, row.names = FALSE)

utilitas_barista <- (sum(durasi_layanan) / selesai_layanan[jumlah_pelanggan]) * 100
pelanggan_antre  <- sum(waktu_tunggu > 0)

cat("\n================ RINGKASAN KINERJA SISTEM =========================\n")
cat(sprintf("1. Rata-rata Waktu Tunggu Pelanggan : %.2f menit\n", mean(waktu_tunggu)))
cat(sprintf("2. Waktu Tunggu Maksimum            : %.2f menit\n", max(waktu_tunggu)))
cat(sprintf("3. Rata-rata Total Waktu di Kedai   : %.2f menit\n", mean(total_di_sistem)))
cat(sprintf("4. Pelanggan yang Harus Mengantre   : %d dari %d orang (%.1f%%)\n", 
            pelanggan_antre, jumlah_pelanggan, (pelanggan_antre/jumlah_pelanggan)*100))
cat(sprintf("5. Tingkat Kesibukan Barista        : %.2f%%\n", utilitas_barista))
cat("===================================================================\n")

# 8. Visualisasi Grafik (Otomatis muncul di tab Plots RStudio)
par(mfrow = c(1, 2))

# Grafik 1: Fluktuasi Waktu Tunggu per Pelanggan
plot(tabel_simulasi$Pelanggan, tabel_simulasi$Waktu_Tunggu, 
     type = "b", pch = 19, col = "darkred",
     main = "Waktu Tunggu per Pelanggan",
     xlab = "Urutan Pelanggan", ylab = "Waktu Tunggu (Menit)")
grid()

# Grafik 2: Distribusi Durasi Pelayanan vs Waktu di Sistem
barplot(rbind(tabel_simulasi$Waktu_Tunggu, tabel_simulasi$Durasi_Racik),
        beside = FALSE, col = c("orange", "steelblue"),
        names.arg = tabel_simulasi$Pelanggan,
        main = "Komposisi Waktu Pelanggan",
        xlab = "Urutan Pelanggan", ylab = "Menit",
        legend.text = c("Waktu Antre", "Waktu Racik"),
        args.legend = list(x = "topleft", cex = 0.8))

