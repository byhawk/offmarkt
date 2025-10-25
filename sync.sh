#!/bin/bash

# Deal Baron - Auto Sync Script
# Bu script şunları yapar:
# 1. GitHub'dan son değişiklikleri çeker
# 2. Build runner çalıştırır
# 3. Git status gösterir
# 4. Commit için bekler (manuel)

echo "======================================"
echo "🚀 Deal Baron Auto Sync"
echo "======================================"
echo ""

# Renk kodları
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Adım 1: Git Pull
echo -e "${BLUE}📥 Adım 1: GitHub'dan değişiklikler çekiliyor...${NC}"
echo ""
git pull origin main

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Git pull başarısız oldu!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Pull tamamlandı!${NC}"
echo ""
sleep 1

# Adım 2: Build Runner
echo -e "${BLUE}🔨 Adım 2: Build runner çalıştırılıyor...${NC}"
echo ""
flutter pub run build_runner build --delete-conflicting-outputs

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build runner başarısız oldu!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Build runner tamamlandı!${NC}"
echo ""
sleep 1

# Adım 3: Git Status
echo -e "${BLUE}📊 Adım 3: Değişiklikler kontrol ediliyor...${NC}"
echo ""
git status

echo ""
echo "======================================"
echo -e "${YELLOW}⏸️  Manuel Commit Zamanı!${NC}"
echo "======================================"
echo ""
echo "Değişiklikleri inceleyip commit yapın:"
echo ""
echo -e "${GREEN}# Tüm değişiklikleri ekle:${NC}"
echo "  git add -A"
echo ""
echo -e "${GREEN}# Commit yap:${NC}"
echo '  git commit -m "chore: Build runner güncellemesi"'
echo ""
echo -e "${GREEN}# Push et:${NC}"
echo "  git push origin main"
echo ""
echo -e "${YELLOW}Ya da hızlı commit için:${NC}"
echo "  ./quick-commit.sh"
echo ""
