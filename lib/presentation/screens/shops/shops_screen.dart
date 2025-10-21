import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/shop.dart';
import '../../providers/player_provider.dart';
import '../../providers/shops_provider.dart';
import '../../widgets/common/gradient_card.dart';

class ShopsScreen extends ConsumerStatefulWidget {
  const ShopsScreen({super.key});

  @override
  ConsumerState<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends ConsumerState<ShopsScreen> {
  @override
  void initState() {
    super.initState();
    // Load shop types when screen opens
    Future.microtask(() {
      ref.read(shopTypesNotifierProvider.notifier).loadShopTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopTypes = ref.watch(shopTypesNotifierProvider);
    final player = ref.watch(playerNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏢 Dükkanlar'),
      ),
      body: shopTypes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Gap(AppSpacing.md),
                  Text('Dükkanlar yükleniyor...'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: shopTypes.length,
              itemBuilder: (context, index) {
                final shopType = shopTypes[index];
                final canAfford = player.cash >= shopType.purchasePrice;

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
                            _getShopIcon(shopType.shopType),
                            style: const TextStyle(fontSize: 40),
                          ),
                          const Gap(AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shopType.displayName,
                                  style: AppTextStyles.h4,
                                ),
                                const Gap(AppSpacing.xs),
                                Text(
                                  '${shopType.rackCapacity} Raf • ${shopType.storageCapacity} Depo',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('💰 Fiyat', style: AppTextStyles.caption),
                              Text(
                                Formatters.formatCurrency(shopType.purchasePrice),
                                style: AppTextStyles.h4.copyWith(
                                  color: canAfford
                                      ? AppColors.success
                                      : AppColors.danger,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('👥 Min Müşteri', style: AppTextStyles.caption),
                              Text(
                                '${shopType.minCustomers}/gün',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(AppSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: canAfford
                              ? () => _purchaseShop(context, ref, shopType)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: Text(
                            canAfford ? 'Satın Al' : 'Yetersiz Nakit',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _getShopIcon(String shopType) {
    switch (shopType) {
      case 'supermarket':
        return '🛒';
      case 'flower_shop':
        return '🌸';
      case 'clothing_store':
        return '👕';
      case 'electronics':
        return '📱';
      case 'food_shop':
        return '🍔';
      case 'general':
        return '🏪';
      default:
        return '🏢';
    }
  }

  Future<void> _purchaseShop(
    BuildContext context,
    WidgetRef ref,
    ShopType shopType,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${shopType.displayName} Satın Al?'),
        content: Text(
          'Bu dükkanı ${Formatters.formatCurrency(shopType.purchasePrice)} karşılığında satın almak istiyor musunuz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
            ),
            child: const Text('Satın Al'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final playerShopsNotifier = ref.read(playerShopsNotifierProvider.notifier);
      final playerNotifier = ref.read(playerNotifierProvider.notifier);

      final success = await playerShopsNotifier.purchaseShop(
        shopTypeId: shopType.id,
        country: 'Türkiye',
        city: 'İstanbul',
        customName: null,
      );

      if (success) {
        // Player verisini refresh et
        await playerNotifier.refreshPlayerData();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ ${shopType.displayName} başarıyla satın alındı!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('❌ Dükkan satın alınamadı'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
