import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../services/auth_service.dart';
import '../../providers/player_provider.dart';
import '../../providers/market_provider.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/gradient_card.dart';
import 'dart:async';
import '../auth/login_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isAuctionVisible = true;
  Timer? _auctionTimer;

  @override
  void initState() {
    super.initState();
    // Yanıp sönme efekti için zamanlayıcı
    _auctionTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (mounted) {
        setState(() {
          _isAuctionVisible = !_isAuctionVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _auctionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerNotifierProvider);
    final products = ref.watch(marketNotifierProvider);

    // DEBUG: Player cash'i logla

    return Scaffold(
      appBar: AppBar(
        title: const Text('OffMarket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () => _logout(context, ref),
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
              Text('Hoş Geldin, ${player.name}!', style: AppTextStyles.h2),
              const Gap(AppSpacing.xs),
              Text(
                'Seviye ${player.level} - ${player.experience}/1000 EXP',
                style: AppTextStyles.caption,
              ),
              const Gap(AppSpacing.lg),

              // Finansal durum kartları
              Text('Finansal Durum', style: AppTextStyles.h4),
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

              // Hızlı aksiyonlar
              Text('Hızlı Aksiyonlar', style: AppTextStyles.h4),
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
                          Text('İşletmeni büyüt', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
              const Gap(AppSpacing.md),

              // Canlı İhale Kartı
              AnimatedOpacity(
                opacity: _isAuctionVisible ? 1.0 : 0.6,
                duration: const Duration(milliseconds: 700),
                child: GradientCard(
                  gradientColors: AppColors.dangerGradient,
                  child: Row(
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 32)),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Canlı İhale!', style: AppTextStyles.h4),
                            Text(
                              'Nadir bir arsa satışta!',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.gavel, size: 24),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),

              // İstatistikler
              Text('Genel Bakış', style: AppTextStyles.h4),
              const Gap(AppSpacing.md),

              GradientCard(
                gradientColors: AppColors.darkGradient,
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Toplam Net Kar',
                            style: AppTextStyles.h4.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            Formatters.formatCurrency(player.totalProfit),
                            style: AppTextStyles.h1.copyWith(
                              color: AppColors.accentGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 60, color: AppColors.border),
                    const Gap(AppSpacing.md),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Toplam İşlem',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Gap(AppSpacing.xs),
                          Text(
                            Formatters.formatNumber(player.totalTransactions),
                            style: AppTextStyles.h3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesaptan çıkmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // PlayerProvider'ı resetle
      ref.read(playerNotifierProvider.notifier).reset();

      // Auth token'ları temizle
      final authService = AuthService();
      await authService.logout();

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }
}
