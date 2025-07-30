# Shartflix 🎬

Shartflix, modern Flutter teknolojileriyle geliştirilmiş, kullanıcıların film keşfetmesini, favori filmlerini yönetmesini ve profilini düzenlemesini sağlayan bir film uygulamasıdır. Uygulama, **Clean Architecture**, **MVVM** ve **Bloc** state management prensiplerine uygun şekilde yapılandırılmıştır.

---

## 🚀 Özellikler

### 👤 Kimlik Doğrulama
- Kullanıcı girişi ve kayıt işlemleri
- Token tabanlı oturum yönetimi
- Başarılı girişte otomatik yönlendirme

### 🏠 Ana Sayfa (Keşfet)
- Sonsuz kaydırma (Infinite Scroll)
- Her sayfada 5 film gösterimi
- Otomatik yükleme göstergesi
- Pull-to-refresh desteği
- Favori butonu ile anlık UI güncellemesi

### 🎥 Film Detayları
- Film başlığı, açıklama, çıkış tarihi, puan gibi detaylar

### ❤️ Favoriler
- Favorilere ekleme / çıkarma
- Favori listesi sayfası

### 🧑 Profil Yönetimi
- Kullanıcı bilgilerini görüntüleme
- Profil fotoğrafı yükleme

### 🔀 Navigasyon
- Bottom Navigation Bar ile akıcı sayfa geçişleri
- Ana sayfa state’inin korunması

### 🌐 Çoklu Dil Desteği
- Türkçe 🇹🇷 ve İngilizce 🇬🇧 localization (intl + ARB)

### 🎨 Tema
- Karanlık ve aydınlık tema desteği

### 🧰 Diğer Servisler
- Logger Service
- Navigation Service
- Splash Screen & Uygulama ikonu
- Firebase Crashlytics & Analytics (isteğe bağlı)

---

## 📸 Ekran Görüntüleri

### Giriş Sayfası
![Giriş Sayfası](Screenshots/giris.png)

### Kayıt Ol Sayfası
![Kayıt Ol Sayfası](Screenshots/sign-up.png)

### Admin Giriş Paneli
![Admin Giriş Paneli](Screenshots/admin-log-in.png)![Admin Giriş Paneli](Screenshots/admin-log-in1.png)![Admin Giriş Paneli](Screenshots/admin-log-in2.png)

### Müşteri Ana Sayfası
![Müşteri Ana Sayfası](Screenshots/APPOINTMENTS.png)![Müşteri Ana Sayfası](Screenshots/APPOINTMENTS1.png)![Müşteri Ana Sayfası](Screenshots/APPOINTMENTS2.png)![Müşteri Ana Sayfası](Screenshots/APPOINTMENTS3.png)![Müşteri Ana Sayfası](Screenshots/APPOINTMENTS4.png)

### Randevularım Sayfası
![Kayıt Ol Sayfası](Screenshots/MYAPPTS.png)![Kayıt Ol Sayfası](Screenshots/MYAPPTS1.png)

### Randevu Oluştur Sayfası
![Admin Giriş Paneli](Screenshots/MAKEAPPT.png)

### Çalışma Saatleri ve Tatil Sayfası
![Giriş Sayfası](Screenshots/WORKTIMES.png)

### Geçmiş Randevularım Sayfası
![Kayıt Ol Sayfası](Screenshots/PASTAPPTS.png)

### Profilimi Güncelle Sayfası
![Profilimi Güncelle Sayfası](Screenshots/Profile-update.png)

### Admin Ana Sayfası
![Admin Ana Sayfası](Screenshots/admin.png)![Admin Ana Sayfası](Screenshots/admin1.png)![Admin Ana Sayfası](Screenshots/admin2.png)![Admin Ana Sayfası](Screenshots/admin3.png)![Admin Ana Sayfası](Screenshots/admin4.png)![Admin Ana Sayfası](Screenshots/admin5.png)

### Admin Randevuları Yönet Sayfası
![Admin Randevuları Yönet Sayfası](Screenshots/admin-appts.png)![Admin Randevuları Yönet Sayfası](Screenshots/admin-appts1.png)

### Admin Müşterileri Görüntüle Sayfası
![Admin Müşterileri Görüntüle Sayfası](Screenshots/admin-users.png)

### Admin Çalışma Saatleri ve Tatil Yönet Sayfası
![Admin Çalışma Saatleri ve Tatil Yönet Sayfası](Screenshots/admin-worktimes.png)


## ⚙️ Kurulum ve Çalıştırma

### 1. Projeyi Klonlayın

```bash
git clone <repository-url>
2. Proje dizinine girin
bash
Kopyala
Düzenle
cd shartflix
3. Bağımlılıkları yükleyin
bash
Kopyala
Düzenle
flutter pub get
4. Uygulamayı çalıştırın
bash
Kopyala
Düzenle
flutter run
Emulator veya gerçek cihazın bağlı olduğundan emin olun.

🛠 Kullanılan Teknolojiler
Flutter & Dart

Bloc + MVVM Clean Architecture

REST API ile veri çekme

Lottie animasyonları

Firebase Crashlytics & Analytics (isteğe bağlı)

Localization (intl + ARB)

Logger & Navigation servisleri

🧪 Değerlendirme Kriterleri
✅ Kod kalitesi ve organizasyonu

✅ UI/UX tasarımına uygunluk

✅ Performans ve verimlilik

✅ Best Practice ve Clean Architecture kullanımı

✅ Bonus özelliklerin uygulanması

📬 İletişim
Her türlü soru, öneri ve geri bildirim için bana ulaşabilirsiniz:

📧 yusufbrkk12@gmail.com

💼 LinkedIn Profilim

🤝 Katkıda Bulun
Bu projeye katkıda bulunmak isterseniz:

Fork'layın 🍴

Yeni özellik geliştirin 🔧

Pull request gönderin ✅

⚠️ Not
Bu proje yalnızca teknik değerlendirme amacıyla hazırlanmıştır. Gerçek bir ürün değildir. Kodun bazı bölümleri güvenlik ve gizlilik nedeniyle paylaşılmamıştır.
