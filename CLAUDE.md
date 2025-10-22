# OffMarket - Claude Geliştirme Notları

Bu dosya, projenin Claude AI ile geliştirilme sürecini ve teknik detayları içerir.

## 📅 Geliştirme Tarihi

**Başlangıç**: 17 Ocak 2025
**Son Güncelleme**: 22 Ocak 2025 (Flutter State Persistence Fixes ✨)
**Durum**: Production Ready + Asenkron Ekonomi + Flutter App

## 🎯 Proje Özeti

OffMarket, Flutter ve Node.js kullanılarak geliştirilen tam özellikli bir online multiplayer iş simülasyon oyunudur.

### Tamamlanan Bileşenler

#### 1. Backend API (%100)
- **Kod Miktarı**: ~5,200+ satır (+1,200 satır tick sistemi)
- **Modeller**: 8 MongoDB modeli (+1 PendingAction)
- **Routes**: 8 route dosyası
- **Endpoints**: 57 API endpoint (+6 tick-based)
- **Workers**: 1 TickEngine (5s döngü) - NEW ✨
- **Middleware**: 4 middleware
- **Özellikler**:
  - JWT Authentication
  - WebSocket (Socket.IO)
  - Winston Logging
  - Rate Limiting
  - CORS & Helmet Security
  - Yasaklı Kelime Sistemi
  - Auto Price Updates
  - Auto Event Triggers
  - **Tick-Based Asenkron Ekonomi** - NEW ✨
  - **Offline Sales (5s interval)** - NEW ✨
  - **Gerçekçi Satış Simülasyonu** - NEW ✨

#### 2. Admin Panel (%100)
- **Kod Miktarı**: ~1,500+ satır
- **Sayfalar**: 9 sayfa (Login, Dashboard, Players, Products, Shops, Transactions, Events, Banned Words, Player Detail)
- **Özellikler**:
  - Modern Responsive UI
  - JWT Authentication
  - Real-time Stats
  - Auto-refresh (30s)
  - API Integration
  - LocalStorage Token Management
  - Pazara Ürün Ekleme/Çıkarma
  - Oyuncu Detay Sayfası
  - Şifre Sıfırlama

#### 3. Flutter App (%98)
- **Kod Miktarı**: ~5,000+ satır
  - Game Systems: ~1,778 satır
  - Screens: ~2,500 satır
  - Providers: ~600 satır
  - Services: ~300 satır
  - Models & Utils: ~800 satır
- **Ekranlar**: 8 ekran (6 oyun + Login + Register)
- **Sistemler**: 6 oyun sistemi (Trading, Shop, Reputation, Risk, Level, Event)
- **Providers**: 4 state provider (Player, Market, Inventory, Shops)
- **Özellikler**:
  - Material 3 Dark Theme
  - Riverpod State Management (keepAlive fix ✨)
  - Backend API Entegrasyonu (Dio + JWT)
  - Email/Username Login
  - Register with Validation
  - Backend'den Dinamik Ürün Yükleme
  - Real-time Trade (Buy/Sell)
  - Persistent State (logout/login safe)
  - Geri Tuşu Kontrolü (PopScope)
  - Navigation Stack Yönetimi
  - Cross-platform (Android, iOS, Web, Linux)
  - Release Mode Build

## 📊 Teknik Detaylar

### Backend Mimarisi

#### Models (7)
1. **Player.js** (220 satır)
   - Authentication (bcrypt)
   - Game stats (level, exp, cash, bank, debt)
   - Reputation system
   - Risk management
   - Inventory & shops
   - Methods: comparePassword, updateActivity, addExperience, getNetWorth

2. **Product.js** (120 satır)
   - Dynamic pricing
   - Demand & volatility
   - Price history (last 100)
   - Trending status
   - Methods: updatePrice, updateAllPrices, getByCategory, getTrending

3. **Shop.js** (150 satır)
   - Location system
   - Rental management
   - Revenue tracking
   - Business categories
   - Methods: rent, leave, updateRevenue, getAvailable, getPlayerShops

4. **Event.js** (280 satır)
   - 9 event types
   - 10 effect types
   - Choice system
   - Status tracking
   - Methods: complete, expire, createRandomEvent, getActiveEvents

5. **Transaction.js** (150 satır)
   - 12 transaction types
   - Profit tracking
   - Metadata support
   - Methods: createTransaction, getPlayerHistory, calculateTotalProfit

6. **Admin.js** (110 satır)
   - Role system (super_admin, admin, moderator)
   - 8 permission types
   - Login history
   - Methods: comparePassword, updateLogin, hasPermission

7. **BannedWord.js** (100 satır)
   - Category system
   - Severity levels
   - Active/inactive status
   - Methods: checkText, cleanText, addMultiple

8. **PendingAction.js** (254 satır) - NEW ✨
   - Tick-based action queue system
   - 3 action types: AUTO_SELL, LIST_PRODUCT, RESTOCK_ORDER
   - 5 status states: pending, processing, completed, failed, cancelled
   - Recurring action support
   - Retry mechanism (max 3 retries)
   - TTL: 7 days auto-delete
   - Methods: getReadyActions, createAutoSellAction, markProcessing, complete, fail

#### Workers (1) - NEW ✨
1. **TickEngine.js** (368 satır)
   - 5-second game loop engine
   - Asynchronous action processing
   - AUTO_SELL handler: Satış simülasyonu, fiyat elastikiyeti, kar hesaplama
   - LIST_PRODUCT handler: Player → Shop inventory transfer
   - WebSocket notifications (action:completed, sale:completed)
   - Graceful start/stop
   - Stats tracking (tickCounter, uptime)

#### Utils (2)
1. **logger.js**: Winston logging (file + console)
2. **SalesCalculator.js** (251 satır) - NEW ✨
   - Gerçekçi ekonomi satış hesaplama motoru
   - Fiyat elastikiyeti: <90% market = 2.0x satış, >120% = 0.5x satış
   - Zaman çarpanı: Peak hours (18-20) = 1.5x, gece (00-06) = 0.7x
   - Lokasyon çarpanı: Mall 1.5x, Market 1.3x, Street 1.0x, Warehouse 0.8x
   - Mevsimsellik: High 1.2x, Stable 1.0x, Low 0.8x
   - %20 rastgele varyasyon
   - Kar hesaplama: revenue, cost, profit, margin
   - Optimal fiyat önerisi

#### Routes (8 - 57 endpoints)

**Player API (34 endpoints)**:
- auth.js: 5 endpoints (register, login, refresh, logout, me)
- player.js: 7 endpoints (profile, stats, inventory, advance-day, bank)
- market.js: 3 endpoints (products, product detail, categories)
- trade.js: 3 endpoints (buy, sell, history)
- shop.js: 10 endpoints (available, rent, leave, owned, + 6 tick-based) - UPDATED ✨
  - NEW: POST /:shopId/inventory/add (player → shop transfer)
  - NEW: GET /:shopId/inventory (envanter listesi)
  - NEW: PUT /:shopId/inventory/:productId/price (fiyat güncelle)
  - NEW: DELETE /:shopId/inventory/:productId (shop → player geri transfer)
  - NEW: PUT /:shopId/settings (auto-sell ayarları)
  - NEW: GET /:shopId/sales-stats (satış istatistikleri)
- event.js: 3 endpoints (active, respond, history)
- leaderboard.js: 3 endpoints (level, wealth, profit)

**Admin API (23 endpoints)**:
- admin.js: 23 endpoints
  - Login: 1
  - Dashboard: 2
  - Players: 5 (list, detail, ban, unban)
  - Products: 4 (CRUD)
  - Shops: 3 (list, create, update)
  - Events: 1 (trigger)
  - Banned Words: 7 (CRUD + bulk + check)

#### Middleware (4)
1. **auth.js**: JWT player authentication
2. **adminAuth.js**: JWT admin authentication + permissions
3. **errorHandler.js**: Global error handling
4. **validateText.js**: Banned words validation

#### Utils (1)
1. **logger.js**: Winston logging (file + console)

#### Scripts (1)
1. **seed.js**: Database seeding (products, shops, admin)

---

## 🎮 Tick-Based Game System - NEW ✨

OffMarket, **5 saniye tick interval** ile çalışan asenkron bir oyun ekonomisine sahiptir. Bu sistem, oyuncular offline olduğunda bile dükkanların çalışmasına ve satış yapmasına olanak tanır.

### Sistem Mimarisi

```
┌─────────────────────────────────────────────────────────────┐
│                         TickEngine                          │
│                    (5 saniye döngü)                         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      PendingAction                          │
│           (Action Queue / Job Scheduler)                    │
│                                                             │
│  Types: AUTO_SELL, LIST_PRODUCT, RESTOCK_ORDER             │
│  Status: pending → processing → completed/failed           │
└─────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
        ┌───────────────────┐   ┌──────────────────┐
        │   AUTO_SELL       │   │  LIST_PRODUCT    │
        │   Handler         │   │  Handler         │
        └───────────────────┘   └──────────────────┘
                    │
                    ▼
        ┌───────────────────────────┐
        │   SalesCalculator         │
        │   (Ekonomi Motoru)        │
        │                           │
        │  • Fiyat Elastikiyeti     │
        │  • Zaman Çarpanı          │
        │  • Lokasyon Faktörü       │
        │  • Mevsimsellik           │
        │  • Random Varyasyon       │
        └───────────────────────────┘
                    │
                    ▼
        ┌───────────────────────────┐
        │   Shop Inventory          │
        │   Player Cash             │
        │   Sales Stats             │
        └───────────────────────────┘
                    │
                    ▼
        ┌───────────────────────────┐
        │   WebSocket Notification  │
        │   (Real-time Update)      │
        └───────────────────────────┘
```

### Tick Döngüsü Akışı

**Her 5 saniyede bir:**

1. **TickEngine.tick()** çalışır
2. **PendingAction.getReadyActions(100)** ile zamanı gelen action'lar alınır
3. Her action paralel olarak işlenir (Promise.allSettled)
4. **AUTO_SELL** action'lar:
   - Shop inventory'sini tarar
   - Her ürün için **SalesCalculator.calculateSalesPerTick()** çağırır
   - Satış miktarını hesaplar (fiyat elastikiyeti, zaman, lokasyon, vb.)
   - Shop inventory'den stok düşer
   - Player'a para eklenir
   - Sales stats güncellenir
   - Recurring action için yeni PendingAction oluşturur
5. **WebSocket** ile oyuncuya bildirim gönderir
6. Logs yazdırır (Winston)

### Ekonomi Formülü

```javascript
salesVelocity = baseDemand
  × priceElasticity
  × timeMultiplier
  × locationMultiplier
  × seasonalityMultiplier
  × randomVariation (0.8-1.2)

soldQuantity = min(floor(salesVelocity), availableStock)
```

#### Fiyat Elastikiyeti Tablosu

| Fiyat (Market Fiyatına Göre) | Elastikiyet | Satış Hızı |
|------------------------------|-------------|------------|
| < %90 (indirimli)            | 2.0         | Çok hızlı  |
| %90-100 (normal)             | 1.0-1.2     | Normal     |
| %100-120 (hafif pahalı)      | 0.5-1.0     | Yavaş      |
| %120-150 (pahalı)            | 0.3         | Çok yavaş  |
| > %150 (aşırı pahalı)        | 0.1         | Neredeyse hiç |

#### Zaman Çarpanları

| Zaman Dilimi | Saat | Çarpan | Açıklama |
|--------------|------|--------|----------|
| Gece         | 00-06 | 0.7    | Az satış |
| Sabah        | 07-11 | 0.9    | Orta     |
| Öğlen        | 12-17 | 1.0    | Normal   |
| Peak Hours   | 18-20 | 1.5    | Yüksek   |
| Akşam        | 21-23 | 1.0    | Normal   |

#### Lokasyon Çarpanları

| Lokasyon Tipi | Çarpan | Örnek          |
|---------------|--------|----------------|
| Mall          | 1.5x   | AVM            |
| Market        | 1.3x   | Pazar yeri     |
| Street        | 1.0x   | Sokak dükkanı  |
| Office        | 0.9x   | Ofis bölgesi   |
| Warehouse     | 0.8x   | Depo           |

### Action Types

#### 1. AUTO_SELL
- **Amaç**: Dükkan envanterindeki ürünleri otomatik sat
- **Recurring**: Evet (her tick'te yeniden schedule edilir)
- **İşlem**:
  1. Shop inventory'deki her ürün için satış hesapla
  2. Stock'tan düş
  3. Player'a para ekle
  4. Sales stats güncelle
  5. WebSocket bildirimi

#### 2. LIST_PRODUCT
- **Amaç**: Player inventory → Shop inventory transfer
- **Recurring**: Hayır
- **İşlem**:
  1. Player inventory'den ürünü çıkar
  2. Shop inventory'ye ekle
  3. Eğer aynı ürün varsa quantity birleştir

#### 3. RESTOCK_ORDER (Gelecekte)
- **Amaç**: Otomatik stok yenileme
- **Recurring**: Evet
- **İşlem**: Henüz implement edilmedi

### WebSocket Events

TickEngine her işlemden sonra oyuncuya real-time bildirim gönderir:

```javascript
// Genel action tamamlama bildirimi
io.to(`player:${playerId}`).emit('action:completed', {
  actionType: 'AUTO_SELL',
  result: { soldQuantity, earnedMoney, profit },
  timestamp: new Date()
});

// Satış özel bildirimi
io.to(`player:${playerId}`).emit('sale:completed', {
  soldQuantity: 15,
  earnedMoney: 1250.50,
  profit: 450.00,
  details: [
    { productName: 'iPhone', sold: 5, revenue: 500, profit: 150 },
    { productName: 'Laptop', sold: 10, revenue: 750.50, profit: 300 }
  ],
  timestamp: new Date()
});
```

### Offline Sales

**Önemli:** Oyuncular offline olsa bile dükkanlar çalışmaya devam eder!

- TickEngine sürekli çalışır (server uptime boyunca)
- AUTO_SELL action'lar her 5 saniyede işlenir
- Oyuncu geri geldiğinde tüm kazançları bekliyor olur
- WebSocket bildirimleri kaybolsa bile database'de kaydedilir

### Database Schema Updates

#### Product Model (Yeni Alanlar)
```javascript
{
  baseDemand: Number,        // Tick başına taban talep (1-100)
  peakHours: [Number],       // Yoğun saatler [18, 19, 20]
  seasonality: String        // 'stable', 'high', 'low'
}
```

#### Shop Model (Yeni ShopInstance)
```javascript
{
  inventory: [{
    productId: ObjectId,
    quantity: Number,
    purchasePrice: Number,   // Kar hesabı için
    sellPrice: Number,       // Satış fiyatı
    totalSold: Number,
    lastSoldAt: Date
  }],
  salesStats: {
    todaySales: Number,
    totalRevenue: Number,
    totalProfit: Number,
    avgSalePrice: Number,
    totalItemsSold: Number
  },
  settings: {
    autoSellEnabled: Boolean,
    minProfitMargin: Number,
    maxStockPerProduct: Number
  }
}
```

### Performance & Scalability

- **Batch Processing**: 100 action'a kadar paralel işleme
- **Promise.allSettled**: Bir hata tüm tick'i durdurmuyor
- **Indexing**: scheduledFor ve status için MongoDB index
- **TTL**: 7 gün sonra otomatik silme (completed action'lar)
- **Graceful Shutdown**: SIGTERM ile clean stop

### Monitoring

```bash
# Health check (TickEngine stats dahil)
curl http://localhost:3000/health

# Response:
{
  "status": "OK",
  "tickEngine": {
    "isRunning": true,
    "tickCounter": 720,      # 720 tick = 1 saat
    "tickInterval": 5000,    # 5 saniye
    "uptime": 3600          # saniye
  }
}
```

### Log Örnekleri

```
[info] MongoDB connected
[info] TickEngine started with 5s interval
[info] 🚀 TickEngine started with 5000ms interval
[info] ⏰ Tick #1 started
[info] Tick #1: Processing 15 actions
[info] ✅ Tick #1 completed in 234ms | Success: 15, Failed: 0
[info] ⏰ Tick #2 started
[info] Tick #2: No pending actions
```

### Commit Timeline (5 commits)

1. **1f5d0a9**: PendingAction model + Product/Shop updates
2. **38f6d19**: SalesCalculator utility
3. **9fe231d**: TickEngine worker (5s döngü)
4. **32ad2f6**: Shop API endpoints (6 tick-based endpoint)
5. **f75ba5f**: Server.js entegrasyonu + graceful shutdown

---

### Admin Panel Mimarisi

#### Structure
```
admin-panel/
├── public/
│   ├── login.html          # Login page
│   ├── index.html          # Dashboard
│   ├── css/
│   │   └── style.css       # ~600 satır responsive CSS
│   └── js/
│       ├── auth.js         # Authentication logic
│       ├── api.js          # API requests
│       └── dashboard.js    # Dashboard logic
├── server.js               # Express static server
└── package.json
```

#### Features
- **Login System**: JWT token + LocalStorage
- **Dashboard**: 8 stat cards, top players, transactions, events
- **Auto-refresh**: 30 seconds
- **Responsive**: Mobile-friendly
- **Modern UI**: Gradient design, animations

### Flutter App Mimarisi

#### Game Systems (9 - 3,200+ satır)

1. **TradingSystem** (450+ satır)
   - Buy/sell operations
   - Dynamic pricing
   - Profit/loss calculation
   - Transaction history

2. **ShopSystem** (380+ satır)
   - Shop rental
   - Revenue management
   - Location types
   - Business categories

3. **ReputationSystem** (320+ satır)
   - Legal reputation
   - Street reputation
   - Reputation effects
   - Bonus calculations

4. **RiskSystem** (280+ satır)
   - Risk level
   - Suspicion level
   - Police raids
   - Penalty system

5. **LevelSystem** (250+ satır)
   - Experience gain
   - Level up
   - Rewards
   - Skill tree

6. **EventSystem** (420+ satır)
   - 9 event types
   - Random triggers
   - Choice system
   - Effect application

7. **LoanSystem** (280+ satır)
   - Loan taking
   - Interest calculation
   - Repayment
   - Debt tracking

8. **MarketResearchSystem** (350+ satır)
   - Market research
   - Trend analysis
   - Price prediction
   - Investment recommendations

9. **R&DSystem** (420+ satır)
   - Research projects
   - Technology development
   - Bonus systems
   - Progress tracking

## 🔐 Güvenlik Özellikleri

### Backend Security
1. **Authentication**
   - JWT tokens (access + refresh)
   - Password hashing (bcrypt, 10 rounds)
   - Token expiration (7 days)

2. **Authorization**
   - Role-based access control (RBAC)
   - Permission system
   - Admin/Player separation

3. **Input Validation**
   - Express-validator
   - Banned words system
   - XSS protection
   - SQL injection protection

4. **Rate Limiting**
   - 100 requests per 15 minutes
   - Per IP address
   - Configurable

5. **Security Headers**
   - Helmet.js
   - CORS configuration
   - Content Security Policy

### Banned Words System
- **Purpose**: Prevent offensive content
- **Features**:
  - Category system (profanity, offensive, spam, other)
  - Severity levels (low, medium, high)
  - Bulk import
  - Auto-cleaning (* replacement)
- **Protected Fields**:
  - Username (register)
  - Player name
  - Chat messages (future)
  - Shop names (future)

## 📈 Performans Optimizasyonları

### Backend
1. **Database**
   - MongoDB indexing
   - Connection pooling
   - Query optimization

2. **Caching**
   - Redis ready
   - In-memory caching

3. **Compression**
   - Gzip compression
   - Response optimization

4. **WebSocket**
   - Socket.IO rooms
   - Event-based updates
   - Broadcast optimization

### Frontend
1. **State Management**
   - Riverpod providers
   - Lazy loading
   - Efficient rebuilds

2. **Network**
   - Dio HTTP client
   - Request caching
   - Auto retry

## 🚀 Deployment

### Backend Deployment
```bash
# PM2 ile production
pm2 start server.js --name offmarket-api
pm2 save
pm2 startup

# Nginx reverse proxy
# /etc/nginx/sites-available/offmarket
server {
    listen 80;
    server_name api.offmarket.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# SSL
sudo certbot --nginx -d api.offmarket.com
```

### Admin Panel Deployment
```bash
# PM2 ile
pm2 start server.js --name offmarket-admin --cwd /path/to/admin-panel
pm2 save

# Nginx
server {
    listen 80;
    server_name admin.offmarket.com;
    
    location / {
        proxy_pass http://localhost:5000;
    }
}
```

### Flutter Deployment
```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (macOS gerekli)
flutter build ios --release

# Web
flutter build web --release

# Linux
flutter build linux --release
```

## 📝 Geliştirme Notları

### Önemli Kararlar

1. **Neden Riverpod?**
   - Type-safe
   - Compile-time safety
   - Better testing
   - Provider composition

2. **Neden MongoDB?**
   - Flexible schema
   - JSON-like documents
   - Easy scaling
   - Good for game data

3. **Neden Socket.IO?**
   - Real-time updates
   - Automatic reconnection
   - Room support
   - Fallback mechanisms

4. **Neden JWT?**
   - Stateless
   - Scalable
   - Cross-domain
   - Mobile-friendly

### Karşılaşılan Zorluklar

1. **Dynamic Pricing**
   - Çözüm: Demand & volatility based algorithm
   - Auto-update every 5 minutes

2. **Event System**
   - Çözüm: Effect-based system with choices
   - Flexible and extensible

3. **Banned Words**
   - Çözüm: Regex-based checking
   - Middleware integration

4. **Admin Panel**
   - Çözüm: Vanilla JS for simplicity
   - Easy to maintain

5. **Flutter State Persistence** (22 Ocak 2025) ⚠️ KRİTİK
   - **Problem**: Riverpod provider state her rebuild'de reset oluyordu
   - **Semptom**: Backend doğru veri dönüyor ama UI yanlış gösteriyordu
   - **Root Cause**: `build()` metodu her widget rebuild'inde çağrılıyor
   - **Çözüm**: `@Riverpod(keepAlive: true)` annotation eklendi
   - **Sonuç**: State artık kalıcı, logout/login safe
   - **Öğrenilen**: Riverpod lifecycle'ı Redux'tan farklı, build() initialization değil!

## 🎯 Gelecek Planları

### v1.3 (Yakın Gelecek - Şubat 2025)
- [ ] Unit Tests (Flutter game systems)
- [ ] Widget Tests (UI components)
- [ ] Android APK Build (Release)
- [ ] Play Store Hazırlık
- [ ] Performance Optimizasyonları
- [ ] UI Polish & Animations

### v1.4 (Mart 2025)
- [ ] WebSocket Real-time Updates (Flutter side)
- [ ] Push Notifications
- [ ] Daily Quests
- [ ] Achievements System
- [ ] Leaderboards UI

### v1.5 (Nisan 2025)
- [ ] Chat System
- [ ] Friend System
- [ ] Clan/Guild System
- [ ] PvP Trading
- [ ] Auction House

### v2.0 (Uzun Vadeli)
- [ ] iOS Release
- [ ] Web Version
- [ ] Advanced Analytics Dashboard
- [ ] AI-powered NPCs
- [ ] Seasonal Events
- [ ] Premium Features

## 📊 Kod İstatistikleri

### Backend
- **Toplam Satır**: ~5,200+
- **Models**: 1,284 satır (8 model) - +254 satır (PendingAction)
- **Routes**: 1,565 satır - +285 satır (Tick-based shop endpoints)
- **Workers**: 368 satır (TickEngine) - NEW ✨
- **Utils**: 311 satır - +251 satır (SalesCalculator)
- **Middleware**: 300 satır
- **Scripts**: 130 satır
- **Server**: 200 satır - +20 satır (TickEngine entegrasyonu)

### Admin Panel
- **Toplam Satır**: ~1,000+
- **HTML**: 300 satır
- **CSS**: 600 satır
- **JavaScript**: 400 satır

### Flutter App
- **Game Systems**: ~1,778 satır (6 sistem)
- **Screens**: ~2,500 satır (8 ekran)
- **Providers**: ~600 satır (4 provider + entegrasyon)
- **Services**: ~300 satır (API, Auth)
- **Models & Utils**: ~800 satır
- **Toplam Flutter**: ~5,000+ satır

### Toplam Proje
- **Backend Code**: ~6,400+ satır (API + TickEngine)
- **Admin Panel**: ~1,500+ satır
- **Flutter App**: ~5,000+ satır
- **Production Code**: ~12,900+ satır
- **Test Code**: ~500 satır (planlanan)
- **Documentation**: ~3,500+ satır (README, CLAUDE, FLUTTER_MIGRATION)

## 🛠️ Kullanılan Araçlar

### Development
- **IDE**: VS Code + Flutter Extension
- **Version Control**: Git
- **API Testing**: Postman
- **Database**: MongoDB Compass
- **Redis**: Redis Commander
- **Flutter**: 3.27.0+ (stable)
- **Dart**: 3.6.0+
- **Android Testing**: USB Debug (M2101K7BG)

### Deployment
- **Server**: Ubuntu 22.04 LTS
- **Process Manager**: PM2
- **Web Server**: Nginx
- **SSL**: Let's Encrypt (Certbot)
- **Monitoring**: PM2 Monitor

### CI/CD (Planlanan)
- GitHub Actions
- Docker
- Kubernetes (future)

## 📚 Öğrenilen Dersler

1. **Modüler Mimari**: Her şeyi küçük, yönetilebilir parçalara böl
2. **Error Handling**: Global error handler hayat kurtarır
3. **Logging**: Winston ile detaylı loglama çok önemli
4. **Security**: Güvenlik baştan düşünülmeli
5. **Documentation**: İyi dokümantasyon zaman kazandırır
6. **Testing**: Test yazmak uzun vadede zaman kazandırır
7. **Git Commits**: Anlamlı commit mesajları önemli
8. **Riverpod State Lifecycle**: `build()` metodu initialization değil, factory metodu. `keepAlive: true` kritik!
9. **Debug Logs Everywhere**: Her kritik state transition noktasına emoji'li log ekle (🔄, ✅, ❌, 📦)
10. **Backend Endpoint Consistency**: Login endpoint'i partial data, `/auth/me` full data döner
11. **Hard Analyze**: Standart çözümler işe yaramazsa, log'ları derinlemesine incele
12. **MongoDB Direct Access**: Backend test için database'i doğrudan kontrol et

## 🎓 Referanslar

### Backend
- [Express.js Docs](https://expressjs.com/)
- [MongoDB Docs](https://docs.mongodb.com/)
- [Socket.IO Docs](https://socket.io/docs/)
- [JWT.io](https://jwt.io/)

### Flutter
- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev/)
- [Dio Docs](https://pub.dev/packages/dio)

### Best Practices
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)

---

**Geliştirici**: Claude AI + Human Developer
**Başlangıç**: 17 Ocak 2025
**Tick System**: 20 Ocak 2025
**State Persistence Fix**: 22 Ocak 2025
**Versiyon**: 1.2.0 (Flutter App + State Persistence)
**Durum**: Production Ready + Asenkron Ekonomi + Flutter App 🚀

---

## 🐛 Flutter State Persistence Debugging Session - 22 Ocak 2025

### Karşılaşılan Kritik Hatalar

#### Problem 1: Player Cash Yanlış Gösterim
**Semptom**: Backend 765.98 TL döndürüyor ama UI 5000 TL veya 0 TL gösteriyordu.

**Tespit Süreci**:
```bash
# Backend logs
🔄 Refreshing player data: cash=765.9808798028143
💾 Player data loaded: cash=765.9808798028143
✅ Player refreshed: cash=765.9808798028143

# UI logs
🏠 HomeScreen: Player cash = 5000.0  ← YANLIŞ!
```

**Root Cause**:
Riverpod'un `build()` metodu her widget rebuild'inde tekrar çağrılıyor ve default değerler döndürüyordu. Backend'den yüklenen state, sonraki rebuild'lerde `build()` metodu tarafından eziliyordu.

**Çözüm**:
```dart
@Riverpod(keepAlive: true)  // ← CRITICAL FIX
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build() {
    // Build artık SADECE bir kez çalışır
    return const Player(
      name: 'Yükleniyor...',
      level: 1,
      cash: 0.0,  // Default değer artık kalıcı değil
      // ...
    );
  }
}
```

**Etkilenen Dosyalar**:
- `lib/presentation/providers/player_provider.dart`
- `lib/presentation/providers/market_provider.dart` (InventoryNotifier)

**Sonuç**: ✅ Cash değeri doğru gösteriliyor ve oyun boyunca persist ediyor.

---

#### Problem 2: Inventory Görünmüyor
**Semptom**: Backend 1 adet ürün döndürüyor ama InventoryScreen boş gösteriyordu.

**Tespit Süreci**:
```bash
📦 Loading inventory from backend: 1 items
  - ProductID: 68f3b60a9680b77a06b856a0, Quantity: 1
✅ Inventory loaded: 1 items in state
📦 InventoryScreen: 0 items in inventory  ← YANLIŞ!
```

**Root Cause**: Aynı `keepAlive` sorunu. `InventoryNotifier.build()` her rebuild'de boş liste `[]` döndürüyordu.

**Çözüm**:
```dart
@Riverpod(keepAlive: true)  // ← CRITICAL FIX
class InventoryNotifier extends _$InventoryNotifier {
  @override
  List<InventoryItem> build() {
    loadInventoryFromBackend();
    return [];  // Artık sadece ilk kez döndürülür
  }

  Future<void> loadInventoryFromBackend() async {
    // Backend'den yükle ve state'i güncelle
    final response = await apiService.get('/auth/me');
    state = inventoryList.map(...).toList();
    print('✅ Inventory loaded: ${state.length} items');
  }
}
```

**Sonuç**: ✅ Inventory item'ları doğru gösteriliyor.

---

#### Problem 3: Login Sonrası Eksik Player Data
**Semptom**: `/auth/login` endpoint'i sadece temel alanlar döndürüyordu (name, bankAccount, debt eksikti).

**Tespit Süreci**:
Backend `/auth/login` endpoint'i sadece id, username, email, level, cash gibi temel alanlar döndürüyordu. `totalProfit`, `portfolioValue` gibi alanlar eksikti.

**Çözüm**:
```dart
// LoginScreen ve SplashScreen
Future<void> _login() async {
  await authService.login(email: email, password: password);

  // ✅ Tam player verisini yükle
  await ref.read(playerNotifierProvider.notifier).refreshPlayerData();

  Navigator.pushReplacement(...);
}
```

`refreshPlayerData()` metodu `/auth/me` endpoint'ini çağırarak tüm player verilerini yükler.

**Sonuç**: ✅ Login sonrası tüm player field'ları doğru yükleniyor.

---

#### Problem 4: Username ile Login Olmuyor
**Semptom**: Sadece email ile login olabiliyordu, username çalışmıyordu.

**Root Cause**:
- `AuthService.login()` sadece `email` parametresi kabul ediyordu
- Backend aslında hem email hem username destekliyordu

**Çözüm**:
```dart
// auth_service.dart
Future<Map<String, dynamic>> login({
  String? email,
  String? username,  // ← YENİ
  required String password,
}) async {
  final Map<String, dynamic> loginData = {'password': password};

  // Email veya username
  if (email != null && email.isNotEmpty) {
    loginData['email'] = email;
  } else if (username != null && username.isNotEmpty) {
    loginData['username'] = username;
  }

  final response = await _dio.post('${ApiConstants.auth}/login', data: loginData);
  // ...
}

// login_screen.dart
final input = _emailOrUsernameController.text.trim();
final isEmail = input.contains('@');

await authService.login(
  email: isEmail ? input : null,
  username: isEmail ? null : input,
  password: _passwordController.text,
);
```

**Sonuç**: ✅ Hem email hem username ile login çalışıyor.

---

### Öğrenilen Dersler

#### 1. Riverpod `keepAlive` Flag
**Önemli**: Riverpod'da `build()` metodu bir initialization metodu DEĞİLDİR. Her provider rebuild'inde tekrar çağrılır.

```dart
// ❌ YANLIŞ: keepAlive olmadan
@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build() {
    // Her rebuild'de çağrılır → state reset olur
    return const Player(cash: 5000.0);
  }
}

// ✅ DOĞRU: keepAlive ile
@Riverpod(keepAlive: true)
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build() {
    // Sadece bir kez çağrılır → state korunur
    return const Player(cash: 0.0);
  }
}
```

#### 2. Backend Endpoint Consistency
- `/auth/login` → Partial data (sadece auth için)
- `/auth/me` → Full player data (tüm oyun state'i)

**Best Practice**: Login sonrası her zaman `/auth/me` çağır.

#### 3. Debug Logging Strategy
Her kritik state transition noktasına log ekle:

```dart
// Backend load
print('🔄 Refreshing player data: cash=${playerData['cash']}');
await loadPlayerFromBackend(playerData);
print('✅ Player refreshed: cash=${state.cash}');

// UI read
print('🏠 HomeScreen: Player cash = ${player.cash}');
```

Bu sayede state'in hangi noktada yanlış olduğunu tespit etmek kolay.

#### 4. MongoDB Direct Access for Testing
Backend testleri için:
```bash
mongosh offmarket_db
db.players.find({}, {username: 1, cash: 1, inventory: 1})
```

---

### Test Senaryoları

✅ **Senaryo 1: Logout → Login → Data Persist**
1. Pazardan 1 ürün al (cash azalır)
2. Logout yap
3. Login yap
4. ✅ Cash ve inventory aynı kalıyor

✅ **Senaryo 2: Uygulamayı Kapat → Aç**
1. Ürün al
2. Uygulamayı kapat
3. Tekrar aç
4. ✅ Veriler korunuyor

✅ **Senaryo 3: Username Login**
1. Kullanıcı adı ile giriş yap
2. ✅ Başarılı

✅ **Senaryo 4: Email Login**
1. Email ile giriş yap
2. ✅ Başarılı

---

### Kod Değişiklikleri Özeti

| Dosya | Değişiklik | Satır Sayısı |
|-------|-----------|--------------|
| `player_provider.dart` | `@Riverpod(keepAlive: true)` eklendi | +1 |
| `market_provider.dart` | `@Riverpod(keepAlive: true)` eklendi (InventoryNotifier) | +1 |
| `auth_service.dart` | `username` parametresi eklendi | +10 |
| `login_screen.dart` | Email/username detection eklendi | +5 |
| `main.dart` | `refreshPlayerData()` çağrısı eklendi (SplashScreen) | +1 |
| `home_screen.dart` | Logout'ta `reset()` çağrısı eklendi | +2 |
| **TOPLAM** | | **+20 satır** |

---

## Changelog

### v1.2.0 - State Persistence Fixes (22 Ocak 2025)
- 🐛 **Riverpod keepAlive Fix**: PlayerProvider ve InventoryProvider state artık persist ediyor
- 🐛 **Full Player Data Loading**: Login ve startup'ta `/auth/me` ile tam veri yükleme
- ✨ **Username Login Support**: Email ve username ile login desteği
- 🔧 **Reset on Logout**: Logout'ta provider state temizleme
- 📊 **Debug Logging**: State lifecycle tracking için detaylı loglar
- ✅ **4 Kritik Bug Fix**: Cash, Inventory, Login, Persistence sorunları çözüldü
- 📝 **Documentation**: README.md ve CLAUDE.md'ye bug fix dökümanları eklendi

### v1.1.0 - Tick-Based Economy (20 Ocak 2025)
- ✨ **TickEngine**: 5 saniye interval ile asenkron oyun döngüsü
- ✨ **PendingAction Model**: Queue-based action sistemi
- ✨ **SalesCalculator**: Gerçekçi ekonomi simülasyon motoru
- ✨ **Offline Sales**: Oyuncular offline olsa bile satış devam eder
- ✨ **6 Tick-Based API Endpoints**: Inventory yönetimi, fiyat güncelleme, stats
- 🔧 **Product Model**: baseDemand, peakHours, seasonality alanları
- 🔧 **Shop Model**: inventory, salesStats, settings sistemi
- 📊 **Real-time WebSocket**: action:completed, sale:completed events
- 📈 **1,200+ satır**: Yeni kod (5 commit)

### v1.0.0 - Initial Release (17 Ocak 2025)
- 🎮 Backend API (51 endpoint)
- 🎨 Admin Panel (9 sayfa)
- 📱 Flutter App (6 ekran, 9 sistem)
- 🔐 JWT Authentication
- 💬 WebSocket Support
- 📊 8,200+ satır kod
