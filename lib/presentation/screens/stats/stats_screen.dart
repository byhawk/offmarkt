import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/player_provider.dart';
import '../../providers/market_provider.dart';
import '../../providers/shops_provider.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/gradient_card.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final inventory = ref.watch(inventoryNotifierProvider);
    final shopsNotifier = ref.watch(shopsNotifierProvider.notifier);
    final playerShops = shopsNotifier.getPlayerShops('player_1');

    // Toplam varlıklar
    final totalAssets = player.cash + player.bankAccount;
    final netWorth = totalAssets - player.debt;

    // Envanter değeri
    final marketNotifier = ref.watch(marketNotifierProvider.notifier);
    double inventoryValue = 0.0;
    for (var item in inventory) {
      final product = marketNotifier.getProductById(item.productId);
      if (product != null) {
        inventoryValue += product.currentPrice * item.quantity;
      }
    }

    // İşletme değeri
    final totalBusinessRevenue = playerShops.fold<double>(
      0,
      (sum, shop) => sum + shop.monthlyRevenue,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('📊 İstatistikler')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Oyuncu bilgileri
            GradientCard(
              gradientColors: AppColors.primaryGradient,
              child: Column(
                children: [
                  Text(
                    player.name,
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    'Seviye ${player.level}',
                    style: AppTextStyles.h4.copyWith(color: Colors.white70),
                  ),
                  const Gap(AppSpacing.sm),
                  // Seviye progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${player.experience}/1000 EXP',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: player.experience / 1000,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.lg),

            // Finansal özet
            Text('Finansal Durum', style: AppTextStyles.h3),
            const Gap(AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    emoji: '💰',
                    label: 'Nakit',
                    value: Formatters.formatCurrency(player.cash),
                    gradientColors: AppColors.successGradient,
                  ),
                ),
                const Gap(AppSpacing.md),
                Expanded(
                  child: StatCard(
                    emoji: '🏦',
                    label: 'Banka',
                    value: Formatters.formatCurrency(player.bankAccount),
                    gradientColors: AppColors.primaryGradient,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    emoji: '📦',
                    label: 'Envanter Değeri',
                    value: Formatters.formatCurrency(inventoryValue),
                    gradientColors: AppColors.goldGradient,
                  ),
                ),
                const Gap(AppSpacing.md),
                Expanded(
                  child: StatCard(
                    emoji: '💎',
                    label: 'Net Varlık',
                    value: Formatters.formatCurrency(netWorth),
                    gradientColors: netWorth >= 0
                        ? AppColors.successGradient
                        : AppColors.dangerGradient,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),

            if (player.debt > 0)
              StatCard(
                emoji: '📉',
                label: 'Borç',
                value: Formatters.formatCurrency(player.debt),
                gradientColors: AppColors.dangerGradient,
              ),
            const Gap(AppSpacing.lg),

            // İşletme istatistikleri
            Text('İşletme', style: AppTextStyles.h3),
            const Gap(AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    emoji: '🏪',
                    label: 'Dükkan Sayısı',
                    value: '${playerShops.length}',
                    gradientColors: AppColors.primaryGradient,
                  ),
                ),
                const Gap(AppSpacing.md),
                Expanded(
                  child: StatCard(
                    emoji: '💼',
                    label: 'Aylık Gelir',
                    value: Formatters.formatCurrency(totalBusinessRevenue),
                    gradientColors: AppColors.successGradient,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),

            // Oyun istatistikleri
            Text('Oyun İstatistikleri', style: AppTextStyles.h3),
            const Gap(AppSpacing.md),

            StatCard(
              emoji: '📅',
              label: 'Oynanan Gün',
              value: Formatters.formatDay(player.currentDay),
            ),
            const Gap(AppSpacing.md),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    emoji: '🔄',
                    label: 'Toplam İşlem',
                    value: Formatters.formatNumber(player.totalTransactions),
                  ),
                ),
                const Gap(AppSpacing.md),
                Expanded(
                  child: StatCard(
                    emoji: '💹',
                    label: 'Toplam Kar',
                    value: Formatters.formatCurrency(player.totalProfit),
                    gradientColors: player.totalProfit >= 0
                        ? AppColors.successGradient
                        : AppColors.dangerGradient,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),

            // Başarım kartları
            Text('Başarımlar', style: AppTextStyles.h3),
            const Gap(AppSpacing.md),

            _AchievementCard(
              emoji: '🌟',
              title: 'İlk Adım',
              description: 'İlk ürününü satın al',
              isCompleted: player.totalTransactions > 0,
            ),
            const Gap(AppSpacing.md),

            _AchievementCard(
              emoji: '💰',
              title: 'Zengin Olma Yolunda',
              description: '10,000₺ nakit biriktir',
              isCompleted: player.cash >= 10000,
            ),
            const Gap(AppSpacing.md),

            _AchievementCard(
              emoji: '🏪',
              title: 'İş Sahibi',
              description: 'İlk dükkanını kirala',
              isCompleted: playerShops.isNotEmpty,
            ),
            const Gap(AppSpacing.md),

            _AchievementCard(
              emoji: '📈',
              title: 'Başarılı Tacir',
              description: '100 işlem tamamla',
              isCompleted: player.totalTransactions >= 100,
            ),
            const Gap(AppSpacing.md),

            _AchievementCard(
              emoji: '👑',
              title: 'Seviye 10',
              description: '10. seviyeye ulaş',
              isCompleted: player.level >= 10,
            ),

            const Gap(AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final bool isCompleted;

  const _AchievementCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradientColors: isCompleted
          ? AppColors.successGradient
          : AppColors.cardGradient,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h4.copyWith(
                    color: isCompleted ? Colors.white : Colors.grey,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: isCompleted ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check_circle, color: Colors.white, size: 32)
          else
            const Icon(Icons.lock, color: Colors.grey, size: 32),
        ],
      ),
    );
  }
}
