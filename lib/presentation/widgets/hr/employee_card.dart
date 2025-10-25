import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/employee.dart';
import '../common/gradient_card.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onFire;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onFire,
  });

  @override
  Widget build(BuildContext context) {
    final moraleColor = employee.morale > 70
        ? AppColors.success
        : employee.morale > 40
            ? AppColors.warning
            : AppColors.danger;

    return GradientCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_pin, size: 40, color: AppColors.primaryLight),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(employee.name, style: AppTextStyles.h4),
                    Text(employee.position, style: AppTextStyles.label),
                  ],
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          _StatRow(
            icon: Icons.paid,
            label: 'Maaş',
            value: Formatters.formatCurrency(employee.salary),
          ),
          const Gap(AppSpacing.sm),
          _StatRow(
            icon: Icons.favorite,
            label: 'Moral',
            value: '${employee.morale.toStringAsFixed(0)}%',
            valueColor: moraleColor,
          ),
          const Gap(AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onFire,
              icon: const Icon(Icons.person_remove, size: 18),
              label: const Text('Kov'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                side: BorderSide(color: AppColors.danger.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const Gap(AppSpacing.sm),
        Text(label, style: AppTextStyles.caption),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.label.copyWith(color: valueColor ?? Colors.white),
        ),
      ],
    );
  }
}