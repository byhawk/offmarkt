import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import 'gradient_card.dart';

/// İstatistik gösteren kart widget'ı
class StatCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final List<Color>? gradientColors;
  final Widget? trailing;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.emoji,
    required this.label,
    required this.value,
    this.gradientColors,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradientColors: gradientColors,
      onTap: onTap,
      child: Row(
        children: [
          // Emoji icon
          Text(
            emoji,
            style: const TextStyle(fontSize: AppSpacing.iconLg),
          ),
          const Gap(AppSpacing.md),

          // Label ve Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption,
                ),
                const Gap(AppSpacing.xs),
                Text(
                  value,
                  style: AppTextStyles.numberMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Trailing widget (opsiyonel)
          if (trailing != null) ...[
            const Gap(AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
