import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/auction.dart';
import '../common/gradient_card.dart';

class AuctionCard extends StatelessWidget {
  final Auction auction;
  final VoidCallback onBid;

  const AuctionCard({
    super.key,
    required this.auction,
    required this.onBid,
  });

  @override
  Widget build(BuildContext context) {
    final timeRemaining = auction.endTime.difference(DateTime.now());
    final status = _getAuctionStatus(timeRemaining);

    return GradientCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      gradientColors: _getGradientColors(status),
      child: Column(
        children: [
          _AuctionHeader(itemName: auction.itemName, status: status, timeRemaining: timeRemaining),
          const Gap(AppSpacing.md),
          _AuctionBody(auction: auction),
          const Gap(AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: status == AuctionStatus.active ? onBid : null,
              icon: const Icon(Icons.gavel),
              label: const Text('Teklif Ver'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGold,
                foregroundColor: AppColors.backgroundPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }

  AuctionStatus _getAuctionStatus(Duration timeRemaining) {
    if (timeRemaining.isNegative) return AuctionStatus.expired;
    if (timeRemaining.inMinutes < 5) return AuctionStatus.endingSoon;
    return AuctionStatus.active;
  }

  List<Color> _getGradientColors(AuctionStatus status) {
    switch (status) {
      case AuctionStatus.endingSoon:
        return AppColors.dangerGradient;
      default:
        return AppColors.cardGradient;
    }
  }
}

class _AuctionHeader extends StatelessWidget {
  final String itemName;
  final AuctionStatus status;
  final Duration timeRemaining;

  const _AuctionHeader({required this.itemName, required this.status, required this.timeRemaining});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.gavel, size: 28, color: AppColors.primaryLight),
        const Gap(AppSpacing.md),
        Expanded(child: Text(itemName, style: AppTextStyles.h4)),
        const Gap(AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Kalan Süre', style: AppTextStyles.caption),
            Text(
              Formatters.formatDuration(timeRemaining),
              style: AppTextStyles.label.copyWith(color: _getStatusColor(status)),
            ),
          ],
        )
      ],
    );
  }

  Color _getStatusColor(AuctionStatus status) {
    switch (status) {
      case AuctionStatus.endingSoon:
        return AppColors.danger;
      case AuctionStatus.expired:
        return AppColors.textMuted;
      default:
        return AppColors.success;
    }
  }
}

class _AuctionBody extends StatelessWidget {
  final Auction auction;
  const _AuctionBody({required this.auction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('En Yüksek Teklif', style: AppTextStyles.caption),
              Text(Formatters.formatCurrency(auction.currentPrice), style: AppTextStyles.h3.copyWith(color: AppColors.accentGold)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Teklif Sahibi', style: AppTextStyles.caption),
              Text(auction.highestBidderName ?? '---', style: AppTextStyles.label),
            ],
          ),
        ],
      ),
    );
  }
}