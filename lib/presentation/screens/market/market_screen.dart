import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/product.dart';
import '../../../game/systems/trading_system.dart';
import '../../../services/api_service.dart';
import '../../providers/player_provider.dart';
import '../../providers/market_provider.dart';
import '../../widgets/common/gradient_card.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final products = ref.watch(marketNotifierProvider);
    final inventoryNotifier = ref.watch(inventoryNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏪 Pazar'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                Formatters.formatCurrency(player.cash),
                style: AppTextStyles.label.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Pazar bilgisi header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Ürün Pazarı',
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  '${products.length} ürün mevcut',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Ürün listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final inventoryQty = inventoryNotifier.getQuantity(product.id);

                return _ProductCard(
                  product: product,
                  inventoryQuantity: inventoryQty,
                  playerCash: player.cash,
                  onBuy: (quantity) {
                    _buyProduct(context, ref, product, quantity);
                  },
                  onSell: (quantity) {
                    _sellProduct(context, ref, product, quantity);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Fiyatları güncelle
          ref.read(marketNotifierProvider.notifier).updatePrices();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('📊 Pazar fiyatları güncellendi!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Fiyatları Güncelle'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Future<void> _buyProduct(
    BuildContext context,
    WidgetRef ref,
    Product product,
    int quantity,
  ) async {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final player = ref.read(playerNotifierProvider);

    // TradingSystem ile validasyon
    final (canPurchase, errorMessage) = TradingSystem.purchaseProduct(
      player: player,
      product: product,
      quantity: quantity,
    );

    if (!canPurchase) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      // Backend'e istek gönder
      final apiService = ApiService();
      final response = await apiService.post('/trade/buy', data: {
        'productId': product.id,
        'quantity': quantity,
      });

      if (response.data['success'] == true) {
        // Backend'den güncel player verisini yükle
        await playerNotifier.refreshPlayerData();

        // Inventory'yi yenile
        await ref.read(inventoryNotifierProvider.notifier).loadInventoryFromBackend();

        // Başarı mesajı
        final discount = TradingSystem.calculateBulkDiscount(quantity);
        String message = '✅ $quantity ${product.name} satın alındı!';
        if (discount > 0) {
          message += ' (%${(discount * 100).toStringAsFixed(0)} indirim!)';
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ ${response.data['message'] ?? 'Bilinmeyen hata'}'),
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

  Future<void> _sellProduct(
    BuildContext context,
    WidgetRef ref,
    Product product,
    int quantity,
  ) async {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);

    try {
      // Backend'e istek gönder
      final apiService = ApiService();
      final response = await apiService.post('/trade/sell', data: {
        'productId': product.id,
        'quantity': quantity,
      });

      if (response.data['success'] == true) {
        // Backend'den güncel player verisini yükle
        await playerNotifier.refreshPlayerData();

        // Inventory'yi yenile
        await ref.read(inventoryNotifierProvider.notifier).loadInventoryFromBackend();

        // Başarı mesajı
        final profitData = response.data['data'];
        final profit = profitData['profit'] ?? 0.0;

        String message = '💰 $quantity ${product.name} satıldı!';
        if (profit > 0) {
          message += ' (Kar: +₺${profit.toStringAsFixed(0)})';
        } else if (profit < 0) {
          message += ' (Zarar: ₺${profit.abs().toStringAsFixed(0)})';
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: profit >= 0 ? Colors.green : Colors.orange,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ ${response.data['message'] ?? 'Bilinmeyen hata'}'),
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

class _ProductCard extends StatelessWidget {
  final Product product;
  final int inventoryQuantity;
  final double playerCash;
  final Function(int) onBuy;
  final Function(int) onSell;

  const _ProductCard({
    required this.product,
    required this.inventoryQuantity,
    required this.playerCash,
    required this.onBuy,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    final priceChange = ((product.currentPrice - product.basePrice) / product.basePrice) * 100;
    final canBuy = playerCash >= product.currentPrice;

    return GradientCard(
      gradientColors: product.isTrending
          ? AppColors.goldGradient
          : AppColors.cardGradient,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ürün başlığı
          Row(
            children: [
              Text(
                product.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.h3,
                        ),
                        if (product.isTrending) ...[
                          const Gap(AppSpacing.xs),
                          const Text('🔥', style: TextStyle(fontSize: 16)),
                        ],
                      ],
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      'Talep: ${product.demand}/100',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              // Fiyat değişimi göstergesi
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: priceChange >= 0 ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(1)}%',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // Fiyat bilgisi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fiyat',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    Formatters.formatCurrency(product.currentPrice),
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Stoğunuz',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    '$inventoryQuantity adet',
                    style: AppTextStyles.h4.copyWith(
                      color: inventoryQuantity > 0
                          ? AppColors.success
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // Alım-Satım butonları
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canBuy ? () => _showBuyDialog(context) : null,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Satın Al'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: inventoryQuantity > 0
                      ? () => _showSellDialog(context)
                      : null,
                  icon: const Icon(Icons.sell),
                  label: const Text('Sat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBuyDialog(BuildContext context) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('${product.emoji} ${product.name} Satın Al'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fiyat: ${Formatters.formatCurrency(product.currentPrice)}',
                style: AppTextStyles.h4,
              ),
              const Gap(AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: AppTextStyles.h3,
                  ),
                  IconButton(
                    onPressed: () => setState(() => quantity++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const Gap(AppSpacing.sm),
              Text(
                'Toplam: ${Formatters.formatCurrency(product.currentPrice * quantity)}',
                style: AppTextStyles.h4.copyWith(color: AppColors.success),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onBuy(quantity);
              },
              child: const Text('Satın Al'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSellDialog(BuildContext context) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('${product.emoji} ${product.name} Sat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fiyat: ${Formatters.formatCurrency(product.currentPrice)}',
                style: AppTextStyles.h4,
              ),
              Text(
                'Stoğunuz: $inventoryQuantity adet',
                style: AppTextStyles.caption,
              ),
              const Gap(AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: AppTextStyles.h3,
                  ),
                  IconButton(
                    onPressed: quantity < inventoryQuantity
                        ? () => setState(() => quantity++)
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const Gap(AppSpacing.sm),
              Text(
                'Toplam: ${Formatters.formatCurrency(product.currentPrice * quantity)}',
                style: AppTextStyles.h4.copyWith(color: AppColors.success),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onSell(quantity);
              },
              child: const Text('Sat'),
            ),
          ],
        ),
      ),
    );
  }
}
