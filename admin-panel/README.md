# OffMarket Admin Panel

Profesyonel kurumsal tasarımlı web tabanlı admin yönetim paneli.

## 🎨 Tasarım

### Profesyonel Kurumsal Tema
- **Renk Paleti**: Mavi (#2563eb), Koyu Gri (#111827)
- **Stil**: Ciddi, profesyonel, kurumsal
- **Tipografi**: Modern sistem fontları (-apple-system, Segoe UI, Roboto)
- **Layout**: Responsive, mobile-first design
- **Efektler**: Minimal gölgeler, ince borderlar

## 🚀 Kurulum

```bash
cd admin-panel
npm install
```

## ▶️ Çalıştırma

```bash
# Development
npm run dev

# Production
npm start
```

**Panel**: http://localhost:5000
**Login**: http://localhost:5000/login.html
**Default Admin**: admin@offmarket.com / Admin123!

## ✨ Özellikler

### 1. Dashboard (/)
- 8 İstatistik Kartı
  - Toplam Oyuncu
  - Aktif Oyuncular
  - Banlı Oyuncular
  - Toplam Ürün
  - Toplam Dükkan
  - Kiralı Dükkan
  - Toplam İşlem
  - Bugünkü İşlem
- Top 10 Oyuncu Listesi
- Son İşlemler
- Aktif Olaylar
- Otomatik Yenileme (30 saniye)

### 2. Oyuncu Yönetimi (/players.html)
- Oyuncu Listesi (Tablo görünümü)
- Gelişmiş Arama ve Filtreleme
- Durum Filtreleme (Aktif/Banlı)
- Sıralama (Tarih, Seviye, Para, Kar)
- Oyuncu Detay Sayfası
- Ban/Unban İşlemleri
- Modal Dialog'lar

### 3. Ürün Yönetimi (/products.html)
- Ürün Listesi
- Yeni Ürün Ekleme
- Ürün Düzenleme
- Ürün Silme
- Fiyat Güncelleme
- Kategori Yönetimi
- Pazara Ekleme/Çıkarma

### 4. Dükkan Yönetimi (/shops.html)
- Dükkan Listesi
- Yeni Dükkan Ekleme
- Dükkan Düzenleme
- Kiralama Durumu
- Lokasyon Bilgileri

### 5. İşlem Geçmişi (/transactions.html) ⭐ YENİ
- 4 Özet İstatistik Kartı
- Gelişmiş Filtreleme Sistemi
  - Arama (Oyuncu/Ürün)
  - İşlem Tipi (Alış/Satış/Takas/Dükkan)
  - Tarih Aralığı (Bugün/Hafta/Ay/Tümü)
- Detaylı İşlem Tablosu
- Sayfalama (20 işlem/sayfa)
- Renkli Durum Badge'leri
- Export Özelliği

### 6. Olaylar (/events.html)
- Aktif Olay Listesi
- Manuel Olay Tetikleme
- Olay Geçmişi

### 7. Yasaklı Kelimeler (/banned-words.html)
- Kelime Listesi
- Tek/Toplu Ekleme
- Kategori Sistemi
- Severity Seviyeleri
- Metin Kontrolü

### 8. Analitik (/analytics.html) ⭐ YENİ
- 4 Özet Metrik Kartı
  - Toplam Gelir
  - Ortalama İşlem
  - Aktif Kullanıcı
  - İşlem Sayısı
- Trend Göstergeleri (+% formatında)
- Grafik Placeholder'ları
  - Gelir Trendi (30 gün)
  - Kullanıcı Aktivitesi
- En Çok Satan Ürünler Tablosu
- En Aktif Oyuncular Tablosu
- Pazar Analizi Metrikleri
- Export Özellikleri

### 9. Oyuncu Detay (/player-detail.html)
- Detaylı Oyuncu Bilgileri
- İstatistikler
- İşlem Geçmişi
- Envanter
- Dükkanlar

### 10. Login Sayfası (/login.html)
- Profesyonel Login Formu
- JWT Authentication
- Hata Yönetimi
- Responsive Design

## 📡 API Endpoints

Tüm istekler `http://213.142.159.245:3000/api/admin` üzerinden yapılır.

### Authentication
```
POST /api/admin/login
```

### Dashboard
```
GET /api/admin/dashboard
GET /api/admin/stats?days=7
```

### Players
```
GET /api/admin/players?page=1&limit=50&search=&status=
GET /api/admin/players/:id
PUT /api/admin/players/:id/ban
PUT /api/admin/players/:id/unban
```

### Products
```
GET /api/admin/products
POST /api/admin/products
PUT /api/admin/products/:id
DELETE /api/admin/products/:id
```

### Shops
```
GET /api/admin/shops
POST /api/admin/shops
PUT /api/admin/shops/:id
```

### Events
```
POST /api/admin/events/trigger
```

### Banned Words
```
GET /api/admin/banned-words
POST /api/admin/banned-words
POST /api/admin/banned-words/bulk
PUT /api/admin/banned-words/:id
DELETE /api/admin/banned-words/:id
POST /api/admin/banned-words/check
```

## 📁 Dosya Yapısı

```
admin-panel/
├── public/
│   ├── login.html              ✅ Login sayfası
│   ├── index.html              ✅ Dashboard
│   ├── players.html            ✅ Oyuncu yönetimi
│   ├── products.html           ✅ Ürün yönetimi
│   ├── shops.html              ✅ Dükkan yönetimi
│   ├── transactions.html       ✅ İşlem geçmişi (YENİ)
│   ├── events.html             ✅ Olay yönetimi
│   ├── banned-words.html       ✅ Yasaklı kelimeler
│   ├── analytics.html          ✅ Analitik (YENİ)
│   ├── player-detail.html      ✅ Oyuncu detay
│   ├── css/
│   │   └── style.css           ✅ Profesyonel kurumsal CSS
│   └── js/
│       ├── api.js              ✅ API istekleri
│       ├── auth.js             ✅ Authentication
│       └── dashboard.js        ✅ Dashboard logic
├── server.js                   ✅ Express server
├── package.json                ✅
└── README.md                   ✅
```

## 🎨 CSS Özellikleri

### Renk Paleti
```css
--primary: #2563eb;
--primary-dark: #1e40af;
--gray-900: #111827;  /* Sidebar */
--gray-50: #f9fafb;   /* Background */
```

### Bileşenler
- **Sidebar**: Koyu gri (#111827), modern navigasyon
- **Kartlar**: Beyaz arka plan, minimal gölge
- **Butonlar**: Primary mavi, hover efektleri
- **Tablolar**: Temiz, okunabilir, hover efektleri
- **Formlar**: Modern input'lar, focus efektleri
- **Modal'lar**: Overlay, smooth animations

### Responsive Breakpoints
- Desktop: 1024px+
- Tablet: 768px - 1023px
- Mobile: < 768px

## 🔐 Güvenlik

- JWT Token Authentication
- LocalStorage'da Token Saklama
- Her İstekte Token Gönderme
- Unauthorized Durumunda Login'e Yönlendirme
- Role-based Access Control
- XSS Protection
- CSRF Protection

## 🚀 Production Deployment

### PM2 ile Çalıştırma
```bash
pm2 start server.js --name offmarket-admin
pm2 save
pm2 startup
```

### Nginx Reverse Proxy
```nginx
server {
    listen 80;
    server_name admin.offmarket.com;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### SSL (Let's Encrypt)
```bash
sudo certbot --nginx -d admin.offmarket.com
```

## 📊 Performans

- Otomatik Yenileme: 30 saniye
- Sayfalama: 20-50 item/sayfa
- Lazy Loading: Tablolar
- Compression: Gzip
- Caching: LocalStorage

## 🛠️ Geliştirme

### Yeni Sayfa Ekleme
1. `public/` altında yeni HTML dosyası oluştur
2. Sidebar'a link ekle
3. `js/` altında logic dosyası oluştur
4. API endpoint'lerini `api.js`'e ekle

### Stil Değişiklikleri
- `public/css/style.css` dosyasını düzenle
- CSS değişkenleri kullan
- Responsive tasarıma dikkat et

## 📝 Notlar

- Admin panel sadece yetkili kullanıcılar için
- İlk admin kullanıcı seed script ile oluşturulur
- **Default**: admin@offmarket.com / Admin123!
- **Production'da şifreleri mutlaka değiştirin!**
- Tüm sayfalar responsive tasarıma sahip
- Modern tarayıcılar desteklenir (Chrome, Firefox, Safari, Edge)

## 🎯 Gelecek Özellikler

- [ ] Real-time Dashboard (WebSocket)
- [ ] Chart.js Grafikleri
- [ ] Excel Export
- [ ] Bulk Operations
- [ ] Advanced Filters
- [ ] Dark/Light Mode Toggle
- [ ] Multi-language Support

---

**Versiyon**: 1.0.1
**Son Güncelleme**: 18 Ocak 2025
**Durum**: Production Ready 🚀
