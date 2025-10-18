import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/research_development.dart';
import '../../providers/shops_provider.dart';
import '../../widgets/common/gradient_card.dart';
import '../../widgets/common/stat_card.dart';

class BusinessScreen extends ConsumerWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsNotifier = ref.watch(shopsNotifierProvider.notifier);
    final playerShops = shopsNotifier.getPlayerShops('player_1');

    // İşletme istatistikleri
    final totalRevenue = playerShops.fold<double>(
      0,
      (sum, shop) => sum + shop.monthlyRevenue,
    );
    final totalRent = playerShops.fold<double>(
      0,
      (sum, shop) => sum + shop.monthlyRent,
    );
    final netProfit = totalRevenue - totalRent;
    final totalCustomers = playerShops.fold<int>(
      0,
      (sum, shop) => sum + shop.monthlyCustomers,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('💼 İşletmelerim')),
      body: playerShops.isEmpty
          ? _EmptyBusinessView()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genel özet
                  Text('İşletme Özeti', style: AppTextStyles.h3),
                  const Gap(AppSpacing.md),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          emoji: '🏪',
                          label: 'Toplam Dükkan',
                          value: '${playerShops.length}',
                          gradientColors: AppColors.primaryGradient,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: StatCard(
                          emoji: '👥',
                          label: 'Müşteriler',
                          value: '$totalCustomers',
                          gradientColors: AppColors.successGradient,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),

                  StatCard(
                    emoji: '💰',
                    label: 'Aylık Gelir',
                    value: Formatters.formatCurrency(totalRevenue),
                    gradientColors: AppColors.successGradient,
                  ),
                  const Gap(AppSpacing.md),

                  StatCard(
                    emoji: '🏠',
                    label: 'Aylık Kira',
                    value: Formatters.formatCurrency(totalRent),
                    gradientColors: AppColors.dangerGradient,
                  ),
                  const Gap(AppSpacing.md),

                  StatCard(
                    emoji: '📊',
                    label: 'Net Kar',
                    value: Formatters.formatCurrency(netProfit),
                    gradientColors: netProfit >= 0
                        ? AppColors.successGradient
                        : AppColors.dangerGradient,
                  ),
                  const Gap(AppSpacing.xl),

                  // Dükkan detayları
                  Text('Dükkanlarım', style: AppTextStyles.h3),
                  const Gap(AppSpacing.md),

                  ...playerShops.map((shop) => _BusinessCard(shop: shop)),
                ],
              ),
            ),
    );
  }
}

class _EmptyBusinessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🏪', style: TextStyle(fontSize: 80)),
          const Gap(AppSpacing.lg),
          Text(
            'Henüz İşletmeniz Yok',
            style: AppTextStyles.h2.copyWith(color: Colors.grey),
          ),
          const Gap(AppSpacing.sm),
          Text(
            'Dükkanlar sekmesinden işletme kiralayın',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.xl),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to shops screen
            },
            icon: const Icon(Icons.store),
            label: const Text('Dükkanları Gör'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessCard extends StatelessWidget {
  final dynamic shop;

  const _BusinessCard({required this.shop});

  String _getLocationIcon(String locationType) {
    switch (locationType) {
      case 'street':
        return '🏪';
      case 'mall':
        return '🏬';
      case 'market':
        return '🛒';
      case 'office':
        return '🏢';
      case 'warehouse':
        return '🏭';
      default:
        return '🏠';
    }
  }

  String _getCategoryName(String? category) {
    if (category == null) return 'Genel';
    switch (category) {
      case 'electronics':
        return 'Elektronik';
      case 'clothing':
        return 'Giyim';
      case 'food':
        return 'Gıda';
      case 'jewelry':
        return 'Mücevher';
      default:
        return 'Genel';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profitMargin = shop.monthlyRent > 0
        ? ((shop.monthlyRevenue - shop.monthlyRent) / shop.monthlyRent) * 100
        : 0.0;

    return GradientCard(
      gradientColors: shop.isActive
          ? AppColors.successGradient
          : AppColors.warningGradient,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(
            children: [
              Text(
                _getLocationIcon(shop.locationType),
                style: const TextStyle(fontSize: 36),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.name, style: AppTextStyles.h4),
                    Text(
                      _getCategoryName(shop.businessCategory),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: shop.isActive ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  shop.isActive ? 'Aktif' : 'Pasif',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),

          // İstatistikler
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _StatRow(
                  label: 'Aylık Gelir',
                  value: Formatters.formatCurrency(shop.monthlyRevenue),
                  valueColor: AppColors.success,
                ),
                const Gap(AppSpacing.xs),
                _StatRow(
                  label: 'Aylık Kira',
                  value: Formatters.formatCurrency(shop.monthlyRent),
                  valueColor: AppColors.danger,
                ),
                const Gap(AppSpacing.xs),
                const Divider(color: Colors.white24, height: 1),
                const Gap(AppSpacing.xs),
                _StatRow(
                  label: 'Net Kar',
                  value: Formatters.formatCurrency(
                    shop.monthlyRevenue - shop.monthlyRent,
                  ),
                  valueColor: (shop.monthlyRevenue - shop.monthlyRent) >= 0
                      ? Colors.green
                      : Colors.red,
                ),
                const Gap(AppSpacing.xs),
                _StatRow(
                  label: 'Kar Marjı',
                  value: '${profitMargin.toStringAsFixed(1)}%',
                  valueColor: profitMargin >= 0 ? Colors.green : Colors.red,
                ),
                const Gap(AppSpacing.xs),
                _StatRow(
                  label: 'Müşteri Sayısı',
                  value: '${shop.monthlyCustomers}',
                  valueColor: Colors.white,
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),

          // Aksiyon butonları
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Ürün ekle / Yönet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ürün yönetimi yakında eklenecek!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.inventory_2),
                  label: const Text('Ürünler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Raporlar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Raporlar yakında eklenecek!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics),
                  label: const Text('Raporlar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.label.copyWith(color: valueColor)),
      ],
    );
  }
}

class _NewProjectDialog extends StatefulWidget {
  final Function(RdRequest) onProjectStart;

  const _NewProjectDialog({required this.onProjectStart});

  @override
  State<_NewProjectDialog> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<_NewProjectDialog> {
  RdProjectType? selectedType;
  RdProjectLevel? selectedLevel;
  final projectNameController = TextEditingController();
  final projectDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('🆕 Yeni Ar-Ge Projesi'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proje Türü', style: AppTextStyles.label),
            DropdownButtonFormField<RdProjectType>(
              value: selectedType,
              items: RdProjectType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.displayName),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedType = value),
            ),
            const Gap(AppSpacing.md),

            Text('Proje Seviyesi', style: AppTextStyles.label),
            DropdownButtonFormField<RdProjectLevel>(
              value: selectedLevel,
              items: RdProjectLevel.values
                  .map(
                    (level) => DropdownMenuItem(
                      value: level,
                      child: Text(level.displayName),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedLevel = value),
            ),
            const Gap(AppSpacing.md),

            Text('Proje Adı', style: AppTextStyles.label),
            TextFormField(
              controller: projectNameController,
              decoration: const InputDecoration(hintText: 'Proje adı girin...'),
            ),
            const Gap(AppSpacing.md),

            Text('Proje Açıklaması', style: AppTextStyles.label),
            TextFormField(
              controller: projectDescController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Proje açıklaması...',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: _canStartProject() ? _startProject : null,
          child: const Text('Başlat'),
        ),
      ],
    );
  }

  bool _canStartProject() {
    return selectedType != null &&
        selectedLevel != null &&
        projectNameController.text.isNotEmpty &&
        projectDescController.text.isNotEmpty;
  }

  void _startProject() {
    final request = RdRequest(
      playerId: 'player_1', // TODO: Get from provider
      type: selectedType!,
      level: selectedLevel!,
      projectName: projectNameController.text,
      projectDescription: projectDescController.text,
    );

    widget.onProjectStart(request);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${request.projectName}" projesi başlatıldı!')),
    );
  }

  @override
  void dispose() {
    projectNameController.dispose();
    projectDescController.dispose();
    super.dispose();
  }
}
