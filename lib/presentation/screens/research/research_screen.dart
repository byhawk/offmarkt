import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/research_development.dart';
import '../../providers/research_provider.dart';
import '../../widgets/research/research_node_widget.dart';

class ResearchScreen extends ConsumerWidget {
  const ResearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchState = ref.watch(researchNotifierProvider);
    final researchTree = researchState.researchTree;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teknoloji Ağacı'),
      ),
      body: researchTree.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.8,
              ),
              itemCount: researchTree.length,
              itemBuilder: (context, index) {
                final node = researchTree[index];
                final status = researchState.getNodeStatus(node.id);
                return ResearchNodeWidget(
                  node: node,
                  status: status,
                  onTap: () => _showResearchDetailDialog(context, ref, node, status),
                );
              },
            ),
    );
  }

  void _showResearchDetailDialog(BuildContext context, WidgetRef ref, ResearchNode node, ResearchStatus status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(node.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(node.description, style: AppTextStyles.bodyMedium),
                const Gap(AppSpacing.lg),
                Text('Gereksinimler', style: AppTextStyles.h4),
                const Gap(AppSpacing.sm),
                Text('Maliyet: ${node.researchPointsCost} Puan'),
                Text('Süre: ${node.durationSeconds} saniye'),
                const Gap(AppSpacing.lg),
                Text('Bonus', style: AppTextStyles.h4),
                const Gap(AppSpacing.sm),
                Text('${node.bonusType.name}: +${node.bonusValue}%'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kapat'),
            ),
            if (status == ResearchStatus.available)
              ElevatedButton(
                onPressed: () {
                  ref.read(researchNotifierProvider.notifier).startResearch(node.id);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Araştırmayı Başlat'),
              ),
          ],
        );
      },
    );
  }
}