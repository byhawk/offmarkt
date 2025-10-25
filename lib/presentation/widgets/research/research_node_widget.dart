import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/research_development.dart';
import 'package:gap/gap.dart';

class ResearchNodeWidget extends StatelessWidget {
  final ResearchNode node;
  final ResearchStatus status;
  final VoidCallback onTap;

  const ResearchNodeWidget({
    super.key,
    required this.node,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor),
          gradient: _backgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_icon, size: 32, color: _iconColor),
            const Gap(AppSpacing.sm),
            Text(
              node.name,
              style: AppTextStyles.caption.copyWith(color: _textColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color get _borderColor {
    switch (status) {
      case ResearchStatus.locked:
        return AppColors.border;
      case ResearchStatus.available:
        return AppColors.accentGold;
      case ResearchStatus.inProgress:
        return AppColors.primaryLight;
      case ResearchStatus.completed:
        return AppColors.success;
    }
  }

  Color get _iconColor {
    return status == ResearchStatus.locked ? AppColors.textMuted : Colors.white;
  }

  Color get _textColor {
    return status == ResearchStatus.locked ? AppColors.textMuted : Colors.white;
  }

  IconData get _icon {
    switch (status) {
      case ResearchStatus.locked:
        return Icons.lock;
      case ResearchStatus.available:
        return Icons.science_outlined;
      case ResearchStatus.inProgress:
        return Icons.hourglass_bottom;
      case ResearchStatus.completed:
        return Icons.check_circle;
    }
  }

  Gradient? get _backgroundGradient {
    switch (status) {
      case ResearchStatus.locked:
        return null;
      case ResearchStatus.available:
        return LinearGradient(colors: [AppColors.accentGold.withOpacity(0.3), AppColors.accentGold.withOpacity(0.1)]);
      case ResearchStatus.inProgress:
        return LinearGradient(colors: [AppColors.primary.withOpacity(0.5), AppColors.primary.withOpacity(0.2)]);
      case ResearchStatus.completed:
        return LinearGradient(colors: [AppColors.success.withOpacity(0.5), AppColors.success.withOpacity(0.2)]);
    }
  }
}