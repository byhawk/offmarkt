# OffMarket Backend Yapısı

## Tamamlanan Dosyalar

### ✅ Oluşturulan Dosyalar
1. `server/vds-setup.sh` - VDS kurulum scripti
2. `backend/package.json` - Backend bağımlılıkları
3. `backend/.env.example` - Ortam değişkenleri şablonu
4. `backend/server.js` - Ana sunucu dosyası
5. `backend/models/Player.js` - Oyuncu veritabanı modeli

## Oluşturulması Gereken Dosyalar

### Models (backend/models/)
```
Product.js - Ürün modeli
Shop.js - Dükkan modeli
Market.js - Pazar modeli
Event.js - Olay modeli
Transaction.js - İşlem geçmişi
Admin.js - Admin kullanıcı modeli
```

### Routes (backend/routes/)
```
auth.js - Kayıt/Giriş/Token yenileme
player.js - Oyuncu profil ve istatistikler
market.js - Pazar ürünleri ve fiyatlar
shop.js - Dükkan kiralama/yönetim
trade.js - Alım-satım işlemleri
event.js - Oyun olayları
leaderboard.js - Liderlik tablosu
admin.js - Admin panel API'leri
```

### Middleware (backend/middleware/)
```
auth.js - JWT doğrulama
adminAuth.js - Admin yetkilendirme
errorHandler.js - Hata yakalama
validator.js - Veri doğrulama
```

### Utils (backend/utils/)
```
logger.js - Winston logger
gameLogic.js - Oyun hesaplamaları
socketManager.js - WebSocket yönetimi
```

### Scripts (backend/scripts/)
```
seed.js - Veritabanı başlangıç verisi
createAdmin.js - Admin kullanıcı oluştur
```

## Admin Panel Yapısı

### Admin Panel (admin-panel/)
```
package.json
server.js - Admin panel sunucusu
public/
  index.html
  css/
  js/
    dashboard.js
    players.js
    products.js
    shops.js
    events.js
    settings.js
```

## Flutter Entegrasyonu

### Gerekli Paketler (pubspec.yaml)
```yaml
dependencies:
  http: ^1.1.0
  dio: ^5.4.0
  socket_io_client: ^2.0.3+1
  flutter_secure_storage: ^9.0.0
  provider: ^6.1.1
```

### Flutter Servisleri (lib/services/)
```
api_service.dart - HTTP istekleri
auth_service.dart - Kimlik doğrulama
socket_service.dart - WebSocket bağlantısı
storage_service.dart - Yerel depolama
```

## API Endpoints

### Authentication
```
POST /api/auth/register - Kayıt ol
POST /api/auth/login - Giriş yap
POST /api/auth/refresh - Token yenile
POST /api/auth/logout - Çıkış yap
```

### Player
```
GET /api/player/profile - Profil bilgisi
PUT /api/player/profile - Profil güncelle
GET /api/player/stats - İstatistikler
GET /api/player/inventory - Envanter
POST /api/player/advance-day - Gün ilerlet
```

### Market
```
GET /api/market/products - Tüm ürünler
GET /api/market/products/:id - Ürün detayı
POST /api/market/update-prices - Fiyat güncelle (admin)
```

### Trade
```
POST /api/trade/buy - Ürün satın al
POST /api/trade/sell - Ürün sat
GET /api/trade/history - İşlem geçmişi
```

### Shop
```
GET /api/shop/available - Müsait dükkanlar
POST /api/shop/rent - Dükkan kirala
DELETE /api/shop/:id/leave - Dükkan bırak
GET /api/shop/owned - Sahip olunan dükkanlar
```

### Event
```
GET /api/event/active - Aktif olaylar
POST /api/event/respond - Olaya yanıt ver
GET /api/event/history - Olay geçmişi
```

### Leaderboard
```
GET /api/leaderboard/level - Seviye sıralaması
GET /api/leaderboard/wealth - Zenginlik sıralaması
GET /api/leaderboard/profit - Kar sıralaması
```

### Admin
```
GET /api/admin/dashboard - Dashboard istatistikleri
GET /api/admin/players - Tüm oyuncular
PUT /api/admin/players/:id/ban - Oyuncu banla
GET /api/admin/products - Ürün yönetimi
PUT /api/admin/products/:id - Ürün güncelle
POST /api/admin/products - Yeni ürün ekle
DELETE /api/admin/products/:id - Ürün sil
GET /api/admin/events - Olay yönetimi
POST /api/admin/events/trigger - Manuel olay tetikle
GET /api/admin/settings - Oyun ayarları
PUT /api/admin/settings - Ayarları güncelle
```

## WebSocket Events

### Client -> Server
```
player:join - Oyuncu bağlandı
market:subscribe - Pazar güncellemelerine abone ol
trade:execute - İşlem gerçekleştir
```

### Server -> Client
```
market:priceUpdate - Fiyat güncellendi
event:triggered - Olay tetiklendi
player:levelUp - Seviye atladı
notification:new - Yeni bildirim
```

## Veritabanı Koleksiyonları

### MongoDB Collections
```
players - Oyuncu verileri
products - Ürün kataloğu
shops - Dükkan listesi
markets - Pazar durumu
events - Olay geçmişi
transactions - İşlem kayıtları
admins - Admin kullanıcılar
settings - Oyun ayarları
```

## Güvenlik

### Uygulanacak Güvenlik Önlemleri
1. JWT token authentication
2. Password hashing (bcrypt)
3. Rate limiting
4. CORS yapılandırması
5. Helmet.js güvenlik başlıkları
6. Input validation
7. SQL injection koruması
8. XSS koruması
9. HTTPS zorunluluğu
10. Redis session yönetimi

## Deployment

### PM2 Ecosystem Dosyası (ecosystem.config.js)
```javascript
module.exports = {
  apps: [{
    name: 'offmarket-api',
    script: './backend/server.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production'
    }
  }, {
    name: 'offmarket-admin',
    script: './admin-panel/server.js',
    instances: 1,
    env: {
      NODE_ENV: 'production'
    }
  }]
};
```

## Monitoring

### Önerilen Araçlar
- PM2 monitoring
- MongoDB Atlas monitoring
- Redis monitoring
- Nginx access logs
- Winston log files
- Sentry error tracking (opsiyonel)

## Backup Strategy

### Otomatik Yedekleme
```bash
# MongoDB backup (günlük)
0 2 * * * mongodump --uri="mongodb://localhost:27017/offmarket" --out=/backup/mongodb/$(date +\%Y\%m\%d)

# Redis backup (saatlik)
0 * * * * redis-cli SAVE && cp /var/lib/redis/dump.rdb /backup/redis/dump_$(date +\%Y\%m\%d_\%H).rdb
```

## Sonraki Adımlar

1. Kalan model dosyalarını oluştur
2. Route dosyalarını oluştur
3. Middleware dosyalarını oluştur
4. Admin panel HTML/CSS/JS oluştur
5. Flutter servis entegrasyonları yap
6. Test senaryoları yaz
7. Dokümantasyon tamamla
8. Production deployment yap
