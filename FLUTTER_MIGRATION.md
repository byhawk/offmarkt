# Flutter'a Geçiş Planı - OffMarket

## 🎯 Hedef
React Native (Expo) + Redux → Flutter + Riverpod

## 📋 Karşılaştırma Tablosu

| Özellik | React Native | Flutter Karşılığı |
|---------|--------------|-------------------|
| **State Management** | Redux Toolkit | Riverpod / Provider |
| **UI Components** | React Components | StatelessWidget / StatefulWidget |
| **Styling** | StyleSheet, LinearGradient | Container, BoxDecoration, Gradient |
| **Navigation** | React Navigation | Navigator 2.0 / go_router |
| **Storage** | AsyncStorage | shared_preferences / Hive |
| **HTTP** | fetch / axios | http / dio |
| **JSON** | JSON.parse() | dart:convert + code generation |

## 🏗️ Flutter Proje Yapısı

```
offmarket_flutter/
├── lib/
│   ├── main.dart                      # Entry point
│   ├── app.dart                       # Material App setup
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── theme.dart            # Colors, TextStyles, Gradients
│   │   │   └── game_constants.dart   # Oyun sabitleri
│   │   ├── utils/
│   │   │   ├── formatters.dart       # Para formatı vb.
│   │   │   └── validators.dart
│   │   └── routes/
│   │       └── app_router.dart       # Navigation
│   │
│   ├── data/
│   │   ├── models/                    # Data classes
│   │   │   ├── player.dart
│   │   │   ├── product.dart
│   │   │   ├── shop.dart
│   │   │   └── market.dart
│   │   ├── repositories/              # Data layer
│   │   │   ├── game_repository.dart
│   │   │   └── storage_repository.dart
│   │   └── datasources/
│   │       ├── local/
│   │       │   └── local_storage.dart
│   │       └── static/
│   │           ├── products.json
│   │           ├── shops.json
│   │           └── events.json
│   │
│   ├── domain/
│   │   ├── entities/                  # Business objects
│   │   └── usecases/                  # Business logic
│   │       ├── trading/
│   │       │   ├── purchase_product.dart
│   │       │   └── sell_product.dart
│   │       ├── shops/
│   │       │   ├── rent_shop.dart
│   │       │   └── open_business.dart
│   │       └── events/
│   │           └── trigger_event.dart
│   │
│   ├── presentation/
│   │   ├── providers/                 # Riverpod providers
│   │   │   ├── player_provider.dart
│   │   │   ├── market_provider.dart
│   │   │   ├── game_provider.dart
│   │   │   └── shops_provider.dart
│   │   │
│   │   ├── screens/
│   │   │   ├── home/
│   │   │   │   ├── home_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── market/
│   │   │   │   ├── market_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── inventory/
│   │   │   │   └── inventory_screen.dart
│   │   │   ├── shops/
│   │   │   │   ├── shops_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── business/
│   │   │   │   └── business_screen.dart
│   │   │   └── stats/
│   │   │       └── stats_screen.dart
│   │   │
│   │   └── widgets/                   # Reusable widgets
│   │       ├── common/
│   │       │   ├── gradient_card.dart
│   │       │   ├── stat_card.dart
│   │       │   └── custom_button.dart
│   │       └── game/
│   │           └── product_card.dart
│   │
│   └── game/
│       ├── systems/                   # Pure game logic
│       │   ├── trading_system.dart
│       │   ├── shop_system.dart
│       │   └── event_system.dart
│       └── engine/
│           └── game_loop.dart
│
├── assets/
│   ├── data/
│   │   ├── products.json
│   │   ├── shops.json
│   │   └── events.json
│   └── images/
│
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
│
└── pubspec.yaml                       # Dependencies
```

## 📦 Gerekli Flutter Paketleri

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.6.1          # Redux yerine
  riverpod_annotation: ^2.6.1

  # Navigation
  go_router: ^14.3.0                 # React Navigation yerine

  # Storage
  shared_preferences: ^2.3.3         # AsyncStorage yerine
  hive: ^2.2.3                       # Daha performanslı alternatif
  hive_flutter: ^1.1.0

  # JSON & Serialization
  json_annotation: ^4.9.0
  freezed_annotation: ^2.4.4         # Immutable models

  # UI
  flutter_animate: ^4.5.0            # Animasyonlar
  gap: ^3.0.1                        # Spacing

  # Utils
  intl: ^0.20.2                      # Para formatı
  uuid: ^4.5.1

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.13
  json_serializable: ^6.9.2
  freezed: ^2.5.7
  riverpod_generator: ^2.6.1

  # Testing
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
```

## 🔄 Kod Dönüşümü Örnekleri

### 1. Redux Slice → Riverpod Provider

**React Native (Redux)**
```typescript
// playerSlice.ts
const playerSlice = createSlice({
  name: 'player',
  initialState: {
    name: 'Oyuncu',
    level: 1,
    cash: 5000,
    // ...
  },
  reducers: {
    updateCash: (state, action) => {
      state.cash = action.payload;
    },
    // ...
  }
});
```

**Flutter (Riverpod)**
```dart
// player_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_provider.freezed.dart';
part 'player_provider.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    @Default('Oyuncu') String name,
    @Default(1) int level,
    @Default(5000.0) double cash,
    @Default(0.0) double bankAccount,
    @Default(0.0) double debt,
    // ...
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@riverpod
class PlayerState extends _$PlayerState {
  @override
  Player build() {
    // Load from storage
    return const Player();
  }

  void updateCash(double amount) {
    state = state.copyWith(cash: amount);
    _saveToStorage();
  }

  void addCash(double amount) {
    state = state.copyWith(cash: state.cash + amount);
    _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('player', jsonEncode(state.toJson()));
  }
}
```

### 2. React Component → Flutter Widget

**React Native**
```typescript
// StatCard.tsx
export const StatCard = ({ icon, label, value, gradient }) => {
  return (
    <LinearGradient colors={gradient} style={styles.card}>
      <Text style={styles.icon}>{icon}</Text>
      <Text style={styles.label}>{label}</Text>
      <Text style={styles.value}>{value}</Text>
    </LinearGradient>
  );
};
```

**Flutter**
```dart
// stat_card.dart
class StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final List<Color> gradient;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const Gap(8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. Navigation

**React Native**
```typescript
navigation.navigate('Market');
```

**Flutter (go_router)**
```dart
context.go('/market');
// veya
context.push('/market');
```

### 4. Game System Logic

**React Native**
```typescript
// trading.ts
export const purchaseProduct = (productId: string, quantity: number): boolean => {
  const state = store.getState();
  const product = state.market.products[productId];
  const cost = product.price * quantity;

  if (state.player.cash < cost) return false;

  store.dispatch(updateCash(state.player.cash - cost));
  store.dispatch(addInventory({ productId, quantity }));

  return true;
};
```

**Flutter**
```dart
// trading_system.dart
class TradingSystem {
  static bool purchaseProduct({
    required Player player,
    required Product product,
    required int quantity,
    required Function(Player) onPlayerUpdate,
    required Function(InventoryItem) onInventoryAdd,
  }) {
    final cost = product.price * quantity;

    if (player.cash < cost) return false;

    final updatedPlayer = player.copyWith(
      cash: player.cash - cost,
    );

    onPlayerUpdate(updatedPlayer);
    onInventoryAdd(InventoryItem(
      productId: product.id,
      quantity: quantity,
      purchasePrice: product.price,
    ));

    return true;
  }
}

// Provider'dan kullanım
final playerNotifier = ref.read(playerStateProvider.notifier);
final inventoryNotifier = ref.read(inventoryStateProvider.notifier);

final success = TradingSystem.purchaseProduct(
  player: ref.read(playerStateProvider),
  product: selectedProduct,
  quantity: quantity,
  onPlayerUpdate: (p) => playerNotifier.updatePlayer(p),
  onInventoryAdd: (item) => inventoryNotifier.addItem(item),
);
```

## 🎨 Theme System

**Flutter theme.dart**
```dart
class AppColors {
  // Primary
  static const primary = Color(0xFF00D4FF);
  static const primaryDark = Color(0xFF00A8CC);

  // Background
  static const backgroundPrimary = Color(0xFF0A0E27);
  static const backgroundSecondary = Color(0xFF151B3D);
  static const backgroundCard = Color(0xFF1E2749);

  // Gradients
  static const primaryGradient = [Color(0xFF00D4FF), Color(0xFF0066FF)];
  static const successGradient = [Color(0xFF00FF87), Color(0xFF00D4AA)];
  static const dangerGradient = [Color(0xFFFF0844), Color(0xFFFF6B9D)];
}

class AppTextStyles {
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ...
}

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundPrimary,
    primaryColor: AppColors.primary,
    // ...
  );
}
```

## 📝 Migration Checklist

### Faz 1: Setup (1 gün)
- [ ] Flutter SDK kurulumu (3.27.0+)
- [ ] Android Studio / VS Code Flutter extension
- [ ] Flutter create ile yeni proje oluştur
- [ ] pubspec.yaml dependencies ekle
- [ ] Proje yapısını oluştur

### Faz 2: Core Models & Data (2-3 gün)
- [ ] Player model (Freezed ile)
- [ ] Product model
- [ ] Shop model
- [ ] Market model
- [ ] InventoryItem model
- [ ] JSON data dosyalarını assets'e taşı
- [ ] JSON parsing test et

### Faz 3: State Management (2 gün)
- [ ] Riverpod providers setup
- [ ] PlayerStateProvider
- [ ] MarketStateProvider
- [ ] GameStateProvider
- [ ] ShopsStateProvider
- [ ] InventoryStateProvider
- [ ] Storage persistence (Hive/SharedPreferences)

### Faz 4: Game Systems (3 gün)
- [ ] TradingSystem (purchase, sell)
- [ ] ShopSystem (rent, open business, revenue calculation)
- [ ] EventSystem (random events)
- [ ] RiskSystem (risk calculation)
- [ ] ReputationSystem
- [ ] LevelSystem

### Faz 5: UI Theme & Common Widgets (2 gün)
- [ ] AppColors, AppTextStyles, AppTheme
- [ ] GradientCard widget
- [ ] StatCard widget
- [ ] CustomButton widget
- [ ] ProductCard widget
- [ ] ShopCard widget

### Faz 6: Screens (5-7 gün)
- [ ] HomeScreen (Dashboard)
- [ ] MarketScreen (Ürün alım-satım)
- [ ] InventoryScreen (Stok yönetimi)
- [ ] ShopsScreen (Dükkan kiralama listesi)
- [ ] BusinessScreen (İşletme detayları)
- [ ] StatsScreen (İstatistikler ve geçmiş)

### Faz 7: Navigation (1 gün)
- [ ] Bottom navigation bar
- [ ] go_router setup
- [ ] Routes tanımla

### Faz 8: Testing & Polish (3-4 gün)
- [ ] Unit tests (game systems)
- [ ] Widget tests (UI components)
- [ ] Integration tests
- [ ] Bug fixes
- [ ] Performance optimization
- [ ] UI polish

### Faz 9: Android Build (1 gün)
- [ ] Android build configuration
- [ ] Test real device
- [ ] APK generate

**Toplam Tahmini Süre: 20-25 gün (3-4 hafta)**

## 🚀 Hızlı Başlangıç Komutları

```bash
# Flutter SDK yükle (Linux)
cd ~
git clone https://github.com/flutter/flutter.git -b stable
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Flutter doctor - kurulum kontrolü
flutter doctor

# Yeni proje oluştur
cd ~/Masaüstü
flutter create offmarket_flutter
cd offmarket_flutter

# Dependencies ekle
# (pubspec.yaml'ı yukarıdaki gibi düzenle)

# Code generation için
flutter pub get
dart run build_runner watch --delete-conflicting-outputs

# Run
flutter run
```

## 🎯 Avantajlar

1. **Performans**: Native'e çok yakın performans
2. **Hot Reload**: Instant UI güncellemeleri
3. **Type Safety**: Dart'ın güçlü tip sistemi
4. **Immutability**: Freezed ile immutable models (Redux gibi)
5. **Testability**: Çok daha kolay unit testing
6. **Android Stability**: Expo'dan çok daha stabil
7. **Future-proof**: Multiplayer eklemek daha kolay

## 📚 Öğrenme Kaynakları

- **Resmi Docs**: https://docs.flutter.dev
- **Riverpod**: https://riverpod.dev
- **Freezed**: https://pub.dev/packages/freezed
- **Flutter Cookbook**: https://docs.flutter.dev/cookbook

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Dart Syntax**: JavaScript'ten farklı (async/await benzer ama farklılıklar var)
2. **Widget Tree**: Her şey widget, iç içe yapı oluşur
3. **Build Context**: Widget tree'de location bilgisi taşır
4. **State Lifecycle**: StatefulWidget lifecycle React'tan farklı
5. **Null Safety**: Dart null-safe, `?` ve `!` operatörleri önemli

---

Başlamaya hazır mısınız? İlk adım olarak Flutter SDK'yı kuralım mı?
