# 🎮 OffMarket - İş Simülasyon Oyunu

Flutter tabanlı interaktif ticaret ve iş simülasyonu oyunu. Nakit yönetimi, ürün ticareti, dükkan kiralama ve itibar sistemi ile gerçekçi bir iş dünyası deneyimi.

## 📱 Proje Hakkında

OffMarket, oyuncuların bir iş imparatorluğu kurmasını sağlayan kapsamlı bir simülasyon oyunudur. Oyuncular:
- 💰 Nakit ve banka hesabı yönetimi
- 📈 Dinamik piyasa fiyatları ile ürün alım-satımı
- 🏢 Dükkan kiralama ve işletme yönetimi
- ⚖️ Yasal ve sokak itibarı kazanma
- 📊 Risk yönetimi ve strateji geliştirme
- 🎯 Seviye atlama ve deneyim kazanma

## 🎨 Özellikler

### Oyun Mekaniği
- **Dinamik Pazar Sistemi**: Volatilite ve talebe göre değişen ürün fiyatları
- **İtibar Sistemi**: Yasal ve sokak itibarı iki ayrı mekanik
- **Risk Yönetimi**: Riskli işlemler yüksek kar getirir ama tehlikelidir
- **Seviye Sistemi**: 1000 exp başına seviye atlama
- **Envanter Yönetimi**: Satın alma tarihi ve kaynağı ile ürün takibi
- **Finansal Araçlar**: Nakit, banka hesabı, borç sistemi

### Teknik Özellikler
- 🎨 **Material 3 Dark Theme**: Modern ve şık karanlık tema
- 🌈 **Gradient UI**: Görsel hiyerarşi için gradient kartlar
- 😊 **Emoji-Rich Interface**: Sezgisel emoji ikonları
- ⚡ **Riverpod State Management**: Reaktif ve performanslı state yönetimi
- 🧊 **Freezed Models**: Immutable ve type-safe veri modelleri
- 🔄 **Code Generation**: Otomatik kod üretimi ile hatasız geliştirme

## 🏗️ Mimari

### Katman Yapısı
```
lib/
├── core/                    # Paylaşılan kaynaklar
│   ├── constants/          # Tema, renkler, stiller, boşluklar
│   └── utils/              # Yardımcı fonksiyonlar (formatters)
├── data/                   # Veri katmanı
│   └── models/             # Freezed data modelleri
├── domain/                 # İş mantığı katmanı
│   └── entities/           # Domain varlıkları
├── presentation/           # UI katmanı
│   ├── providers/          # Riverpod state yönetimi
│   ├── screens/            # Ekranlar
│   └── widgets/            # Yeniden kullanılabilir bileşenler
└── game/                   # Oyun sistemleri
    └── systems/            # Oyun mantığı sistemleri
```

### State Yönetimi
- **PlayerNotifier**: Oyuncu durumu (nakit, itibar, seviye, exp)
- **MarketNotifier**: Pazar ürünleri ve dinamik fiyatlandırma
- **InventoryNotifier**: Oyuncu envanteri ve stok takibi

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK 3.9.2 veya üzeri
- Dart 3.9.2 veya üzeri

### Kurulum Adımları

```bash
# Bağımlılıkları yükle
flutter pub get

# Kod üretimini çalıştır (Freezed, Riverpod, JSON)
dart run build_runner build --delete-conflicting-outputs

# Uygulamayı çalıştır
flutter run
```

### Geliştirme Komutları

```bash
# Watch mode ile kod üretimi (geliştirme sırasında)
dart run build_runner watch --delete-conflicting-outputs

# Statik analiz
flutter analyze

# Testleri çalıştır
flutter test

# Web'de çalıştır
flutter run -d chrome
```

## 📦 Teknoloji Stack

### Core Dependencies
- `flutter_riverpod ^2.6.1` - State management
- `freezed_annotation ^2.4.4` - Immutable models
- `json_annotation ^4.9.0` - JSON serialization
- `shared_preferences ^2.3.3` - Local storage

### UI & Utils
- `gap ^3.0.1` - Spacing widgets
- `intl ^0.20.2` - Formatters (para, tarih)
- `uuid ^4.5.1` - Unique ID generation

### Dev Dependencies
- `build_runner ^2.4.13` - Code generation
- `riverpod_generator ^2.6.1` - Provider generation
- `freezed ^2.5.7` - Model generation
- `json_serializable ^6.9.2` - JSON generation

## 🎯 Gelişim Planı

### ✅ Tamamlanan (Faz 1-5)
- [x] Flutter proje kurulumu ve yapılandırma
- [x] Core modeller (Player, Product, Shop, InventoryItem)
- [x] State management (Riverpod providers)
- [x] UI tema sistemi (Material 3 Dark Theme)
- [x] Common widgets (StatCard, GradientCard)
- [x] HomeScreen (Dashboard) implementasyonu
- [x] Dokümantasyon (CLAUDE.md, FLUTTER_MIGRATION.md)

### 🚧 Devam Eden (Faz 6)
- [ ] MarketScreen - Ürün alım-satım ekranı
- [ ] InventoryScreen - Stok yönetimi
- [ ] ShopsScreen - Dükkan kiralama listesi
- [ ] BusinessScreen - İşletme detayları
- [ ] StatsScreen - İstatistikler ve geçmiş

### 📅 Planlanan (Faz 7-9)
- [ ] Navigation (Bottom nav bar, routing)
- [ ] Game systems (Trading, Shop, Event, Risk, Reputation)
- [ ] Unit & widget testleri
- [ ] Performance optimizasyonu
- [ ] Android build ve APK

## 📝 Son Güncelleme

**Tarih**: 16 Ekim 2025
**Saat**: 21:30 TSİ
**Versiyon**: 0.1.0

### Son Değişiklikler
- ✨ CLAUDE.md oluşturuldu (Türkçe, otonom çalışma izinleri)
- ✨ README.md güncellendi (proje açıklaması, gelişim planı)
- 📚 Dokümantasyon Türkçeleştirildi
- 🎨 Tema sistemi ve widget'lar oluşturuldu
- 🏗️ Temel mimari kuruldu

## 🤝 Katkıda Bulunma

Bu proje aktif geliştirme aşamasındadır. Katkılarınız için:
1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Harika özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

Bu proje özel bir projedir ve şu anda açık kaynak lisansı altında değildir.

## 👨‍💻 Geliştirici

**byhawk**
GitHub: [@byhawk](https://github.com/byhawk)

---

⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!
