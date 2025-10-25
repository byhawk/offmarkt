#!/bin/bash

# Deal Baron Deployment Script
# Sunucuya bağlan ve projeyi hazırla

set -e

# Sunucu bilgileri
SERVER_IP="213.142.159.245"
SERVER_USER="root"
PROJECT_PATH="/var/www/ofmarkt"
BACKEND_PATH="$PROJECT_PATH/backend"
ADMIN_PANEL_PATH="$PROJECT_PATH/admin-panel"

echo "🚀 Deal Baron Deployment başlıyor..."
echo "📍 Sunucu: $SERVER_IP"
echo "📁 Proje Yolu: $PROJECT_PATH"

# Yerel dosyaları sunucuya kopyala
echo "📤 Dosyalar sunucuya kopyalanıyor..."
rsync -avz --delete \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude 'build' \
  --exclude '.env' \
  ./backend/ $SERVER_USER@$SERVER_IP:$BACKEND_PATH/

rsync -avz --delete \
  --exclude 'node_modules' \
  ./admin-panel/ $SERVER_USER@$SERVER_IP:$ADMIN_PANEL_PATH/

echo "✅ Dosyalar kopyalandı"

# Sunucuda kurulumu tamamla
echo "🔧 Sunucuda kurulum yapılıyor..."

ssh $SERVER_USER@$SERVER_IP << 'EOF'
set -e

PROJECT_PATH="/var/www/ofmarkt"
BACKEND_PATH="$PROJECT_PATH/backend"
ADMIN_PANEL_PATH="$PROJECT_PATH/admin-panel"

echo "📦 Backend bağımlılıkları yükleniyor..."
cd $BACKEND_PATH
npm install

echo "📦 Admin Panel bağımlılıkları yükleniyor..."
cd $ADMIN_PANEL_PATH
npm install

echo "🗄️ MongoDB kontrol ediliyor..."
if ! command -v mongod &> /dev/null; then
    echo "MongoDB yükleniyor..."
    apt-get update
    apt-get install -y mongodb
fi

echo "🔄 PM2 kurulumu kontrol ediliyor..."
if ! command -v pm2 &> /dev/null; then
    npm install -g pm2
fi

echo "🛑 Eski process'leri durdur..."
pm2 delete "backend" || true
pm2 delete "admin-panel" || true

echo "🚀 Backend başlatılıyor..."
cd $BACKEND_PATH
pm2 start server.js --name "backend" --env production

echo "🚀 Admin Panel başlatılıyor..."
cd $ADMIN_PANEL_PATH
pm2 start server.js --name "admin-panel" --env production

echo "💾 PM2 konfigürasyonu kaydediliyor..."
pm2 save
pm2 startup

echo "✅ Kurulum tamamlandı!"
echo ""
echo "📊 Çalışan Servisler:"
pm2 list

EOF

echo ""
echo "✅ Deployment başarıyla tamamlandı!"
echo ""
echo "🌐 Erişim Adresleri:"
echo "  Backend API: http://$SERVER_IP:3000"
echo "  Admin Panel: http://$SERVER_IP:3001"
echo ""
echo "📝 Logları görmek için:"
echo "  ssh $SERVER_USER@$SERVER_IP"
echo "  pm2 logs backend"
echo "  pm2 logs admin-panel"
