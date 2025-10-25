# OffMarket Geliştirme Rehberi

Bu belge, OffMarket iş simülasyon oyununa yeni özellikler eklemek isteyen geliştiriciler için bir kılavuzdur. Projede kullanılan teknolojiler, mimari yapı ve yeni özelliklerin nasıl entegre edileceği hakkında bilgi içerir.

## 1. Proje Mimarisi

OffMarket projesi Flutter tabanlı olup, modern mimari prensiplere göre organize edilmiştir:

### Katmanlar

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

### Teknoloji Yığını

- **Flutter SDK 3.9.2+**
- **Riverpod** - State yönetimi için
- **Freezed** - Immutable modeller ve serialization için
- **Material 3** - UI/UX tasarımı için
- **Shared Preferences** - Yerel veri saklama için

## 2. Yeni Özellik Ekleme

### 2.1. Yeni Oyun Sistemi Ekleme

Yeni bir oyun sistemi eklerken şu adımları izleyin:

1. `lib/game/systems/` klasörüne yeni bir dosya oluşturun (örn. `employee_system.dart`)
2. Sınıfınızı pure fonksiyonlarla tanımlayın:

```dart
import '../../data/models/player.dart';

/// Çalışan yönetimi sistemi
class EmployeeSystem {
  /// Yeni çalışan işe alma
  static (bool, String?) hireEmployee({
    required Player player,
    required double salary,
  }) {
    // İşe alım mantığını burada tanımlayın
    // Yeterli nakit kontrolü, maksimum çalışan sayısı vs.
    if (player.cash < salary) {
      return (false, 'Yetersiz nakit! Gereken: ₺${salary.toStringAsFixed(2)}');
    }
    
    return (true, null);
  }

  /// Maaş ödemesi
  static bool paySalary({
    required Player player,
    required double totalSalary,
  }) {
    if (player.cash >= totalSalary) {
      // Maaş ödeme mantığı
      return true;
    }
    return false;
  }
}
```

### 2.2. Yeni Model Tanımlama

Yeni bir veri modeli eklemek için `lib/data/models/` klasörüne yeni bir dosya oluşturun:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String name,
    required String position,
    required double salary,
    required int level,
    required double morale,
    required DateTime hiredAt,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
}
```

### 2.3. State Yönetimi

Yeni bir state yönetimi eklemek için `lib/presentation/providers/` klasörüne yeni bir dosya oluşturun:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/employee.dart';
import '../../game/systems/employee_system.dart';

part 'employee_provider.g.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState({
    @Default([]) List<Employee> employees,
    @Default(0.0) double totalSalaryCost,
    @Default(0) int maxEmployees,
  }) = _EmployeeState;
}

@Riverpod()
class EmployeeNotifier extends _$EmployeeNotifier {
  @override
  EmployeeState build() {
    return const EmployeeState();
  }

  // Yeni çalışan işe al
  Future<void> hireEmployee(String name, String position, double salary) async {
    // İşe alım mantığı
  }

  // Maaş ödemesi
  void calculateSalaryCost() {
    final total = state.employees.fold(0.0, (sum, emp) => sum + emp.salary);
    state = state.copyWith(totalSalaryCost: total);
  }
}
```

### 2.4. UI Entegrasyonu

Yeni bir ekran veya widget oluşturmak için:

1. `lib/presentation/screens/` veya `lib/presentation/widgets/` klasörüne yeni dosya ekleyin
2. Gerekli provider'ları kullanarak state'leri yönetin
3. UI'yi Material 3 ve mevcut tema yapısına uygun olarak oluşturun

## 3. Mevcut Sistemleri Genişletme

Mevcut sistemlere yeni işlevler eklerken mevcut yapıyı bozmadan genişletilebilirlik ilkesine dikkat edin.

### 3.1. TradingSystem Örneği

```dart
/// Kar/Zarar hesaplama için yeni fonksiyon
static double calculateAdvancedProfitLoss({
  required double purchasePrice,
  required double currentPrice,
  required int quantity,
  required double taxRate, // Yeni parametre
}) {
  final grossProfit = (currentPrice - purchasePrice) * quantity;
  final tax = grossProfit * taxRate;
  return grossProfit - tax;
}

/// Yeni bir validasyon fonksiyonu
static (bool, String?) validateAdvancedPurchase({
  required Player player,
  required Product product,
  required int quantity,
  required String productCategory,
  required int legalReputation,
}) {
  // Mevcut validasyonlar + yeni kurallar
  final (success, error) = purchaseProduct(
    player: player,
    product: product,
    quantity: quantity,
  );
  
  if (!success) return (success, error);
  
  // Yeni kurallar
  if (productCategory == 'controlled' && legalReputation < 50) {
    return (false, 'Yetersiz yasal itibar! Bu ürün için minimum 50 itibar gerekli.');
  }

  return (true, null);
}
```

## 4. Build Runner ve Code Generation

### 4.1. Build Runner Kullanımı

Projede Freezed ve Riverpod için kod oluşturma işlemi build_runner ile yapılır:

```bash
# Build runner çalıştırma (yeni kod oluşturma)
flutter packages pub run build_runner build

# Mevcut dosyaları overwrite ederek çalıştırma
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch modunda çalıştırma (dosya değişikliklerini otomatik takip)
flutter packages pub run build_runner watch
```

**Build runner sonrası oluşan dosyalar:**
- `*.freezed.dart` - Freezed sınıfları için immutable kod
- `*.g.dart` - JSON serialization ve Riverpod provider kodları

### 4.2. GitHub Push Süreci

Değişiklikleri GitHub'a push etmek için:

```bash
# Değişiklikleri stage'e alma
git add .

# Commit mesajı ile commit
git commit -m "feat: Yeni özellik eklendi

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Ana branch'a push
git push origin main
```

**Not:** Personal Access Token gerekebilir:
```bash
# Remote URL'i token ile güncelleme
git remote set-url origin https://YOUR_TOKEN@github.com/byhawk/offmarkt.git
```

### 4.3. Branch Yönetimi

Development workflow için:

```bash
# Feature branch oluşturma
git checkout -b feature/yeni-ozellik

# Feature'ı main'e merge etme
git checkout main
git merge feature/yeni-ozellik

# Conflict çözme (gerekirse)
# Çakışan dosyaları düzenle
git add .
git commit -m "resolve: Merge conflict çözüldü"

# Push
git push origin main
```

## 5. Geliştirme Pratikleri

### 5.1. Kod Standardı

- Fonksiyon isimleri `lowerCamelCase`
- Sınıf isimleri `UpperCamelCase`
- Konstantalar `snake_case`
- Widget isimleri `UpperCamelCase` ve `Widget` soneki
- Provider isimleri `lowerCamelCase` ve `Provider` soneki

### 4.2. Yorumlama ve Dokümantasyon

```dart
/// Ticaret sistemi - Alım satım işlemlerinin pure logic'i
class TradingSystem {
  /// Ürün satın alma
  /// 
  /// [player] - İşlemi gerçekleştiren oyuncu
  /// [product] - Satın alınacak ürün
  /// [quantity] - Alınacak miktar
  /// 
  /// Returns: (success, errorMessage)
  static (bool, String?) purchaseProduct({
    required Player player,
    required Product product,
    required int quantity,
  }) {
    // ...
  }
}
```

### 4.3. Hata Yönetimi

Hataları uygun şekilde ele almak ve kullanıcıya anlamlı mesajlar göstermek önemlidir:

```dart
static (bool, String?) someOperation(...) {
  // Doğrulamalar
  if (someCondition) {
    return (false, 'Anlamlı hata mesajı');
  }
  
  return (true, null);
}
```

## 5. Oyun Dengeleme (Game Balancing)

### 5.1. Ekonomi Dengesi

- Başlangıç parası: 20,000₺
- Ürün fiyatları: 10₺ - 10,000₺ arası
- Riskli işlemler: Daha yüksek kar potansiyeli ama daha yüksek cezalar
- Seviye atlama: 1000 exp başına 1 seviye
- Maksimum seviye: 100

### 5.2. Risk ve Ödül Oranları

- Yasal işlemler: Düşük risk, düşük kar
- Riskli işlemler: Yüksek risk, yüksek kar
- İtibar sistemine göre bonus/ceza oranları
- Zaman bazlı bonuslar (hızlı satış, trend ürün)

## 6. Önerilen Yeni Özellikler ve Uygulama Planı

### 6.1. Yüksek Öncelikli Özellikler

#### 1. Çalışan Yönetimi Sistemi

**Amaç:** Oyuncuların çalışan işe alıp, maaş ödeyip, üretkenliklerini yönetebilmesi

**Gereksinimler:**
- Employee modeli
- EmployeeSystem sınıfı
- EmployeeProvider
- Çalışan yönetim ekranı

**Entegrasyon Noktaları:**
- Player modeline toplam maaş gideri ekleme
- MarketScreen'e maaş etkisi ekleme
- BusinessScreen'e maliyet gösterimi ekleme

#### 2. Gelişmiş Kredi Sistemi

**Amaç:** Daha gerçekçi finansal araçlar sunmak

**Gereksinimler:**
- Loan modeli
- LoanSystem sınıfı
- LoanProvider
- Kredi yönetim ekranı

**Entegrasyon Noktaları:**
- Player modeline kredi bilgileri ekleme
- RiskSystem ile entegrasyon
- ReputationSystem ile entegrasyon

#### 3. Müşteri Yönetimi

**Amaç:** Daha gelişmiş pazarlama ve müşteri ilişkileri mekanikleri

**Gereksinimler:**
- Customer modeli
- CustomerSystem sınıfı
- CustomerProvider
- Müşteri yönetim ekranı

**Entegrasyon Noktaları:**
- TradingSystem ile entegrasyon
- ReputationSystem ile entegrasyon

#### 4. Sigorta Sistemleri

**Amaç:** Risk yönetimi için alternatif yollar sunmak

**Gereksinimler:**
- Insurance modeli
- InsuranceSystem sınıfı
- InsuranceProvider
- Sigorta yönetim ekranı

**Entegrasyon Noktaları:**
- RiskSystem ile entegrasyon
- Player modeline sigorta etkileri ekleme

### 6.2. Orta Öncelikli Özellikler

#### 1. Üretim Zinciri Sistemi

#### 2. Tedarik Zinciri Yönetimi

#### 3. Emlak Yönetimi

#### 4. Marka ve Pazarlama Sistemi

### 6.3. Düşük Öncelikli Özellikler

#### 1. Küresel Genişleme

#### 2. Araştırma ve Geliştirme

#### 3. Gelişmiş Olay Sistemi

## 7. Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. Pull Request açın

## 8. Test Stratejileri

- Unit testler: Oyun sistemlerinin iş mantığını test etmek
- Widget testler: UI bileşenlerinin davranışlarını test etmek
- Entegrasyon testleri: Farklı sistemlerin birlikte çalışmasını test etmek

## 9. Performans İpuçları

- Büyük veri listeleri için lazy loading kullanın
- Gereksiz widget rebuild'lerini önlemek için Riverpod'un immutable yapılarını kullanın
- Heavy computation işlemlerini background thread'de yapın
- Gereksiz network isteklerinden kaçının

## 10. Kaynaklar

- [Flutter Dokümantasyonu](https://flutter.dev/docs)
- [Riverpod Kılavuzu](https://riverpod.dev/)
- [Freezed Paketi](https://pub.dev/packages/freezed)
- [Material 3 Tasarım Rehberi](https://m3.material.io/)
