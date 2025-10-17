# OffMarket Admin Panel

Web tabanlı admin yönetim paneli.

## Kurulum

```bash
cd admin-panel
npm install
```

## Çalıştırma

```bash
# Development
npm run dev

# Production
npm start
```

Panel: http://localhost:5000

## Özellikler

### Dashboard (/)
- Toplam oyuncu sayısı
- Aktif oyuncular
- Banlı oyuncular
- Toplam ürün/dükkan
- Günlük işlem sayısı
- Top 10 oyuncu

### Oyuncu Yönetimi (/players)
- Oyuncu listesi
- Arama ve filtreleme
- Oyuncu detayları
- Ban/Unban işlemleri
- İşlem geçmişi

### Ürün Yönetimi (/products)
- Ürün listesi
- Yeni ürün ekleme
- Ürün düzenleme
- Ürün silme
- Fiyat güncelleme

### Dükkan Yönetimi (/shops)
- Dükkan listesi
- Yeni dükkan ekleme
- Dükkan düzenleme
- Kiralama durumu

## API Endpoints

Tüm istekler `http://localhost:3000/api/admin` üzerinden yapılır.

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

## Dosya Yapısı

```
admin-panel/
├── public/
│   ├── index.html          # Dashboard
│   ├── players.html        # Oyuncu yönetimi
│   ├── products.html       # Ürün yönetimi
│   ├── shops.html          # Dükkan yönetimi
│   ├── css/
│   │   └── style.css       # Genel stiller
│   └── js/
│       ├── api.js          # API istekleri
│       ├── auth.js         # Authentication
│       ├── dashboard.js    # Dashboard logic
│       ├── players.js      # Oyuncu yönetimi logic
│       ├── products.js     # Ürün yönetimi logic
│       └── shops.js        # Dükkan yönetimi logic
├── server.js               # Express server
├── package.json
└── README.md
```

## HTML Sayfaları

Her sayfa şu bileşenleri içerir:
- Sidebar navigation
- Header (logout button)
- Main content area
- Responsive design
- Dark theme

## JavaScript Modülleri

### api.js
```javascript
const API_URL = 'http://localhost:3000/api/admin';
const token = localStorage.getItem('adminToken');

async function apiRequest(endpoint, options = {}) {
  // API request logic
}
```

### auth.js
```javascript
async function login(email, password) {
  // Login logic
}

function logout() {
  // Logout logic
}

function checkAuth() {
  // Check if logged in
}
```

## Güvenlik

- JWT token authentication
- LocalStorage'da token saklama
- Her istekte token gönderme
- Unauthorized durumunda login'e yönlendirme
- Role-based access control

## Geliştirme

Admin panel basit HTML/CSS/JS ile geliştirilmiştir. İsterseniz:
- React/Vue/Angular ile yeniden yazılabilir
- UI framework'ü eklenebilir (Bootstrap, Tailwind)
- Chart.js ile grafikler eklenebilir
- DataTables ile gelişmiş tablolar eklenebilir

## Production

```bash
# PM2 ile çalıştır
pm2 start server.js --name offmarket-admin

# Nginx reverse proxy
# /etc/nginx/sites-available/offmarket-admin
server {
    listen 80;
    server_name admin.offmarket.com;
    
    location / {
        proxy_pass http://localhost:5000;
    }
}
```

## Notlar

- Admin panel sadece yetkili kullanıcılar için
- İlk admin kullanıcı seed script ile oluşturulur
- Default: admin@offmarket.com / Admin123!
- Production'da şifreleri değiştirin!
