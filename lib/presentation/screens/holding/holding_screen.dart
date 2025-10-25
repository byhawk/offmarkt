import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/holding.dart';
import '../../providers/holding_provider.dart';
import '../../providers/player_provider.dart';
import '../../widgets/holding/holding_member_card.dart';

class HoldingScreen extends ConsumerWidget {
  const HoldingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final holding = ref.watch(holdingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(holding == null ? 'Holding' : '[${holding.tag}] ${holding.name}'),
      ),
      body: player.holdingId == null
          ? const _NoHoldingView()
          : holding == null
              ? const Center(child: CircularProgressIndicator())
              : _HoldingDetailView(holding: holding),
    );
  }
}

class _NoHoldingView extends StatelessWidget {
  const _NoHoldingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🏛️', style: TextStyle(fontSize: 80)),
            const Gap(AppSpacing.lg),
            Text(
              'Bir Holdingin Parçası Değilsin',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.md),
            Text(
              'Güçlerinizi birleştirmek için bir holding kurun veya mevcut bir holdinge katılın.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () { /* TODO: Holding kurma diyalogu */ },
                icon: const Icon(Icons.add_business),
                label: const Text('Holding Kur'),
              ),
            ),
            const Gap(AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () { /* TODO: Holding arama/listeleme ekranı */ },
                icon: const Icon(Icons.search),
                label: const Text('Holdinge Katıl'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoldingDetailView extends ConsumerWidget {
  final Holding holding;
  const _HoldingDetailView({required this.holding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HoldingHeader(holding: holding),
            const Gap(AppSpacing.lg),
            Text('Üyeler (${holding.members.length})', style: AppTextStyles.h4),
            const Gap(AppSpacing.md),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: holding.members.length,
              itemBuilder: (context, index) {
                return HoldingMemberCard(member: holding.members[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HoldingHeader extends StatelessWidget {
  final Holding holding;
  const _HoldingHeader({required this.holding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text('Hazine', style: AppTextStyles.h4.copyWith(color: AppColors.textMuted)),
          const Gap(AppSpacing.sm),
          Text(
            Formatters.formatCurrency(holding.treasury),
            style: AppTextStyles.h1.copyWith(color: AppColors.accentGold),
          ),
          const Gap(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.leaderboard, size: 16, color: AppColors.textMuted),
              const Gap(AppSpacing.sm),
              Text('Seviye: ${holding.level}', style: AppTextStyles.label),
            ],
          ),
          const Gap(AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () { /* TODO: Para yatırma diyalogu */ },
            icon: const Icon(Icons.attach_money),
            label: const Text('Hazineye Para Yatır'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGold.withOpacity(0.8),
              foregroundColor: AppColors.backgroundPrimary,
            ),
          ),
        ],
      ),
    );
  }
}