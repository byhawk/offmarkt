import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/holding.dart';

class HoldingMemberCard extends StatelessWidget {
  final HoldingMember member;

  const HoldingMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(_getRankIcon(member.rank), color: _getRankColor(member.rank)),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.playerName, style: AppTextStyles.bodyLarge),
                Text(member.rank.displayName, style: AppTextStyles.caption.copyWith(color: _getRankColor(member.rank))),
              ],
            ),
          ),
          const Gap(AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Katkı', style: AppTextStyles.caption),
              Text(
                Formatters.formatCurrencyShort(member.totalContribution),
                style: AppTextStyles.label.copyWith(color: AppColors.success),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getRankIcon(HoldingRank rank) {
    switch (rank) {
      case HoldingRank.ceo:
        return Icons.star;
      case HoldingRank.executive:
        return Icons.shield;
      case HoldingRank.member:
        return Icons.person;
    }
  }

  Color _getRankColor(HoldingRank rank) {
    switch (rank) {
      case HoldingRank.ceo:
        return AppColors.accentGold;
      case HoldingRank.executive:
        return AppColors.primaryLight;
      case HoldingRank.member:
        return AppColors.textSecondary;
    }
  }
}