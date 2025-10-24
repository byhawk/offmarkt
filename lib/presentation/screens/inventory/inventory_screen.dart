import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/market_provider.dart';
import '../../widgets/common/gradient_card.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryNotifierProvider);
    final marketNotifier = ref.watch(marketNotifierProvider.notifier);

    // DEBUG
    print('📦 InventoryScreen: ${inventory.length} items in inventory');

    // Envanter ürünlerini grupla
    final Map<String, List<int>> groupedInventory = {};
    double totalValue = 0.0;
    int totalItems = 0;

    for (var item in inventory) {
      if (!groupedInventory.containsKey(item.productId)) {
        groupedInventory[item.productId] = [];
      }
      groupedInventory[item.productId]!.add(item.quantity);

      final product = marketNotifier.getProductById(item.productId);
      if (product != null) {
        totalValue += product.currentPrice * item.quantity;
      }
      totalItems += item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('📦 Envanter'),
      ),
      body: Column(
        children: [
          // Envanter özeti
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
                  'Envanter Özeti',
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
                const Gap(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$totalItems',
                          style: AppTextStyles.h2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Toplam Ürün',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white24,
                    ),
                    Column(
                      children: [
                        Text(
                          '${groupedInventory.length}',
                          style: AppTextStyles.h2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Çeşit',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white24,
                    ),
                    Column(
                      children: [
                        Text(
                          Formatters.formatCurrency(totalValue),
                          style: AppTextStyles.h3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Toplam Değer',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Envanter listesi
          Expanded(
            child: inventory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '📭',
                          style: TextStyle(fontSize: 64),
                        ),
                        const Gap(AppSpacing.md),
                        Text(
                          'Envanter Boş',
                          style: AppTextStyles.h3.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          'Pazardan ürün satın alarak başlayın',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: groupedInventory.length,
                    itemBuilder: (context, index) {
                      final productId = groupedInventory.keys.elementAt(index);
                      final product = marketNotifier.getProductById(productId);

                      if (product == null) return const SizedBox();

                      final quantities = groupedInventory[productId]!;
                      final totalQty = quantities.fold<int>(0, (a, b) => a + b);
                      final currentValue = product.currentPrice * totalQty;

                      // Ortalama alış fiyatı hesapla
                      final items = inventory.where((i) => i.productId == productId).toList();
                      final avgPurchasePrice = items.isEmpty
                          ? 0.0
                          : items.fold<double>(0, (sum, item) =>
                              sum + (item.purchasePrice * item.quantity)) / totalQty;

                      final profitLoss = (product.currentPrice - avgPurchasePrice) * totalQty;
                      final profitPercent = avgPurchasePrice > 0
                          ? ((product.currentPrice - avgPurchasePrice) / avgPurchasePrice) * 100
                          : 0.0;

                      return _InventoryCard(
                        product: product,
                        totalQuantity: totalQty,
                        averagePurchasePrice: avgPurchasePrice,
                        currentValue: currentValue,
                        profitLoss: profitLoss,
                        profitPercent: profitPercent,
                        onSell: () {
                          // Satış için Market ekranına yönlendir
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pazar ekranından ${product.name} satabilirsiniz'),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final dynamic product;
  final int totalQuantity;
  final double averagePurchasePrice;
  final double currentValue;
  final double profitLoss;
  final double profitPercent;
  final VoidCallback onSell;

  const _InventoryCard({
    required this.product,
    required this.totalQuantity,
    required this.averagePurchasePrice,
    required this.currentValue,
    required this.profitLoss,
    required this.profitPercent,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    final isProfit = profitLoss >= 0;
    final profitColor = isProfit ? AppColors.success : AppColors.danger;

    return GradientCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Text(
                      product.name,
                      style: AppTextStyles.h3,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      '$totalQuantity adet',
                      style: AppTextStyles.label.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // Merkezi Kar/Zarar Göstergesi
          Column(
            children: [
              Text(
                '${isProfit ? '+' : ''}${Formatters.formatCurrency(profitLoss)}',
                style: AppTextStyles.h2.copyWith(color: profitColor, fontWeight: FontWeight.bold),
              ),
              Text(
                '(${isProfit ? '+' : ''}${profitPercent.toStringAsFixed(1)}%)',
                style: AppTextStyles.bodyLarge.copyWith(color: profitColor),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),

          // Fiyat bilgileri
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
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
                        Text('Ortalama Alış', style: AppTextStyles.caption),
                        Text(
                          Formatters.formatCurrency(averagePurchasePrice),
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Şu Anki Fiyat', style: AppTextStyles.caption),
                        Text(
                          Formatters.formatCurrency(product.currentPrice),
                          style: AppTextStyles.label.copyWith(color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(AppSpacing.sm),
                const Divider(color: Colors.white24, height: 1),
                const Gap(AppSpacing.sm),
                Column(
                  children: [
                    Text('Toplam Değer', style: AppTextStyles.caption),
                    Text(
                      Formatters.formatCurrency(currentValue),
                      style: AppTextStyles.h4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),

          // Sat butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onSell,
              icon: const Icon(Icons.sell),
              label: const Text('Pazarda Sat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
