import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class HoldingScreen extends StatelessWidget {
  const HoldingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🏛️', style: TextStyle(fontSize: 64)),
            const Gap(AppSpacing.md),
            Text('Holding Yönetimi', style: AppTextStyles.h3),
            const Gap(AppSpacing.sm),
            Text(
              'Bu özellik yakında gelecek.',
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}