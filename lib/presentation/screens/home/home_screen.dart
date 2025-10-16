import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/player_provider.dart';
import '../../providers/market_provider.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/gradient_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final products = ref.watch(marketNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OffMarket'),
        actions: [
          // Gün göstergesi
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                Formatters.formatDay(player.currentDay),
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Oyuncu bilgileri
              Text(
                'Hoş Geldin, ${player.name}!',
                style: AppTextStyles.h2,
              ),
              const Gap(AppSpacing.xs),
              Text(
                'Seviye ${player.level} - ${player.experience}/1000 EXP',
                style: AppTextStyles.caption,
              ),
              const Gap(AppSpacing.lg),

              // Finansal durum kartları
              Text(
                'Finansal Durum',
                style: AppTextStyles.h4,
              ),
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

              if (player.debt > 0)
                StatCard(
                  emoji: '📉',
                  label: 'Borç',
                  value: Formatters.formatCurrency(player.debt),
                  gradientColors: AppColors.dangerGradient,
                ),
              const Gap(AppSpacing.lg),

              // İtibar kartları
              Text(
                'İtibar',
                style: AppTextStyles.h4,
              ),
              const Gap(AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      emoji: '⚖️',
                      label: 'Yasal İtibar',
                      value: '${player.legalReputation}/100',
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  Expanded(
                    child: StatCard(
                      emoji: '🌃',
                      label: 'Sokak İtibarı',
                      value: '${player.streetReputation}/100',
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.lg),

              // Risk göstergesi
              if (player.riskLevel > 0) ...[
                StatCard(
                  emoji: '⚠️',
                  label: 'Risk Seviyesi',
                  value: '${player.riskLevel}/100',
                  gradientColors: AppColors.warningGradient,
                ),
                const Gap(AppSpacing.lg),
              ],

              // Hızlı aksiyonlar
              Text(
                'Hızlı Aksiyonlar',
                style: AppTextStyles.h4,
              ),
              const Gap(AppSpacing.md),

              GradientCard(
                gradientColors: AppColors.primaryGradient,
                onTap: () {
                  // Market ekranına git
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pazar yakında gelecek!')),
                  );
                },
                child: Row(
                  children: [
                    const Text('🏪', style: TextStyle(fontSize: 32)),
                    const Gap(AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pazara Git', style: AppTextStyles.h4),
                          Text(
                            '${products.length} ürün mevcut',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
              const Gap(AppSpacing.md),

              GradientCard(
                gradientColors: AppColors.goldGradient,
                onTap: () {
                  // Dükkanlar ekranına git
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dükkanlar yakında gelecek!')),
                  );
                },
                child: Row(
                  children: [
                    const Text('🏢', style: TextStyle(fontSize: 32)),
                    const Gap(AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dükkan Kirala', style: AppTextStyles.h4),
                          Text(
                            'İşletmeni büyüt',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
              const Gap(AppSpacing.lg),

              // İstatistikler
              Text(
                'İstatistikler',
                style: AppTextStyles.h4,
              ),
              const Gap(AppSpacing.md),

              StatCard(
                emoji: '📊',
                label: 'Toplam İşlem',
                value: Formatters.formatNumber(player.totalTransactions),
              ),
              const Gap(AppSpacing.md),

              StatCard(
                emoji: '💹',
                label: 'Toplam Kar',
                value: Formatters.formatCurrency(player.totalProfit),
                gradientColors: player.totalProfit >= 0
                    ? AppColors.successGradient
                    : AppColors.dangerGradient,
              ),

              const Gap(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
