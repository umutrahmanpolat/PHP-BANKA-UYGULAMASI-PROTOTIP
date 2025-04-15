-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 11 Nis 2025, 16:18:08
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `banka`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hesaplar`
--

CREATE TABLE `hesaplar` (
  `hesap_id` int(11) NOT NULL,
  `musteri_id` int(11) NOT NULL,
  `hesap_tipi` enum('vadeli','vadesiz','yatırım') NOT NULL,
  `bakiye` decimal(15,2) NOT NULL,
  `para_birimi` enum('Türk Lirası','Euro','Dolar','Sterlin') NOT NULL,
  `acilis_tarihi` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `i̇slem detayları`
--

CREATE TABLE `i̇slem detayları` (
  `detay_id` int(11) NOT NULL,
  `islem_id` int(11) NOT NULL,
  `ilgili_hesap_id` int(11) NOT NULL,
  `yontem` enum('ATM','Şube','Mobil Bankacılık') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `i̇slemler`
--

CREATE TABLE `i̇slemler` (
  `islem_id` int(11) NOT NULL,
  `hesap_id` int(11) NOT NULL,
  `islem_tipi` enum('para yatırma','para çekme','havale') NOT NULL,
  `tutar` decimal(15,2) NOT NULL,
  `islem_tarihi` datetime NOT NULL,
  `aciklama` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanıcılar`
--

CREATE TABLE `kullanıcılar` (
  `kullanıcı_id` int(11) NOT NULL,
  `kullanici_adi` varchar(50) NOT NULL,
  `sifre` varchar(250) NOT NULL,
  `rol_tipi` enum('admin','musteri') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteriler`
--

CREATE TABLE `musteriler` (
  `musteri_id` int(11) NOT NULL,
  `ad` varchar(30) NOT NULL,
  `soyad` varchar(30) NOT NULL,
  `e_posta` int(11) NOT NULL,
  `telefon` varchar(15) NOT NULL,
  `tarih` datetime NOT NULL,
  `adres` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `hesaplar`
--
ALTER TABLE `hesaplar`
  ADD PRIMARY KEY (`hesap_id`),
  ADD KEY `musteri_id` (`musteri_id`);

--
-- Tablo için indeksler `i̇slem detayları`
--
ALTER TABLE `i̇slem detayları`
  ADD PRIMARY KEY (`detay_id`),
  ADD KEY `islem_id` (`islem_id`),
  ADD KEY `ilgili_hesap_id` (`ilgili_hesap_id`);

--
-- Tablo için indeksler `i̇slemler`
--
ALTER TABLE `i̇slemler`
  ADD PRIMARY KEY (`islem_id`),
  ADD KEY `hesap_id` (`hesap_id`);

--
-- Tablo için indeksler `kullanıcılar`
--
ALTER TABLE `kullanıcılar`
  ADD PRIMARY KEY (`kullanıcı_id`),
  ADD UNIQUE KEY `kullanici_adi` (`kullanici_adi`);

--
-- Tablo için indeksler `musteriler`
--
ALTER TABLE `musteriler`
  ADD PRIMARY KEY (`musteri_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `hesaplar`
--
ALTER TABLE `hesaplar`
  MODIFY `hesap_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `i̇slem detayları`
--
ALTER TABLE `i̇slem detayları`
  MODIFY `detay_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `i̇slemler`
--
ALTER TABLE `i̇slemler`
  MODIFY `islem_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `kullanıcılar`
--
ALTER TABLE `kullanıcılar`
  MODIFY `kullanıcı_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `musteriler`
--
ALTER TABLE `musteriler`
  MODIFY `musteri_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `hesaplar`
--
ALTER TABLE `hesaplar`
  ADD CONSTRAINT `hesaplar_ibfk_1` FOREIGN KEY (`musteri_id`) REFERENCES `musteriler` (`musteri_id`);

--
-- Tablo kısıtlamaları `i̇slem detayları`
--
ALTER TABLE `i̇slem detayları`
  ADD CONSTRAINT `i̇slem detayları_ibfk_1` FOREIGN KEY (`islem_id`) REFERENCES `i̇slemler` (`islem_id`);

--
-- Tablo kısıtlamaları `i̇slemler`
--
ALTER TABLE `i̇slemler`
  ADD CONSTRAINT `i̇slemler_ibfk_1` FOREIGN KEY (`hesap_id`) REFERENCES `hesaplar` (`hesap_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
