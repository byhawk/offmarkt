import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'shop_detail_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/shop.dart';
import '../../../game/systems/shop_system.dart';
import '../../../game/systems/reputation_system.dart';
import '../../providers/player_provider.dart';
import '../../providers/shops_provider.dart';
import '../../widgets/common/gradient_card.dart';

class ShopsScreen extends ConsumerWidget {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shops = ref.watch(shopsNotifierProvider);
    final player = ref.watch(playerNotifierProvider);

    final availableShops = shops.where((s) => s.isAvailable).toList();
    final rentedShops = shops.where((s) => !s.isAvailable).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🏢 Dükkanlar'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Müsait Dükkanlar'),
              Tab(text: 'Kiralananlar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Müsait dükkanlar
            _AvailableShopsTab(shops: availableShops, playerCash: player.cash),
            // Kiralanan dükkanlar - ekonomik sistemle birlikte
            _RentedShopsTab(shops: rentedShops),
          ],
        ),
      ),
    );
  }
}

class _AvailableShopsTab extends ConsumerWidget {
  final List<Shop> shops;
  final double playerCash;

  const _AvailableShopsTab({required this.shops, required this.playerCash});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (shops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🏚️', style: TextStyle(fontSize: 64)),
            const Gap(AppSpacing.md),
            Text(
              'Müsait Dükkan Yok',
              style: AppTextStyles.h3.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final shop = shops[index];
        final canAfford = playerCash >= (shop.deposit + shop.monthlyRent);

        return _ShopCard(
          shop: shop,
          canAfford: canAfford,
          onRent: () => _showRentDialog(context, ref, shop),
        );
      },
    );
  }

  void _showRentDialog(BuildContext context, WidgetRef ref, Shop shop) {
    String selectedCategory = 'electronics';
    String? selectedCountry;
    String? selectedCity;

    // Ülke ve şehir listesi
    final countriesCities = {
      'Türkiye': ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya'],
      'Almanya': ['Berlin', 'Münih', 'Hamburg'],
      'Fransa': ['Paris', 'Marsilya', 'Lyon'],
      'İngiltere': ['Londra', 'Birmingham', 'Leeds'],
      'ABD': ['New York', 'Los Angeles', 'Chicago'],
    };

    final categories = {
      'electronics': '📱 Elektronik',
      'clothing': '👕 Giyim',
      'food': '🍔 Gıda',
      'jewelry': '💎 Mücevher',
      'general': '🏪 Genel',
    };

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final player = ref.watch(playerNotifierProvider);

          // ShopSystem ile gelir tahmini
          final estimatedRevenue = ShopSystem.calculateMonthlyRevenue(
            shop: shop,
            businessCategory: selectedCategory,
            playerLevel: player.level,
            legalReputation: player.legalReputation,
          );

          final locationMultiplier = ShopSystem.getLocationMultiplier(
            shop.locationType,
          );
          final categoryMultiplier = ShopSystem.getCategoryMultiplier(
            selectedCategory,
          );

          return AlertDialog(
            title: Text('${shop.name} Kirala'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dükkan bilgisi gösterimi
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🏪 ${shop.name}', style: AppTextStyles.h4),
                        const Gap(AppSpacing.xs),
                        Text(
                          '${shop.squareMeters} adet Depo • ₺${Formatters.formatCurrency(shop.monthlyRent)}/ay',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.md),

                  // Ülke seçimi
                  Text('Ülkeninizi Seçin:', style: AppTextStyles.label),
                  const Gap(AppSpacing.sm),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                      hintText: 'Öncelikle ülkenizi seçin',
                    ),
                    items: countriesCities.keys.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                        selectedCity = null; // Ülke değiştiğinde şehri sıfırla
                      });
                    },
                  ),
                  const Gap(AppSpacing.md),

                  // Şehir seçimi
                  if (selectedCountry != null) ...[
                    Text('Şehrinizi Seçin:', style: AppTextStyles.label),
                    const Gap(AppSpacing.sm),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        hintText: 'Şehrinizi seçin',
                      ),
                      items: (countriesCities[selectedCountry!] ?? []).map((
                        city,
                      ) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedCity = value);
                      },
                    ),
                    const Gap(AppSpacing.md),
                  ],

                  Text('İşletme Kategorisi Seçin:', style: AppTextStyles.label),
                  const Gap(AppSpacing.sm),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    items: categories.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedCategory = value);
                      }
                    },
                  ),
                  const Gap(AppSpacing.md),

                  // Tahmini gelir gösterimi
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tahmini Aylık Gelir:',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                            Text(
                              Formatters.formatCurrency(estimatedRevenue),
                              style: AppTextStyles.h4.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          '• Lokasyon çarpanı: ${locationMultiplier.toStringAsFixed(1)}x',
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ),
                        Text(
                          '• Kategori çarpanı: ${categoryMultiplier.toStringAsFixed(1)}x',
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ),
                        const Gap(AppSpacing.xs),
                        const Divider(height: 1, color: Colors.white24),
                        const Gap(AppSpacing.xs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tahmini Aylık Kar:',
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              Formatters.formatCurrency(
                                estimatedRevenue - shop.monthlyRent,
                              ),
                              style: AppTextStyles.label.copyWith(
                                color: (estimatedRevenue - shop.monthlyRent) > 0
                                    ? AppColors.success
                                    : AppColors.danger,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () {
                  final player = ref.read(playerNotifierProvider);
                  final playerNotifier = ref.read(
                    playerNotifierProvider.notifier,
                  );

                  // ShopSystem ile validasyon
                  final (canRent, errorMessage) = ShopSystem.canRentShop(
                    player: player,
                    shop: shop,
                  );

                  if (!canRent) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('❌ $errorMessage'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                    return;
                  }

                  final totalCost = shop.deposit + shop.monthlyRent;

                  // Parayı düş
                  playerNotifier.removeCash(totalCost);

                  // Dükkanı kirala
                  ref
                      .read(shopsNotifierProvider.notifier)
                      .rentShop(
                        shop.id,
                        'player_1', // Player ID
                        selectedCategory,
                      );

                  // İtibar bonusu (dükkan kiralama)
                  playerNotifier.applyReputationAction(
                    ReputationAction.rentShop,
                    1,
                  );

                  // Deneyim ekle
                  playerNotifier.addExperience(200);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '✅ ${shop.name} kiralandı! (Tahmini gelir: ${Formatters.formatCurrency(estimatedRevenue)}/ay)',
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: const Text('Kirala'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RentedShopsTab extends ConsumerWidget {
  final List<Shop> shops;

  const _RentedShopsTab({required this.shops});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (shops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🏪', style: TextStyle(fontSize: 64)),
            const Gap(AppSpacing.md),
            Text(
              'Henüz Kiralanan Dükkan Yok',
              style: AppTextStyles.h3.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final player = ref.watch(playerNotifierProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final shop = shops[index];
        return _RentedShopCard(shop: shop, playerLevel: player.level);
      },
    );
  }
}

class _ShopCard extends StatelessWidget {
  final Shop shop;
  final bool canAfford;
  final VoidCallback onRent;

  const _ShopCard({
    required this.shop,
    required this.canAfford,
    required this.onRent,
  });

  String _getLocationIcon(String locationType) {
    switch (locationType) {
      case 'street':
        return '🏪';
      case 'mall':
        return '🏬';
      case 'market':
        return '🛒';
      case 'office':
        return '🏢';
      case 'warehouse':
        return '🏭';
      default:
        return '🏠';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradientColors: canAfford
          ? AppColors.primaryGradient
          : AppColors.cardGradient,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _getLocationIcon(shop.locationType),
                style: const TextStyle(fontSize: 40),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.name, style: AppTextStyles.h3),
                    const Gap(AppSpacing.xs),
                    Text(
                      '${shop.country ?? 'Bilinmiyor'}/${shop.city ?? 'Bilinmiyor'}',
                      style: AppTextStyles.caption,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(shop.location, style: AppTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // Özellikler
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              _FeatureChip(icon: '📦', label: '${shop.squareMeters} adet Depo'),
              _FeatureChip(
                icon: '💰',
                label: '${Formatters.formatCurrency(shop.monthlyRent)}/ay',
              ),
              _FeatureChip(icon: '🏗️', label: '${shop.floor}. Kat'),
              if (shop.hasWindow)
                const _FeatureChip(icon: '🪟', label: 'Vitrinli'),
              if (shop.parkingSpaces > 0)
                _FeatureChip(icon: '🅿️', label: '${shop.parkingSpaces} Park'),
            ],
          ),
          const Gap(AppSpacing.md),

          // Fiyatlar
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aylık Kira', style: AppTextStyles.caption),
                    Text(
                      Formatters.formatCurrency(shop.monthlyRent),
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Depozito', style: AppTextStyles.caption),
                    Text(
                      Formatters.formatCurrency(shop.deposit),
                      style: AppTextStyles.h4.copyWith(color: AppColors.danger),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: canAfford ? onRent : null,
              icon: const Icon(Icons.key),
              label: const Text('Kirala'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RentedShopCard extends StatelessWidget {
  final Shop shop;
  final int playerLevel;

  const _RentedShopCard({required this.shop, required this.playerLevel});

  String _getLocationIcon(String locationType) {
    switch (locationType) {
      case 'street':
        return '🏪';
      case 'mall':
        return '🏬';
      case 'market':
        return '🛒';
      case 'office':
        return '🏢';
      case 'warehouse':
        return '🏭';
      default:
        return '🏠';
    }
  }

  String _getCategoryEmoji(String? category) {
    if (category == null) return '🏪';
    switch (category) {
      case 'electronics':
        return '📱';
      case 'clothing':
        return '👕';
      case 'food':
        return '🍔';
      case 'jewelry':
        return '💎';
      default:
        return '🏪';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ShopSystem ile performans hesaplama
    final profitMargin = shop.monthlyRevenue > 0
        ? ((shop.monthlyRevenue - shop.monthlyRent) / shop.monthlyRevenue * 100)
        : 0.0;

    // Basit bir performans skoru hesaplama (beklenen vs gerçek)
    final expectedRevenue =
        shop.monthlyRevenue * 1.2; // %20 daha yüksek beklenti
    final expectedCustomers = shop.monthlyCustomers + 100;

    final performanceScore = ShopSystem.calculatePerformanceScore(
      shop: shop,
      actualRevenue: shop.monthlyRevenue,
      expectedRevenue: expectedRevenue,
      actualCustomers: shop.monthlyCustomers,
      expectedCustomers: expectedCustomers,
    );

    final performanceRating = ShopSystem.getPerformanceRating(performanceScore);

    // Performans rengi
    Color performanceColor;
    if (performanceScore >= 80) {
      performanceColor = AppColors.success;
    } else if (performanceScore >= 60) {
      performanceColor = Colors.lightGreen;
    } else if (performanceScore >= 40) {
      performanceColor = AppColors.warning;
    } else {
      performanceColor = AppColors.danger;
    }

    return GradientCard(
      gradientColors: shop.isActive
          ? AppColors.successGradient
          : AppColors.warningGradient,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _getLocationIcon(shop.locationType),
                style: const TextStyle(fontSize: 40),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.name, style: AppTextStyles.h3),
                    const Gap(AppSpacing.xs),
                    Text(
                      '${shop.country ?? 'Bilinmiyor'}/${shop.city ?? 'Bilinmiyor'}',
                      style: AppTextStyles.caption,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(shop.location, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Text(
                _getCategoryEmoji(shop.businessCategory),
                style: const TextStyle(fontSize: 32),
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // Performans göstergesi
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: performanceColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: performanceColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Performans', style: AppTextStyles.caption),
                    Text(
                      performanceRating,
                      style: AppTextStyles.h4.copyWith(
                        color: performanceColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Skor', style: AppTextStyles.caption),
                    Text(
                      '${performanceScore.toStringAsFixed(0)}/100',
                      style: AppTextStyles.h4.copyWith(
                        color: performanceColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.sm),

          // İstatistikler
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Aylık Gelir', style: AppTextStyles.caption),
                        Text(
                          Formatters.formatCurrency(shop.monthlyRevenue),
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Müşteriler', style: AppTextStyles.caption),
                        Text(
                          '${shop.monthlyCustomers}',
                          style: AppTextStyles.h4,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(AppSpacing.sm),
                const Divider(color: Colors.white24, height: 1),
                const Gap(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aylık Kira:', style: AppTextStyles.caption),
                    Text(
                      Formatters.formatCurrency(shop.monthlyRent),
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kar Marjı:', style: AppTextStyles.caption),
                    Text(
                      '%${profitMargin.toStringAsFixed(1)}',
                      style: AppTextStyles.label.copyWith(
                        color: profitMargin > 0
                            ? AppColors.success
                            : AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Ekonomik sistem detaylarına git
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopDetailScreen(shop: shop),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics),
                  label: const Text('Detaylar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Dükkanı bırak
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Bırak'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: BorderSide(color: AppColors.danger),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 12)),
          const Gap(4),
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
