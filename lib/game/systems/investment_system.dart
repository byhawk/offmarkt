import 'package:offmarket_flutter/data/models/investment.dart';
import 'package:offmarket_flutter/data/models/player.dart';

/// Yatırım sistemi için saf fonksiyonlar
/// Tüm fonksiyonlar saf (side-effect içermeyen) fonksiyonlardır
class InvestmentSystem {
  /// Yeni bir şirkette hisse senedi alımını gerçekleştirir
  static (bool success, String? error) purchaseShares({
    required Player player,
    required String companyId,
    required String companyName,
    required int shareCount,
    required double pricePerShare,
    required Function(Player) onPlayerUpdate,
    required Function(Investment) onInvestmentAdd,
  }) {
    // Yeterli nakit kontrolü
    final totalCost = shareCount * pricePerShare;
    if (player.cash < totalCost) {
      return (false, 'Yeterli nakitiniz yok. Gerekli: ₺${totalCost.toStringAsFixed(2)}');
    }

    // Hisse alımı
    final investment = Investment(
      id: 'inv_${DateTime.now().millisecondsSinceEpoch}_$companyId',
      companyId: companyId,
      companyName: companyName,
      shares: shareCount,
      purchasePricePerShare: pricePerShare,
      currentPricePerShare: pricePerShare,
      purchaseDate: DateTime.now(),
    );

    // Oyuncu bakiyesini güncelle
    final updatedPlayer = player.copyWith(
      cash: player.cash - totalCost,
    );

    onPlayerUpdate(updatedPlayer);
    onInvestmentAdd(investment);

    return (true, 'Başarıyla $shareCount adet $companyName hissesi satın aldınız. Toplam maliyet: ₺${totalCost.toStringAsFixed(2)}');
  }

  /// Mevcut hisse senetlerini satma işlemi
  static (bool success, String? error, double profitLoss) sellShares({
    required Player player,
    required Investment investment,
    required int shareCount,
    required double currentPrice,
    required Function(Player) onPlayerUpdate,
    required Function(Investment) onInvestmentUpdate,
    required Function(String) onInvestmentRemove,
  }) {
    if (shareCount <= 0) {
      return (false, 'Satış miktarı 0\'dan büyük olmalıdır', 0.0);
    }

    if (shareCount > investment.shares) {
      return (false, 'Yeterli hisseniz yok. Sahip olduğunuz: ${investment.shares}', 0.0);
    }

    final totalSaleValue = shareCount * currentPrice;
    final totalPurchaseValue = shareCount * investment.purchasePricePerShare;
    final profitLoss = totalSaleValue - totalPurchaseValue;

    // Oyuncu bakiyesini güncelle
    final updatedPlayer = player.copyWith(
      cash: player.cash + totalSaleValue,
    );
    onPlayerUpdate(updatedPlayer);

    // Yatırım miktarını güncelle veya kaldır
    if (shareCount == investment.shares) {
      // Tüm hisseleri sattıysa yatırımı kaldır
      onInvestmentRemove(investment.id);
    } else {
      // Kısmi satış varsa, hisse sayısını güncelle
      final updatedInvestment = investment.copyWith(
        shares: investment.shares - shareCount,
        currentPricePerShare: currentPrice,
      );
      onInvestmentUpdate(updatedInvestment);
    }

    final profitLossText = profitLoss >= 0 ? 'Kar' : 'Zarar';
    return (
      true,
      '$shareCount adet hisse satıldı. $profitLossText: ₺${profitLoss.abs().toStringAsFixed(2)}',
      profitLoss
    );
  }

  /// Portföy değerini hesapla
  static double calculatePortfolioValue(List<Investment> investments) {
    return investments.fold(0.0, (sum, investment) {
      return sum + (investment.shares * investment.currentPricePerShare);
    });
  }

  /// Toplam yatırım tutarını hesapla
  static double calculateTotalInvestment(List<Investment> investments) {
    return investments.fold(0.0, (sum, investment) {
      return sum + (investment.shares * investment.purchasePricePerShare);
    });
  }

  /// Kar/zarar yüzdesini hesapla
  static double calculateProfitLossPercentage(List<Investment> investments) {
    final totalInvestment = calculateTotalInvestment(investments);
    if (totalInvestment == 0) return 0.0;

    final currentValue = calculatePortfolioValue(investments);
    return ((currentValue - totalInvestment) / totalInvestment) * 100;
  }

  /// Günlük hisse senedi fiyat güncellemesi
  static Investment updateSharePrice(Investment investment, double newPrice) {
    return investment.copyWith(currentPricePerShare: newPrice);
  }

  /// Kar payı ödemeleri
  static (Investment updatedInvestment, double dividendAmount) processDividends(
    Investment investment,
    double dividendRate, // Her hisse başı kar payı
  ) {
    final dividendAmount = investment.shares * dividendRate;
    final updatedInvestment = investment.copyWith(
      dividendsReceived: investment.dividendsReceived + dividendAmount,
    );

    return (updatedInvestment, dividendAmount);
  }
}