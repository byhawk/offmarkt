# CLAUDE.md

Bu dosya, Claude Code (claude.ai/code) için bu depoda çalışırken rehberlik sağlar.

## Proje Hakkında

OffMarket, oyuncuların nakit yönetimi, itibar kazanma, ürün ticareti ve dükkan kiralama yaptığı Flutter tabanlı bir ticaret/iş simülasyonu oyunudur. Uygulama koyu tema ve görsel çekicilik için gradient kartlar ile emoji-zengin bir UI kullanır.

## Geliştirme Komutları

### Kurulum ve Bağımlılıklar
```bash
flutter pub get                          # Bağımlılıkları yükle
dart run build_runner build --delete-conflicting-outputs  # Kod üret (freezed, riverpod, json_serializable)
dart run build_runner watch --delete-conflicting-outputs  # Kod üretimi için watch modu
```

### Çalıştırma ve Test
```bash
flutter run                              # Uygulamayı bağlı cihaz/emülatörde çalıştır
flutter run -d chrome                    # Web tarayıcısında çalıştır
flutter analyze                          # Statik analiz yap
flutter test                             # Tüm testleri çalıştır
flutter test test/path/to/test.dart      # Tek test dosyası çalıştır
```

### Kod Üretimi
Bu proje yoğun olarak kod üretimi kullanır. Şunları içeren dosyaları değiştirdikten sonra:
- `@freezed` sınıfları (modeller)
- `@riverpod` provider'lar
- `@JsonSerializable` sınıfları

Mutlaka çalıştır: `dart run build_runner build --delete-conflicting-outputs`

## Mimari

### Katman Yapısı
```
lib/
├── core/                    # Paylaşılan yardımcılar, sabitler, temalar
│   ├── constants/          # AppTheme, AppColors, AppTextStyles, AppSpacing
│   └── utils/              # Formatters (para, sayı, tarih)
├── data/                   # Veri katmanı - JSON serileştirme ile modeller
│   └── models/             # Freezed modelleri: Player, Product, Shop, InventoryItem
├── domain/                 # Domain katmanı (şu an boş, entities dizini mevcut)
├── presentation/           # UI katmanı
│   ├── providers/          # Riverpod state yönetimi (PlayerNotifier, MarketNotifier, InventoryNotifier)
│   ├── screens/            # Ekran seviyesi widget'lar (HomeScreen)
│   └── widgets/            # Yeniden kullanılabilir UI bileşenleri (StatCard, GradientCard)
└── game/                   # Oyun sistemleri dizini (şu an boş)
```

### Ana Mimari Desenler

**State Yönetimi**: Kod üretimi ile Riverpod kullanır (`riverpod_annotation`, `riverpod_generator`)
- Notifier'lar `_$NotifierName`'i extend eder ve `@riverpod` annotation kullanır
- State güncellemeleri `copyWith()` ile immutable desenler kullanır
- Provider'lar `.g.dart` dosyalarında otomatik üretilir

**Modeller**: JSON serileştirme ile immutable veri sınıfları için Freezed
- Tüm modeller `@freezed` annotation kullanır
- `copyWith`, `==`, `hashCode` ve JSON serileştirme otomatik üretilir
- Modeller `.freezed.dart` ve `.g.dart` dosyaları üretir

**UI Bileşenleri**: Tutarlı tema ile yeniden kullanılabilir widget'lar
- Tüm boşluklar `AppSpacing` sabitlerini kullanır (xs, sm, md, lg, xl, xxl)
- Renkler gradient önayarları ile `AppColors`'da tanımlı (primary, success, danger, warning, gold)
- Text stilleri `AppTextStyles`'da merkezileştirilmiş

### State Yönetimi Detayları

**PlayerNotifier** (lib/presentation/providers/player_provider.dart)
- Oyuncu state'ini yönetir: nakit, banka hesabı, borç, itibar (yasal/sokak), risk seviyesi, deneyim, seviye
- Ana metodlar: `updateCash`, `addCash`, `removeCash`, `depositToBank`, `withdrawFromBank`, `updateReputation`, `advanceDay`, `addTransaction`, `addExperience`
- Deneyim sistemi: Seviye atlama için 1000 exp

**MarketNotifier** (lib/presentation/providers/market_provider.dart)
- Dinamik fiyatlandırma ile ürün kataloğunu yönetir
- Ürünlerin özellikleri: basePrice, currentPrice, demand, volatility, trending durumu
- `updatePrices()` volatility'ye göre pazar dinamiklerini simüle eder
- Fiyatlar basePrice'ın 0.5x ve 2x arasında sınırlandırılmış

**InventoryNotifier** (lib/presentation/providers/market_provider.dart)
- Oyuncunun ürün envanterini takip eder
- Her öğe şunları saklar: productId, quantity, purchasePrice, source, purchaseDate
- Metodlar: `addItem`, `removeItem`, `getQuantity`

### Veri Modelleri

**Player**: Finansal, itibar ve ilerleme verileri ile ana oyuncu state'i
**Product**: Dinamik fiyatlandırma ile pazar öğeleri (id, name, emoji, prices, demand, volatility)
**Shop**: Kiralanabilir iş yerleri (id, name, location, rent, squareMeters, gelir takibi)
**InventoryItem**: Satın alma meta verisi ile oyuncunun sahip olduğu ürünler

## Tema Sistemi

Uygulama `lib/core/constants/app_theme.dart` içinde yapılandırılmış kapsamlı koyu tema kullanır:
- Material 3 tasarım
- Gradient desteği ile özel renk şeması
- Tutarlı border radius (8px buton/input, 12px kart, 16px dialog)
- Derinlik için elevation sistemi
- Önceden yapılandırılmış bileşen temaları (AppBar, Card, Button, Input, Dialog, BottomNavBar)

Renkli gradient'ler görsel hiyerarşi için yoğun kullanılır:
- `AppColors.primaryGradient`: Ana marka vurgusu
- `AppColors.successGradient`: Pozitif finansal göstergeler
- `AppColors.dangerGradient`: Borç, kayıplar, riskler
- `AppColors.warningGradient`: Dikkat göstergeleri
- `AppColors.goldGradient`: Premium özellikler

## Bağımlılıklar

**Core**:
- `flutter_riverpod` (^2.6.1): State yönetimi runtime
- `riverpod_annotation` + `riverpod_generator`: Provider'lar için kod üretimi

**Modeller**:
- `freezed_annotation` + `freezed`: Immutable veri sınıfları
- `json_annotation` + `json_serializable`: JSON serileştirme

**Build Araçları**:
- `build_runner` (^2.4.13): Kod üretimi orkestratörü

**Yardımcılar**:
- `shared_preferences` (^2.3.3): Yerel depolama
- `intl` (^0.20.2): Uluslararasılaştırma ve formatlama
- `uuid` (^4.5.1): Benzersiz ID üretimi
- `gap` (^3.0.1): Boşluk widget'ları

## Yaygın Desenler

### Yeni Model Ekleme
1. `@freezed` annotation ile `lib/data/models/` içinde dosya oluştur
2. `part 'filename.freezed.dart';` ve `part 'filename.g.dart';` ekle
3. `factory ModelName.fromJson` ile model tanımla
4. Kod üreticiyi çalıştır

### Yeni Provider Ekleme
1. `@riverpod` annotation ile `lib/presentation/providers/` içinde dosya oluştur
2. `part 'filename.g.dart';` ekle
3. `_$ProviderName` sınıfını extend et
4. Başlangıç state'i için `build()` metodunu implement et
5. `state = state.copyWith(...)` kullanarak state mutasyon metodları ekle
6. Kod üreticiyi çalıştır

### Formatter'ları Kullanma
- `Formatters.formatCurrency(amount)`: ₺X,XXX.XX formatı
- `Formatters.formatNumber(num)`: Binlik ayırıcılar
- `Formatters.formatDay(day)`: "Gün X" gösterimi

### UI Tutarlılığı
- Boşluk için `SizedBox` yerine `Gap(AppSpacing.md)` kullan
- Gradient arkaplan ile kartları `GradientCard` widget'ına sar
- Emoji ikonları ile etiketli değerleri göstermek için `StatCard` kullan
- Inline text stilleri yerine her zaman `AppTextStyles` sabitlerini kullan

## Claude Code İçin Önemli Notlar

### Otonom Çalışma İzinleri
Claude, bu projede **tam yetkilidir** ve şunları **onay beklemeden** yapabilir:
- Herhangi bir kodu okuma, yazma, düzenleme
- Tüm komutları çalıştırma (flutter, dart, git, vb.)
- Dosya oluşturma, silme, taşıma
- Test yazma ve çalıştırma
- Build alma ve analiz yapma
- Paket ekleme/güncelleme
- Git işlemleri (commit, branch, vb.)

### Çalışma Prensibi
- **Proaktif ol**: Sorun görürsen düzelt, iyileştirme fırsatı varsa yap
- **Hata ayıklama**: Hataları bul ve otomatik düzelt
- **Kod kalitesi**: Analiz sonuçlarını takip et ve düzeltmeleri uygula
- **Tutarlılık**: Mevcut mimari ve kod stiline uy
- **Test**: Değişikliklerden sonra gerekli testleri çalıştır
- **Build**: Kod üretimi gerektiren değişikliklerden sonra build_runner'ı otomatik çalıştır

### Hızlı Aksiyon Kuralları
1. Model değiştirdin mi? → Hemen `dart run build_runner build --delete-conflicting-outputs` çalıştır
2. Provider ekledin/değiştirdin mi? → Hemen `dart run build_runner build --delete-conflicting-outputs` çalıştır
3. Kod yazdın mı? → `flutter analyze` ile kontrol et
4. Hata gördün mü? → Otomatik düzelt
5. Test edilebilir kod mu? → Test yaz

### Dikkat Edilmesi Gerekenler
- Her zaman Türkçe yorum ve string'ler kullan
- Emoji kullanımını koruma (UI'da önemli)
- Dark theme renklerini ve gradient'leri koru
- AppSpacing, AppColors, AppTextStyles sabitlerini kullan
- Immutable pattern'leri koru (Freezed, copyWith)
- State güncellemelerinde yan etki yaratma
