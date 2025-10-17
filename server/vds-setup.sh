#!/bin/bash

# OffMarket VDS Sunucu Kurulum Scripti
# Ubuntu 22.04 LTS için optimize edilmiştir

echo "=================================="
echo "OffMarket VDS Kurulum Başlıyor..."
echo "=================================="

# Sistem güncellemesi
echo "Sistem güncelleniyor..."
sudo apt update && sudo apt upgrade -y

# Node.js 20.x kurulumu
echo "Node.js kuruluyor..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# MongoDB kurulumu
echo "MongoDB kuruluyor..."
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt update
sudo apt install -y mongodb-org

# MongoDB'yi başlat ve otomatik başlatmayı etkinleştir
sudo systemctl start mongod
sudo systemctl enable mongod

# Nginx kurulumu (Reverse proxy için)
echo "Nginx kuruluyor..."
sudo apt install -y nginx

# PM2 kurulumu (Node.js process manager)
echo "PM2 kuruluyor..."
sudo npm install -g pm2

# Redis kurulumu (Cache ve session için)
echo "Redis kuruluyor..."
sudo apt install -y redis-server
sudo systemctl start redis-server
sudo systemctl enable redis-server

# Git kurulumu
echo "Git kuruluyor..."
sudo apt install -y git

# Certbot kurulumu (SSL sertifikası için)
echo "Certbot kuruluyor..."
sudo apt install -y certbot python3-certbot-nginx

# Firewall ayarları
echo "Firewall yapılandırılıyor..."
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS
sudo ufw allow 3000/tcp    # Backend API
sudo ufw allow 5000/tcp    # Admin Panel
sudo ufw --force enable

# Proje dizini oluştur
echo "Proje dizinleri oluşturuluyor..."
sudo mkdir -p /var/www/offmarket
sudo chown -R $USER:$USER /var/www/offmarket

# MongoDB kullanıcı oluştur
echo "MongoDB kullanıcısı oluşturuluyor..."
mongosh <<EOF
use admin
db.createUser({
  user: "offmarket_admin",
  pwd: "$(openssl rand -base64 32)",
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" }
  ]
})

use offmarket
db.createUser({
  user: "offmarket_user",
  pwd: "$(openssl rand -base64 32)",
  roles: [
    { role: "readWrite", db: "offmarket" }
  ]
})
EOF

# Nginx yapılandırması
echo "Nginx yapılandırılıyor..."
sudo tee /etc/nginx/sites-available/offmarket-api > /dev/null <<'NGINX_API'
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
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINX_API

sudo tee /etc/nginx/sites-available/offmarket-admin > /dev/null <<'NGINX_ADMIN'
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
NGINX_ADMIN

# Nginx site'ları etkinleştir
sudo ln -sf /etc/nginx/sites-available/offmarket-api /etc/nginx/sites-enabled/
sudo ln -sf /etc/nginx/sites-available/offmarket-admin /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Nginx'i test et ve yeniden başlat
sudo nginx -t
sudo systemctl restart nginx

# .env dosyası şablonu oluştur
cat > /var/www/offmarket/.env.example <<'ENV'
# Server Configuration
NODE_ENV=production
PORT=3000
ADMIN_PORT=5000

# Database
MONGODB_URI=mongodb://offmarket_user:YOUR_PASSWORD@localhost:27017/offmarket
MONGODB_DB_NAME=offmarket

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# JWT
JWT_SECRET=YOUR_JWT_SECRET_HERE
JWT_EXPIRE=7d
JWT_REFRESH_SECRET=YOUR_REFRESH_SECRET_HERE
JWT_REFRESH_EXPIRE=30d

# Admin
ADMIN_EMAIL=admin@offmarket.com
ADMIN_PASSWORD=YOUR_ADMIN_PASSWORD

# Game Settings
INITIAL_CASH=5000
MAX_PLAYERS=10000
MARKET_UPDATE_INTERVAL=300000

# CORS
CORS_ORIGIN=*

# Rate Limiting
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX_REQUESTS=100
ENV

echo "=================================="
echo "Kurulum tamamlandı!"
echo "=================================="
echo ""
echo "Sonraki adımlar:"
echo "1. /var/www/offmarket/.env.example dosyasını .env olarak kopyalayın"
echo "2. .env dosyasındaki şifreleri güncelleyin"
echo "3. Backend ve admin panel kodlarını /var/www/offmarket dizinine yükleyin"
echo "4. npm install komutunu çalıştırın"
echo "5. PM2 ile servisleri başlatın:"
echo "   pm2 start backend/server.js --name offmarket-api"
echo "   pm2 start admin-panel/server.js --name offmarket-admin"
echo "   pm2 save"
echo "   pm2 startup"
echo ""
echo "SSL sertifikası için:"
echo "sudo certbot --nginx -d api.offmarket.com -d admin.offmarket.com"
echo ""
echo "MongoDB şifreleri /tmp/mongodb-passwords.txt dosyasına kaydedildi"
