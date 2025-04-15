<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);


$sunucu = "localhost";
$kullanici = "root";
$sifre = "";
$veritabaniAdi = "banka";


$baglanti = new mysqli($sunucu, $kullanici, $sifre, $veritabaniAdi);
if ($baglanti->connect_error) {
    die("Bağlantı hatası: " . $baglanti->connect_error);
}
$baglanti->set_charset("utf8");


$adim = 1;


if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['ad']) && isset($_POST['soyad']) && isset($_POST['e_posta']) && isset($_POST['telefon'])) {
    $ad = $_POST['ad'];
    $soyad = $_POST['soyad'];
    $e_posta = $_POST['e_posta'];
    $telefon = $_POST['telefon'];
    $tarih = $_POST['tarih'];
    $adres = $_POST['adres'];

    $sorgu = $baglanti->prepare("INSERT INTO musteriler (ad, soyad, e_posta, telefon, tarih, adres) VALUES (?, ?, ?, ?, ?, ?)");
    if ($sorgu) {
        $sorgu->bind_param("ssssss", $ad, $soyad, $e_posta, $telefon, $tarih, $adres);
        $sorgu->execute();
        $_SESSION['musteri_id'] = $baglanti->insert_id; 
        $sorgu->close();
        $adim = 2; 
    } else {
        echo "Sorgu hatası: " . $baglanti->error;
    }
}


if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['hesap_tipi']) && isset($_POST['bakiye']) && isset($_POST['para_birimi']) && isset($_POST['acilis_tarihi'])) {
    $hesap_tipi = $_POST['hesap_tipi'];
    $bakiye = $_POST['bakiye'];
    $para_birimi = $_POST['para_birimi'];
    $acilis_tarihi = $_POST['acilis_tarihi'];
    $musteri_id = $_SESSION['musteri_id'] ?? null;

    if ($musteri_id) {
        $sorgu1 = $baglanti->prepare("INSERT INTO hesaplar (musteri_id, hesap_tipi, bakiye, para_birimi, acilis_tarihi) VALUES (?, ?, ?, ?, ?)");
        if ($sorgu1) {
            $sorgu1->bind_param("issss", $musteri_id, $hesap_tipi, $bakiye, $para_birimi, $acilis_tarihi);
            $sorgu1->execute();
            $sorgu1->close();
            echo "<p style='color:green;'>Tüm kayıtlar başarıyla eklendi.</p>";
            unset($_SESSION['musteri_id']); 
            $adim = 1; 
        } else {
            echo "Sorgu hatası: " . $baglanti->error;
        }
    } else {
        echo "<p style='color:red;'>Müşteri bilgisi eksik!</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>2 Aşamalı Form</title>
</head>
<body>
<h2>Banka Müşteri Kayıt</h2>

<?php if ($adim == 1): ?>

<form method="POST">
    <label>Ad:</label><br>
    <input type="text" name="ad" required><br><br>

    <label>Soyad:</label><br>
    <input type="text" name="soyad" required><br><br>

    <label>E-Posta:</label><br>
    <input type="email" name="e_posta" required><br><br>

    <label>Telefon:</label><br>
    <input type="text" name="telefon" required><br><br>

    <label>Doğum Tarihi:</label><br>
    <input type="date" name="tarih" required><br><br>

    <label>Adres:</label><br>
    <input type="text" name="adres" required><br><br>

    <input type="submit" value="Müşteri Kaydet">
</form>

<?php elseif ($adim == 2): ?>

<form method="POST">
    <label>Hesap Tipi:</label><br>
    <select name="hesap_tipi" required>
        <option value="">Seçiniz</option>
        <option value="Vadeli">Vadeli</option>
        <option value="Vadesiz">Vadesiz</option>
        <option value="Yatırım">Yatırım</option>
    </select><br><br>

    <label>Bakiye:</label><br>
    <input type="text" name="bakiye" required><br><br>

    <label>Para Birimi:</label><br>
    <select name="para_birimi" required>
        <option value="">Seçiniz</option>
        <option value="Türk Lirası">Türk Lirası</option>
        <option value="Euro">Euro</option>
        <option value="Dolar">Dolar</option>
        <option value="Sterlin">Sterlin</option>
    </select><br><br>

    <label>Açılış Tarihi:</label><br>
    <input type="date" name="acilis_tarihi" required><br><br>

    <input type="submit" value="Hesap Kaydet">
</form>
<?php endif; ?>

</body>
</html>
