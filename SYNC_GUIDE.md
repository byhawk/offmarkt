# 🚀 Auto Sync Script Kullanım Kılavuzu

Bu scriptler Deal Baron projesini GitHub ile otomatik senkronize etmenizi sağlar.

## 📦 Scriptler

### 1. `sync.sh` - Otomatik Sync (Pull + Build Runner)
GitHub'dan çeker, build runner çalıştırır, commit için bekler.

**Kullanım:**
```bash
./sync.sh
```

**Ne yapar:**
1. ✅ `git pull origin main` - GitHub'dan son değişiklikleri çeker
2. ✅ `flutter pub run build_runner build --delete-conflicting-outputs` - Generated dosyaları oluşturur
3. ✅ `git status` - Değişiklikleri gösterir
4. ⏸️  **Manuel commit için bekler**

**Sonrasında yapmanız gerekenler:**
```bash
# Değişiklikleri inceleyin
git status

# Manuel commit
git add -A
git commit -m "feat: Yeni özellik eklendi"
git push origin main

# VEYA hızlı commit için:
./quick-commit.sh "feat: Yeni özellik eklendi"
```

---

### 2. `quick-commit.sh` - Hızlı Commit & Push
Değişiklikleri hızlıca commit edip push eder.

**Kullanım:**

```bash
# Özel mesajla
./quick-commit.sh "feat: Yeni özellik eklendi"

# Default mesajla
./quick-commit.sh
```

**Ne yapar:**
1. ✅ `git add -A` - Tüm değişiklikleri ekler
2. ✅ `git commit -m "..."` - Commit yapar (Claude Code imzalı)
3. ✅ `git push origin main` - GitHub'a push eder

---

## 🔄 Tipik Workflow

### Senaryo 1: Günlük Sync (GitHub'dan güncelleme al)
```bash
# 1. Sync yap
./sync.sh

# 2. Değişiklikleri gözden geçir
git status

# 3. Commit ve push
./quick-commit.sh "chore: Build runner güncellemesi"
```

### Senaryo 2: Kod Değişiklikleri Yaptın (Kendi değişikliklerini push et)
```bash
# Kod değiştirdin, test ettirdin, hazırsın

# 1. Build runner çalıştır
flutter pub run build_runner build --delete-conflicting-outputs

# 2. Commit ve push
./quick-commit.sh "feat: Login ekranı eklendi"
```

### Senaryo 3: Tam Otomatik Sync
```bash
# Her şeyi otomatik yap (dikkatli kullan!)
./sync.sh && ./quick-commit.sh
```

---

## 🎯 Script Özellikleri

### sync.sh
- 🎨 Renkli terminal çıktısı
- ⏱️ Aşama aşama gösterim
- ❌ Hata kontrolü (fail-fast)
- 📊 Detaylı status gösterimi

### quick-commit.sh
- 🤖 Otomatik Claude Code imzası
- 📝 Özel veya default commit mesajı
- ✅ Başarı/hata kontrolü
- 📜 Son commit özeti

---

## 📋 Örnekler

### Örnek 1: Sabah Rutin Sync
```bash
# Kahve al ☕
./sync.sh

# Değişiklikleri oku
# Eğer sadece generated dosyalar varsa:
./quick-commit.sh

# Eğer kod değişiklikleri varsa:
git diff  # İncele
./quick-commit.sh "chore: Sync GitHub güncellemeleri"
```

### Örnek 2: Yeni Feature Push
```bash
# Feature tamamlandı, test edildi

# Build runner
flutter pub run build_runner build --delete-conflicting-outputs

# Commit
./quick-commit.sh "feat: Çalışan kiralama sistemi eklendi

- EmployeeProvider entegre edildi
- HR ekranı UI tamamlandı
- Backend API bağlantısı yapıldı"

# Başarılı! ✅
```

### Örnek 3: Acil Hotfix
```bash
# Bug fix yaptın

# Hızlıca push
./quick-commit.sh "fix: Login crash düzeltildi"
```

---

## ⚠️ Önemli Notlar

1. **sync.sh her zaman güvenlidir** - Commit yapmaz, sadece hazırlar
2. **quick-commit.sh dikkatli kullanın** - Otomatik commit yapar
3. **Conflict durumunda** manuel müdahale gerekir
4. **Script çalışmazsa** executable yetkisi verin:
   ```bash
   chmod +x sync.sh quick-commit.sh
   ```

---

## 🐛 Sorun Giderme

### Script çalışmıyor
```bash
# Yetki ver
chmod +x sync.sh quick-commit.sh

# Tekrar dene
./sync.sh
```

### Git conflict
```bash
# Manuel çöz
git status
git merge --abort  # veya conflict'leri düzelt
```

### Build runner hatası
```bash
# Cache temizle
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 💡 İpuçları

1. **Her zaman sync.sh ile başla** - GitHub'daki değişiklikleri kaçırmazsın
2. **Commit mesajlarını anlamlı yaz** - Gelecekte kendine teşekkür edersin
3. **Git status kontrol et** - Ne commit ettiğini bil
4. **Test sonrası push** - Çalışmayan kod push etme

---

**Hazırlayan:** Claude AI
**Versiyon:** 1.0
**Tarih:** 25 Ekim 2025
