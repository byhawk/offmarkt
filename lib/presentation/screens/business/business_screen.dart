import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/research_development.dart';
import '../../../data/models/shop.dart';
import '../../providers/shops_provider.dart';
import '../../widgets/common/gradient_card.dart';
import '../../widgets/common/stat_card.dart';
import '../research/research_screen.dart';
import '../hr/hr_screen.dart';
import '../../providers/research_provider.dart';

class BusinessScreen extends ConsumerStatefulWidget {
  const BusinessScreen({super.key});

  @override
  ConsumerState<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends ConsumerState<BusinessScreen> {
  @override
  void initState() {
    super.initState();
    // Load player's owned shops when screen opens
    Future.microtask(() {
      ref.read(playerShopsNotifierProvider.notifier).loadPlayerShops();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerShops = ref.watch(playerShopsNotifierProvider);

    // İşletme istatistikleri
    final totalRevenue = playerShops.fold<double>(
      0,
      (sum, shop) => sum + shop.monthlyRevenue,
    );
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
                    label: 'Toplam Gelir',
                    value: Formatters.formatCurrency(totalRevenue),
                    gradientColors: AppColors.successGradient,
                  ),
                  const Gap(AppSpacing.xl),

                  // Aktif Araştırma
                  Text('Aktif Araştırma', style: AppTextStyles.h3),
                  const Gap(AppSpacing.md),
                  _ActiveResearchCard(),
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
  final ShopInstance shop;

  const _BusinessCard({required this.shop});

  String _getShopIcon(String shopType) {
    switch (shopType) {
      case 'supermarket':
        return '🛒';
      case 'flower_shop':
        return '🌸';
      case 'clothing_store':
        return '👕';
      case 'electronics':
        return '📱';
      case 'food_shop':
        return '🍔';
      case 'general':
        return '🏪';
      default:
        return '🏢';
    }
  }

  String _getShopTypeName(String shopType) {
    switch (shopType) {
      case 'supermarket':
        return 'Süpermarket';
      case 'flower_shop':
        return 'Çiçekçi';
      case 'clothing_store':
        return 'Giyim Mağazası';
      case 'electronics':
        return 'Elektronik';
      case 'food_shop':
        return 'Yiyecek Dükkanı';
      case 'general':
        return 'Genel Mağaza';
      default:
        return 'Dükkan';
    }
  }

  @override
  Widget build(BuildContext context) {

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
                _getShopIcon(shop.shopType),
                style: const TextStyle(fontSize: 36),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.customName, style: AppTextStyles.h4),
                    Text(
                      _getShopTypeName(shop.shopType),
                      style: AppTextStyles.caption,
                    ),
                    Text(
                      '${shop.city}, ${shop.country}',
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
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
                  label: 'Müşteri Sayısı',
                  value: '${shop.monthlyCustomers}',
                  valueColor: Colors.white,
                ),
                const Gap(AppSpacing.xs),
                _StatRow(
                  label: 'Satılan Ürün',
                  value: '${shop.listedProducts.length}',
                  valueColor: Colors.white70,
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),

          // Aksiyon butonları
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HrScreen()));
                  },
                  icon: const Icon(Icons.groups, size: 18),
                  label: const Text('Çalışanlar'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ürün yönetimi yakında eklenecek!')),
                    );
                  },
                  icon: const Icon(Icons.inventory_2, size: 18),
                  label: const Text('Ürünler'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Raporlar yakında eklenecek!')),
                    );
                  },
                  icon: const Icon(Icons.analytics, size: 18),
                  label: const Text('Raporlar'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
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

class _ActiveResearchCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchState = ref.watch(researchNotifierProvider);
    final activeResearch = researchState.player.activeResearch;

    if (activeResearch == null) {
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResearchScreen())),
        child: GradientCard(
          child: Row(
            children: [
              const Icon(Icons.science_outlined, size: 28, color: AppColors.textMuted),
              const Gap(AppSpacing.md),
              Expanded(child: Text('Aktif araştırma yok.', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted))),
              const Icon(Icons.arrow_forward_ios, color: AppColors.textMuted),
            ],
          ),
        ),
      );
    }

    final node = researchState.researchTree.firstWhere((n) => n.id == activeResearch.nodeId);
    final progress = DateTime.now().difference(activeResearch.startTime).inSeconds / activeResearch.endTime.difference(activeResearch.startTime).inSeconds;
    final timeRemaining = activeResearch.endTime.difference(DateTime.now());

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResearchScreen())),
      child: GradientCard(
        gradientColors: AppColors.primaryGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.science, size: 28),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Text(
                    node.name,
                    style: AppTextStyles.h4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentGold),
                minHeight: 12,
              ),
            ),
            const Gap(AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kalan Süre: ${Formatters.formatDuration(timeRemaining)}',
                  style: AppTextStyles.caption.copyWith(color: Colors.white70),
                ),
                Text(
                  '${(progress * 100).clamp(0, 100).toStringAsFixed(0)}%',
                  style: AppTextStyles.caption.copyWith(color: Colors.white),
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hızlandırma özelliği yakında gelecek!')),
                  );
                },
                icon: const Icon(Icons.rocket_launch, size: 18),
                label: const Text('Hızlandır'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  foregroundColor: AppColors.backgroundPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
