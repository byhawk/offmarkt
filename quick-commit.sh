#!/bin/bash

# Deal Baron - Quick Commit & Push Script
# Kullanım: ./quick-commit.sh "commit mesajınız"
# Varsayılan: ./quick-commit.sh (otomatik mesaj)

# Renk kodları
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Commit mesajı (parametre veya default)
if [ -z "$1" ]; then
    COMMIT_MSG="chore: Build runner sonrası generated dosyalar güncellendi"
    echo -e "${YELLOW}⚠️  Commit mesajı verilmedi, default mesaj kullanılıyor${NC}"
else
    COMMIT_MSG="$1"
fi

echo "======================================"
echo "🚀 Quick Commit & Push"
echo "======================================"
echo ""
echo -e "${BLUE}📝 Commit Mesajı:${NC}"
echo "  $COMMIT_MSG"
echo ""

# Git Add
echo -e "${BLUE}📦 Değişiklikler ekleniyor...${NC}"
git add -A

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Git add başarısız!${NC}"
    exit 1
fi

# Git Commit
echo -e "${BLUE}💾 Commit yapılıyor...${NC}"
git commit -m "$(cat <<EOF
$COMMIT_MSG

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

if [ $? -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Commit yapılamadı (muhtemelen değişiklik yok)${NC}"
    echo ""
    git status
    exit 0
fi

# Git Push
echo -e "${BLUE}📤 GitHub'a push ediliyor...${NC}"
git push origin main

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Git push başarısız!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ İşlem tamamlandı!${NC}"
echo ""
git log --oneline -1
echo ""
