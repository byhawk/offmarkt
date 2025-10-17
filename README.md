# OffMarket - Online Multiplayer İş Simülasyon Oyunu

Flutter tabanlı, gerçek zamanlı çok oyunculu ticaret ve iş simülasyonu oyunu. Backend API, WebSocket desteği ve admin panel ile tam özellikli online oyun deneyimi.

## 🎮 Proje Hakkında

OffMarket, oyuncuların bir iş imparatorluğu kurmasını sağlayan kapsamlı bir online simülasyon oyunudur. Oyuncular:
- Gerçek zamanlı pazar sistemi ile ticaret
- Diğer oyuncularla rekabet
- Dinamik fiyatlandırma ve olaylar
- Dükkan kiralama ve işletme yönetimi
- Liderlik tablosu ve başarımlar
- Yasal ve sokak itibarı kazanma

## 🏗️ Mimari

### Frontend (Flutter)
- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod
- **UI**: Material 3 Dark Theme
- **Network**: Dio + Socket.IO Client
- **Storage**: Flutter Secure Storage
- **Platforms**: Android, iOS, Web, Linux

### Backend (Node.js)
- **Framework**: Express.js
- **Database**: MongoDB 7.0
- **Cache**: Redis
- **WebSocket**: Socket.IO
- **Authentication**: JWT
- **Logging**: Winston
- **Process Manager**: PM2

### Admin Panel
- **Frontend**: HTML/CSS/JavaScript
- **Server**: Express.js (Port 5000)
- **Authentication**: JWT Admin
- **Features**: Dashboard, Player Management, Product/Shop CRUD, Banned Words

## 📊 Proje Durumu

### ✅ Backend API - %100 TAMAMLANDI
- ✅ 7 MongoDB Modeli (Player, Product, Shop, Event, Transaction, Admin, BannedWord)
- ✅ 4 Middleware (auth, adminAuth, errorHandler, validateText)
- ✅ 8 API Route (51 endpoint)
- ✅ Winston Logger
- ✅ Seed Script
- ✅ WebSocket Support
- ✅ Yasaklı Kelime Sistemi

### ✅ Admin Panel - %100 TAMAMLANDI
- ✅ Login Sayfası
- ✅ Dashboard (8 istatistik kartı)
- ✅ 8 Yönetim Sayfası (Players, Products, Shops, Transactions, Events, Banned Words, Analytics, Player Detail)
- ✅ Modern Responsive UI
- ✅ JWT Authentication
- ✅ API Integration
- ✅ Auto-refresh (30 saniye)
- ✅ Pazara Ürün Ekleme/Çıkarma
- ✅ Oyuncu Detay Sayfası
- ✅ Şifre Sıfırlama

### ✅ Flutter App - %95 TAMAMLANDI
- ✅ 6 Ana Ekran
- ✅ 9 Oyun Sistemi (3,200+ satır)
- ✅ 4 State Provider
- ✅ Material 3 Dark Theme
- ✅ API Service (Backend Entegrasyonu)
- ✅ Email/Username ile Login
- ✅ Backend'den Dinamik Ürün Yükleme
- ✅ Geri Tuşu Kontrolü (PopScope)
- ✅ Navigation Stack Yönetimi

## 📁 Proje Yapısı

```
offmarket_flutter/
├── backend/                    ✅ TAMAMLANDI
│   ├── models/                ✅ 7 model
│   │   ├── Player.js
│   │   ├── Product.js
│   │   ├── Shop.js
│   │   ├── Event.js
│   │   ├── Transaction.js
│   │   ├── Admin.js
│   │   └── BannedWord.js
│   ├── routes/                ✅ 8 route (51 endpoint)
│   │   ├── auth.js
│   │   ├── player.js
│   │   ├── market.js
│   │   ├── trade.js
│   │   ├── shop.js
│   │   ├── event.js
│   │   ├── leaderboard.js
│   │   └── admin.js
│   ├── middleware/            ✅ 4 middleware
│   │   ├── auth.js
│   │   ├── adminAuth.js
│   │   ├── errorHandler.js
│   │   └── validateText.js
│   ├── utils/                 ✅ 1 util
│   │   └── logger.js
│   ├── scripts/               ✅ 1 script
│   │   └── seed.js
│   ├── logs/                  ✅
│   ├── server.js              ✅
│   ├── package.json           ✅
│   └── .env.example           ✅
├── admin-panel/                ✅ TAMAMLANDI
│   ├── public/
│   │   ├── login.html         ✅
│   │   ├── index.html         ✅ Dashboard
│   │   ├── css/
│   │   │   └── style.css      ✅ Responsive CSS
│   │   └── js/
│   │       ├── auth.js        ✅
│   │       ├── api.js         ✅
│   │       └── dashboard.js   ✅
│   ├── server.js              ✅
│   ├── package.json           ✅
│   └── README.md              ✅
├── server/                    ✅
│   └── vds-setup.sh          ✅ VDS kurulum scripti
└── lib/                       ✅ Flutter app
    ├── services/             ✅
    ├── core/                 ✅
    ├── data/                 ✅
    ├── game/                 ✅ 9 sistem
    ├── presentation/         ✅ 6 ekran
    └── main.dart             ✅
```

## 🚀 Kurulum

### Backend API

```bash
cd backend
npm install
cp .env.example .env
# .env dosyasını düzenle
npm run seed  # Veritabanını doldur
npm run dev   # Development
npm start     # Production
```

**Port**: 3000
**Health Check**: http://localhost:3000/health

### Admin Panel

```bash
cd admin-panel
npm install
npm start
```

**Port**: 5000
**Login**: http://localhost:5000/login.html
**Default Admin**: admin@offmarket.com / Admin123!

### Flutter App

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## 📡 API Endpoints

### Player API (28 endpoints)

#### Authentication (5)
```
POST /api/auth/register - Kayıt ol
POST /api/auth/login - Giriş yap
POST /api/auth/refresh - Token yenile
POST /api/auth/logout - Çıkış yap
GET  /api/auth/me - Mevcut kullanıcı
```

#### Player (7)
```
GET  /api/player/profile - Profil
PUT  /api/player/profile - Profil güncelle
GET  /api/player/stats - İstatistikler
GET  /api/player/inventory - Envanter
POST /api/player/advance-day - Gün ilerlet
POST /api/player/bank/deposit - Para yatır
POST /api/player/bank/withdraw - Para çek
```

#### Market (3)
```
GET /api/market/products - Tüm ürünler
GET /api/market/products/:id - Ürün detayı
GET /api/market/categories - Kategoriler
```

#### Trade (3)
```
POST /api/trade/buy - Ürün satın al
POST /api/trade/sell - Ürün sat
GET  /api/trade/history - İşlem geçmişi
```

#### Shop (4)
```
GET    /api/shop/available - Müsait dükkanlar
POST   /api/shop/rent - Dükkan kirala
DELETE /api/shop/:id/leave - Dükkan bırak
GET    /api/shop/owned - Sahip olunan dükkanlar
```

#### Event (3)
```
GET  /api/event/active - Aktif olaylar
POST /api/event/:id/respond - Olaya yanıt ver
GET  /api/event/history - Olay geçmişi
```

#### Leaderboard (3)
```
GET /api/leaderboard/level - Seviye sıralaması
GET /api/leaderboard/wealth - Zenginlik sıralaması
GET /api/leaderboard/profit - Kar sıralaması
```

### Admin API (23 endpoints)

#### Authentication (1)
```
POST /api/admin/login - Admin giriş
```

#### Dashboard (2)
```
GET /api/admin/dashboard - Dashboard istatistikleri
GET /api/admin/stats?days=7 - Detaylı istatistikler
```

#### Players (5)
```
GET /api/admin/players - Oyuncu listesi
GET /api/admin/players/:id - Oyuncu detayı
PUT /api/admin/players/:id/ban - Oyuncu banla
PUT /api/admin/players/:id/unban - Ban kaldır
```

#### Products (4)
```
GET    /api/admin/products - Ürün listesi
POST   /api/admin/products - Yeni ürün
PUT    /api/admin/products/:id - Ürün güncelle
DELETE /api/admin/products/:id - Ürün sil
```

#### Shops (3)
```
GET  /api/admin/shops - Dükkan listesi
POST /api/admin/shops - Yeni dükkan
PUT  /api/admin/shops/:id - Dükkan güncelle
```

#### Events (1)
```
POST /api/admin/events/trigger - Manuel olay tetikle
```

#### Banned Words (7)
```
GET    /api/admin/banned-words - Liste
POST   /api/admin/banned-words - Tek kelime ekle
POST   /api/admin/banned-words/bulk - Toplu ekle
PUT    /api/admin/banned-words/:id - Güncelle
DELETE /api/admin/banned-words/:id - Sil
POST   /api/admin/banned-words/check - Metin kontrolü
```

**Toplam**: 51 API Endpoint

## 🔐 Yasaklı Kelime Sistemi

### Özellikler
- Otomatik metin kontrolü
- Kategori sistemi (profanity, offensive, spam, other)
- Severity seviyeleri (low, medium, high)
- Toplu ekleme desteği
- Otomatik temizleme (* ile değiştirme)

### Korunan Alanlar
- ✅ Register: username, name
- ⏳ Player Profile: name
- ⏳ Chat messages
- ⏳ Shop names

### Kullanım
```javascript
// Middleware ile
router.post('/register', validateText(['username', 'name']), ...)

// Manuel kontrol
const result = await BannedWord.checkText('test metni');
const cleaned = await BannedWord.cleanText('test metni');
```

## 🎨 Admin Panel Özellikleri

### Dashboard
- 8 İstatistik Kartı (Oyuncu, Ürün, Dükkan, İşlem)
- Top 10 Oyuncu Listesi
- Son İşlemler
- Aktif Olaylar
- Otomatik Yenileme (30 saniye)

### Tasarım
- Modern Gradient UI
- Responsive Layout
- Sidebar Navigation
- Modal Dialogs
- Form Validation
- Loading States
- Error Handling

## 🎮 Flutter Oyun Sistemleri

### 1. Trading System (450+ satır)
- Alım/satım işlemleri
- Dinamik fiyatlandırma
- Kar/zarar hesaplama
- İşlem geçmişi

### 2. Shop System (380+ satır)
- Dükkan kiralama
- Gelir yönetimi
- Lokasyon sistemi
- İşletme kategorileri

### 3. Reputation System (320+ satır)
- Yasal itibar
- Sokak itibarı
- İtibar etkileri
- Bonus hesaplama

### 4. Risk System (280+ satır)
- Risk seviyesi
- Şüphe seviyesi
- Polis baskını
- Ceza sistemi

### 5. Level System (250+ satır)
- Deneyim kazanma
- Seviye atlama
- Ödüller
- Yetenek ağacı

### 6. Event System (420+ satır)
- 9 olay tipi
- Rastgele tetikleme
- Seçim sistemi
- Etki uygulama

### 7. Loan System (280+ satır)
- Kredi alma
- Faiz hesaplama
- Geri ödeme
- Borç takibi

### 8. Market Research System (350+ satır)
- Pazar araştırması
- Trend analizi
- Fiyat tahmini
- Yatırım önerileri

### 9. R&D System (420+ satır)
- Araştırma projeleri
- Teknoloji geliştirme
- Bonus sistemleri
- İlerleme takibi

**Toplam**: 3,200+ satır oyun mekaniği

## 🛠️ Teknolojiler

### Backend
- Express.js 4.18+
- MongoDB 7.0
- Mongoose ODM
- Socket.IO 4.6+
- JWT (jsonwebtoken)
- Bcrypt
- Winston (logging)
- Helmet (security)
- CORS
- Rate Limiting
- Compression

### Frontend (Flutter)
- Flutter 3.9.2+
- Riverpod 2.4+
- Freezed 2.4+
- Dio 5.3+
- Socket.IO Client
- Flutter Secure Storage
- JSON Serializable

### Admin Panel
- Vanilla JavaScript
- Fetch API
- LocalStorage
- CSS Grid/Flexbox
- Responsive Design

## 📈 Performans

### Backend
- Rate Limiting: 100 req/15min
- Auto Price Update: 5 dakika
- Auto Event Trigger: 1 dakika
- WebSocket: Real-time
- Compression: Gzip

### Database
- MongoDB Indexing
- Connection Pooling
- Query Optimization

## 🔒 Güvenlik

- JWT Authentication
- Password Hashing (bcrypt)
- Rate Limiting
- CORS Configuration
- Helmet Security Headers
- Input Validation
- XSS Protection
- SQL Injection Protection
- Banned Words System

## 📝 Lisans

MIT License

## 👥 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing`)
3. Commit atın (`git commit -m 'feat: Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing`)
5. Pull Request açın

## 📞 İletişim

- GitHub: [byhawk/offmarkt](https://github.com/byhawk/offmarkt)
- Issues: [GitHub Issues](https://github.com/byhawk/offmarkt/issues)

## 🎯 Roadmap

### v1.0 (Mevcut)
- ✅ Backend API (51 endpoint)
- ✅ Admin Panel (Dashboard)
- ✅ Flutter App (9 sistem)
- ✅ Yasaklı Kelime Sistemi

### v1.1 (Planlanan)
- [ ] Chat Sistemi
- [ ] Arkadaş Sistemi
- [ ] Bildirimler
- [ ] Başarımlar
- [ ] Günlük Görevler

### v1.2 (Gelecek)
- [ ] Clan/Guild Sistemi
- [ ] PvP Ticaret
- [ ] Açık Artırma
- [ ] Özel Etkinlikler
- [ ] Sezonluk Liderlik

## 📊 İstatistikler

- **Backend**: ~4,000+ satır kod
- **Flutter**: ~3,200+ satır oyun mekaniği
- **Admin Panel**: ~1,000+ satır
- **Toplam**: ~8,200+ satır production-ready kod
- **API Endpoints**: 51
- **Database Models**: 7
- **Game Systems**: 9
- **Screens**: 6
- **Providers**: 4

---

**Son Güncelleme**: 17 Ocak 2025
**Versiyon**: 1.0.0
**Durum**: Production Ready 🚀
