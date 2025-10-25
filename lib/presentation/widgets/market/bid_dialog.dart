import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/auction.dart';
import '../../../data/models/player.dart';
import '../../providers/player_provider.dart';

class BidDialog extends ConsumerStatefulWidget {
  final Auction auction;
  final Function(double) onBidPlaced;

  const BidDialog({
    super.key,
    required this.auction,
    required this.onBidPlaced,
  });

  @override
  ConsumerState<BidDialog> createState() => _BidDialogState();
}

class _BidDialogState extends ConsumerState<BidDialog> {
  final _bidController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Başlangıç teklifi olarak mevcut fiyattan biraz daha fazlasını öner
    _bidController.text = (widget.auction.currentPrice * 1.1).toStringAsFixed(0);
  }

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  void _submitBid(Player player) {
    if (_formKey.currentState!.validate()) {
      final bidAmount = double.tryParse(_bidController.text) ?? 0;
      if (bidAmount > player.cash) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Yetersiz bakiye!'), backgroundColor: AppColors.danger),
        );
        return;
      }
      if (bidAmount <= widget.auction.currentPrice) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Teklif, mevcut fiyattan yüksek olmalı!'), backgroundColor: AppColors.danger),
        );
        return;
      }
      widget.onBidPlaced(bidAmount);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerNotifierProvider);

    return AlertDialog(
      title: Text(widget.auction.itemName),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mevcut Teklif: ${Formatters.formatCurrency(widget.auction.currentPrice)}', style: AppTextStyles.bodyLarge),
              Text('Bakiyeniz: ${Formatters.formatCurrency(player.cash)}', style: AppTextStyles.caption),
              const Gap(AppSpacing.lg),
              TextFormField(
                controller: _bidController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Teklifiniz',
                  prefixText: '₺',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir teklif girin.';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Geçersiz sayı.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () => _submitBid(player),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
          child: const Text('Teklifi Onayla'),
        ),
      ],
    );
  }
}