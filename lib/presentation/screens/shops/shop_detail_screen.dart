import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/shop.dart';
import '../../../services/api_service.dart';
import '../../providers/market_provider.dart';
import '../../widgets/common/gradient_card.dart';

/// Dükkan detay ekranı - Ekonomik sistem yönetimi
class ShopDetailScreen extends ConsumerStatefulWidget {
  final Shop shop;

  const ShopDetailScreen({super.key, required this.shop});

  @override
  ConsumerState<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends ConsumerState<ShopDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Local state
  List<ListedProduct> _shopProducts = [];
  StockStatistics? _stockStats;
  AutoPurchaseSettings? _autoSettings;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadShopData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadShopData() async {
    final apiService = ApiService();
    setState(() => _isLoading = true);

    try {
      // Ürünleri getir
      final productsResponse = await apiService.getShopListedProducts(
        widget.shop.id,
      );
      if (productsResponse['success'] == true) {
        final productsData = productsResponse['products'] as List;
        setState(() {
          _shopProducts = productsData
              .map((p) => ListedProduct.fromJson(p))
              .toList();
          // Stock stats'i parse et (şimdilik mock)
          _stockStats = StockStatistics(
            totalProducts: _shopProducts.length,
            totalStockValue: _shopProducts.fold(
              0.0,
              (sum, p) => sum + (p.currentStock * p.listPrice),
            ),
            lowStockProducts: _shopProducts
                .where((p) => p.currentStock < p.minStock)
                .length,
            highStockProducts: _shopProducts
                .where((p) => p.currentStock > p.maxStock)
                .length,
          );
        });
      }

      // Otomatik ayarları getir
      final settingsResponse = await apiService.getAutoPurchaseSettings(
        widget.shop.id,
      );
      if (settingsResponse['success'] == true) {
        final settingsData = settingsResponse['data']['autoPurchaseSettings'];
        if (settingsData != null) {
          setState(
            () => _autoSettings = AutoPurchaseSettings.fromJson(settingsData),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veri yüklenirken hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _refreshData() => _loadShopData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Yenile',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.inventory), text: 'Ürünler'),
            Tab(icon: Icon(Icons.bar_chart), text: 'Stok Yönetimi'),
            Tab(icon: Icon(Icons.settings), text: 'Otomatik Sistem'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Ürün Yönetimi Tab
                _ProductManagementTab(
                  shop: widget.shop,
                  products: _shopProducts,
                  onProductAdded: _refreshData,
                  onProductUpdated: _refreshData,
                  onProductRemoved: _refreshData,
                ),
                // Stok Yönetimi Tab
                _StockManagementTab(
                  shop: widget.shop,
                  products: _shopProducts,
                  stockStats: _stockStats,
                  onStockUpdated: _refreshData,
                ),
                // Otomatik Sistem Tab
                _AutoSystemTab(
                  shop: widget.shop,
                  autoSettings: _autoSettings,
                  onSettingsUpdated: _refreshData,
                  onAutoPurchaseRequested: _refreshData,
                ),
              ],
            ),
    );
  }
}

/// === ÜRÜN YÖNETİMİ TAB ===
class _ProductManagementTab extends ConsumerStatefulWidget {
  final Shop shop;
  final List<ListedProduct> products;
  final VoidCallback onProductAdded;
  final VoidCallback onProductUpdated;
  final VoidCallback onProductRemoved;

  const _ProductManagementTab({
    required this.shop,
    required this.products,
    required this.onProductAdded,
    required this.onProductUpdated,
    required this.onProductRemoved,
  });

  @override
  ConsumerState<_ProductManagementTab> createState() =>
      _ProductManagementTabState();
}

class _ProductManagementTabState extends ConsumerState<_ProductManagementTab> {
  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddProductDialog(
        shop: widget.shop,
        onProductAdded: widget.onProductAdded,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final marketProducts = ref.watch(marketProductsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: widget.products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('📦', style: TextStyle(fontSize: 64)),
                  const Gap(AppSpacing.md),
                  Text(
                    'Henüz Ürün Yok',
                    style: AppTextStyles.h3.copyWith(color: Colors.grey),
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    'Ürün eklemek için + butonuna tıklayın',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return _ProductListItem(
                  product: widget.products[index],
                  shop: widget.shop,
                  onUpdated: widget.onProductUpdated,
                  onRemoved: widget.onProductRemoved,
                );
              },
            ),
    );
  }
}

/// Ürün listesi öğesi
class _ProductListItem extends StatelessWidget {
  final ListedProduct product;
  final Shop shop;
  final VoidCallback onUpdated;
  final VoidCallback onRemoved;

  const _ProductListItem({
    required this.product,
    required this.shop,
    required this.onUpdated,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final stockPercentage = product.maxStock > 0
        ? (product.currentStock / product.maxStock)
        : 0.0;
    final stockColor = stockPercentage < 0.3
        ? AppColors.danger
        : stockPercentage < 0.7
        ? AppColors.warning
        : AppColors.success;

    return GradientCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.product.name, style: AppTextStyles.h3),
                    Text(
                      product.product.category,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: stockColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stockColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '${product.currentStock}/${product.maxStock}',
                  style: AppTextStyles.label.copyWith(
                    color: stockColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Text(
            'Birim Fiyat: ${Formatters.formatCurrency(product.listPrice)}',
            style: AppTextStyles.label,
          ),
          const Gap(AppSpacing.xs),
          Row(
            children: [
              Text(
                'Toplam Satış: ${product.totalSold}',
                style: AppTextStyles.caption,
              ),
              const Spacer(),
              Icon(
                product.autoPurchase ? Icons.autorenew : Icons.block,
                size: 16,
                color: product.autoPurchase
                    ? AppColors.success
                    : AppColors.danger,
              ),
              const Gap(4),
              Text(
                product.autoPurchase ? 'Otomatik' : 'Manuel',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Ürün güncelle dialog'u
                    showDialog(
                      context: context,
                      builder: (context) => _EditProductDialog(
                        product: product,
                        shop: shop,
                        onUpdated: onUpdated,
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Düzenle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Ürün kaldır dialog'u
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Ürün Kaldır'),
                        content: Text(
                          '${product.product.name} ürününü satıştan kaldırmak istediğinize emin misiniz?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await ApiService().removeListedProduct(
                                  shopId: shop.id,
                                  productId: product.productId,
                                );
                                onRemoved();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Ürün satıştan kaldırıldı'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Hata: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.danger,
                            ),
                            child: const Text('Kaldır'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Kaldır'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: BorderSide(color: AppColors.danger),
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

/// Ürün ekleme dialog'u
class _AddProductDialog extends StatefulWidget {
  final Shop shop;
  final VoidCallback onProductAdded;

  const _AddProductDialog({required this.shop, required this.onProductAdded});

  @override
  State<_AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<_AddProductDialog> {
  String? selectedProductId;
  double listPrice = 100.0;
  int minStock = 5;
  int maxStock = 20;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ürün Ekle'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ürün seçme kısmı yakında eklenecek'),
            const Gap(AppSpacing.md),

            Text('Satış Fiyatı', style: AppTextStyles.label),
            TextFormField(
              initialValue: listPrice.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => listPrice = double.tryParse(value) ?? 0,
              decoration: const InputDecoration(
                prefixText: '₺',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(AppSpacing.md),

            Text('Minimum Stok', style: AppTextStyles.label),
            TextFormField(
              initialValue: minStock.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => minStock = int.tryParse(value) ?? 0,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Gap(AppSpacing.md),

            Text('Maksimum Stok', style: AppTextStyles.label),
            TextFormField(
              initialValue: maxStock.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => maxStock = int.tryParse(value) ?? 0,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (selectedProductId == null) return;

            try {
              await ApiService().listProductInShop(
                shopId: widget.shop.id,
                productId: selectedProductId!,
                listPrice: listPrice,
                minStock: minStock,
                maxStock: maxStock,
              );

              widget.onProductAdded();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ürün eklendi'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hata: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: const Text('Ekle'),
        ),
      ],
    );
  }
}

/// Ürün güncelleme dialog'u
class _EditProductDialog extends StatefulWidget {
  final ListedProduct product;
  final Shop shop;
  final VoidCallback onUpdated;

  const _EditProductDialog({
    required this.product,
    required this.shop,
    required this.onUpdated,
  });

  @override
  State<_EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<_EditProductDialog> {
  late double listPrice;
  late int minStock;
  late int maxStock;
  late bool autoPurchase;

  @override
  void initState() {
    super.initState();
    listPrice = widget.product.listPrice;
    minStock = widget.product.minStock;
    maxStock = widget.product.maxStock;
    autoPurchase = widget.product.autoPurchase;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.product.product.name} Düzenle'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Satış Fiyatı', style: AppTextStyles.label),
            TextFormField(
              initialValue: listPrice.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  listPrice = double.tryParse(value) ?? listPrice,
              decoration: const InputDecoration(
                prefixText: '₺',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(AppSpacing.md),

            Text('Minimum Stok', style: AppTextStyles.label),
            TextFormField(
              initialValue: minStock.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => minStock = int.tryParse(value) ?? minStock,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Gap(AppSpacing.md),

            Text('Maksimum Stok', style: AppTextStyles.label),
            TextFormField(
              initialValue: maxStock.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => maxStock = int.tryParse(value) ?? maxStock,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Gap(AppSpacing.md),

            SwitchListTile(
              title: const Text('Otomatik Alım'),
              value: autoPurchase,
              onChanged: (value) => setState(() => autoPurchase = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await ApiService().updateListedProduct(
                shopId: widget.shop.id,
                productId: widget.product.productId,
                listPrice: listPrice != widget.product.listPrice
                    ? listPrice
                    : null,
                minStock: minStock != widget.product.minStock ? minStock : null,
                maxStock: maxStock != widget.product.maxStock ? maxStock : null,
                autoPurchase: autoPurchase != widget.product.autoPurchase
                    ? autoPurchase
                    : null,
              );

              widget.onUpdated();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ürün güncellendi'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hata: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}

/// === STOK YÖNETİMİ TAB ===
class _StockManagementTab extends StatelessWidget {
  final Shop shop;
  final List<ListedProduct> products;
  final StockStatistics? stockStats;
  final VoidCallback onStockUpdated;

  const _StockManagementTab({
    required this.shop,
    required this.products,
    required this.stockStats,
    required this.onStockUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('📊', style: TextStyle(fontSize: 64)),
            Gap(16),
            Text('Stok bilgisi için önce ürün ekleyin'),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Stok özeti
          if (stockStats != null) ...[
            GradientCard(
              child: Column(
                children: [
                  Text('Stok Özeti', style: AppTextStyles.h3),
                  const Gap(AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        title: 'Toplam Ürün',
                        value: '${stockStats!.totalProducts}',
                        icon: '📦',
                      ),
                      _StatItem(
                        title: 'Toplam Değeri',
                        value: Formatters.formatCurrency(
                          stockStats!.totalStockValue,
                        ),
                        icon: '💰',
                      ),
                      _StatItem(
                        title: 'Düşük Stok',
                        value: '${stockStats!.lowStockProducts}',
                        icon: '⚠️',
                        color: AppColors.warning,
                      ),
                      _StatItem(
                        title: 'Fazla Stok',
                        value: '${stockStats!.highStockProducts}',
                        icon: '📈',
                        color: AppColors.danger,
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Otomatik alım başlat
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Otomatik Alım'),
                          content: const Text(
                            'Eksik ürünleri otomatik olarak satın almak ister misiniz?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('İptal'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  await ApiService().performAutoPurchase(
                                    shop.id,
                                  );
                                  onStockUpdated();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Otomatik alım gerçekleştirildi',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Hata: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text('Başlat'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.autorenew),
                    label: const Text('Otomatik Alım Başlat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.lg),
          ],

          // Ürün stok detayları
          Text('Ürün Stok Durumları', style: AppTextStyles.h3),
          const Gap(AppSpacing.md),

          ...products.map(
            (product) => _StockDetailCard(
              product: product,
              shop: shop,
              onUpdated: onStockUpdated,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color? color;

  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const Gap(4),
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title, style: AppTextStyles.caption, textAlign: TextAlign.center),
      ],
    );
  }
}

class _StockDetailCard extends StatelessWidget {
  final ListedProduct product;
  final Shop shop;
  final VoidCallback onUpdated;

  const _StockDetailCard({
    required this.product,
    required this.shop,
    required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final stockPercentage = product.maxStock > 0
        ? (product.currentStock / product.maxStock)
        : 0.0;
    final stockColor = stockPercentage < 0.3
        ? AppColors.danger
        : stockPercentage < 0.7
        ? AppColors.warning
        : AppColors.success;

    return GradientCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(product.product.name, style: AppTextStyles.h4),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: stockColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stockColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '${product.currentStock}/${product.maxStock}',
                  style: AppTextStyles.label.copyWith(
                    color: stockColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),

          // Stok seviyesi
          LinearProgressIndicator(
            value: stockPercentage,
            backgroundColor: Colors.grey.shade800,
            valueColor: AlwaysStoppedAnimation<Color>(stockColor),
          ),
          const Gap(AppSpacing.xs),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stok Durumu: ${stockPercentage < 0.3
                    ? 'Kritik'
                    : stockPercentage < 0.7
                    ? 'Düşük'
                    : 'Yeterli'}',
                style: AppTextStyles.caption.copyWith(color: stockColor),
              ),
              Text(
                'Değer: ${Formatters.formatCurrency(product.currentStock * product.listPrice)}',
                style: AppTextStyles.caption,
              ),
            ],
          ),

          if (product.currentStock < product.minStock) ...[
            const Gap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.danger.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, size: 16, color: AppColors.danger),
                  const Gap(4),
                  Text(
                    'Stok seviyesi kritik! (${product.minStock - product.currentStock} adet eksik)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// === OTOMATİK SİSTEM TAB ===
class _AutoSystemTab extends StatefulWidget {
  final Shop shop;
  final AutoPurchaseSettings? autoSettings;
  final VoidCallback onSettingsUpdated;
  final VoidCallback onAutoPurchaseRequested;

  const _AutoSystemTab({
    required this.shop,
    required this.autoSettings,
    required this.onSettingsUpdated,
    required this.onAutoPurchaseRequested,
  });

  @override
  State<_AutoSystemTab> createState() => _AutoSystemTabState();
}

class _AutoSystemTabState extends State<_AutoSystemTab> {
  late bool enableBalanceControl;
  late int balanceInterval;
  late double priceAdjustmentRate;
  late bool smartPricing;

  @override
  void initState() {
    super.initState();
    enableBalanceControl = widget.autoSettings?.enableBalanceControl ?? true;
    balanceInterval = widget.autoSettings?.balanceInterval ?? 3600000;
    priceAdjustmentRate = widget.autoSettings?.priceAdjustmentRate ?? 0.02;
    smartPricing = widget.autoSettings?.smartPricing ?? true;
  }

  Future<void> _saveSettings() async {
    try {
      await ApiService().updateAutoPurchaseSettings(
        shopId: widget.shop.id,
        enableBalanceControl: enableBalanceControl,
        balanceInterval: balanceInterval,
        priceAdjustmentRate: priceAdjustmentRate,
        smartPricing: smartPricing,
      );

      widget.onSettingsUpdated();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ayarlar kaydedildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Otomatik Sistem Ayarları', style: AppTextStyles.h3),
          const Gap(AppSpacing.md),

          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: const Text('Arz/Talep Dengesi Kontrolü'),
                  subtitle: const Text('Sistem fiyatları otomatik ayarlasın'),
                  value: enableBalanceControl,
                  onChanged: (value) =>
                      setState(() => enableBalanceControl = value),
                ),

                SwitchListTile(
                  title: const Text('Akıllı Fiyatlandırma'),
                  subtitle: const Text('Supply-demand bazlı fiyat ayarlama'),
                  value: smartPricing,
                  onChanged: (value) => setState(() => smartPricing = value),
                ),

                const Gap(AppSpacing.md),
                const Divider(),
                const Gap(AppSpacing.md),

                Text(
                  'Fiyat Ayarlama Oranı (%${(priceAdjustmentRate * 100).toStringAsFixed(1)})',
                  style: AppTextStyles.label,
                ),
                Slider(
                  value: priceAdjustmentRate,
                  min: 0.01,
                  max: 0.1,
                  divisions: 9,
                  onChanged: (value) =>
                      setState(() => priceAdjustmentRate = value),
                ),

                Text(
                  'Kontrol Aralığı (${balanceInterval ~/ 1000} saniye)',
                  style: AppTextStyles.label,
                ),
                Slider(
                  value: balanceInterval.toDouble(),
                  min: 300000, // 5 dakika
                  max: 86400000, // 24 saat
                  divisions: 20,
                  onChanged: (value) =>
                      setState(() => balanceInterval = value.toInt()),
                ),

                const Gap(AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save),
                    label: const Text('Ayarları Kaydet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Gap(AppSpacing.lg),

          Text('Arz/Talep Analizi', style: AppTextStyles.h3),
          const Gap(AppSpacing.md),

          GradientCard(
            child: Column(
              children: [
                const Text('Analiz özelliği yakında eklenecek'),
                const Gap(AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () {
                    // Arz/talep analizi göster
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bu özellik yakında gelecek'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics),
                  label: const Text('Analizi Göster'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          const Gap(AppSpacing.lg),

          Text('Sistem Durumu', style: AppTextStyles.h3),
          const Gap(AppSpacing.md),

          GradientCard(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    enableBalanceControl && smartPricing
                        ? Icons.check_circle
                        : Icons.pause_circle,
                    color: enableBalanceControl && smartPricing
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                  title: const Text('Otomatik Sistem'),
                  subtitle: Text(
                    enableBalanceControl && smartPricing
                        ? 'Aktif - Sistem çalışıyor'
                        : 'Pasif - Manual kontrol',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.schedule, color: AppColors.primary),
                  title: const Text('Son Güncelleme'),
                  subtitle: const Text('Şu anda güncel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
