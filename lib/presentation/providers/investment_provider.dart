import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:deal_baron/data/models/investment.dart';

part 'investment_provider.g.dart';

@riverpod
class InvestmentState extends _$InvestmentState {
  @override
  List<Investment> build() {
    // Başlangıçta boş yatırım listesi
    return [];
  }

  // Yeni yatırım ekle
  void addInvestment(Investment investment) {
    final newList = List<Investment>.from(state);
    newList.add(investment);
    state = newList;
  }

  // Yatırımı güncelle
  void updateInvestment(Investment updatedInvestment) {
    final newList = state.map((investment) {
      if (investment.id == updatedInvestment.id) {
        return updatedInvestment;
      }
      return investment;
    }).toList();
    state = newList;
  }

  // Yatırımı kaldır
  void removeInvestment(String investmentId) {
    final newList = state
        .where((investment) => investment.id != investmentId)
        .toList();
    state = newList;
  }

  // Tüm yatırımları temizle (örneğin oyun sıfırlama için)
  void clearInvestments() {
    state = [];
  }

  // Belirli bir şirketteki yatırımı bul
  Investment? getInvestmentByCompanyId(String companyId) {
    try {
      return state.firstWhere(
        (investment) => investment.companyId == companyId,
      );
    } catch (e) {
      return null;
    }
  }

  // Toplam portföy değerini al
  double getPortfolioValue() {
    return state.fold(0.0, (sum, investment) {
      return sum + (investment.shares * investment.currentPricePerShare);
    });
  }

  // Toplam yatırım tutarını al
  double getTotalInvestment() {
    return state.fold(0.0, (sum, investment) {
      return sum + (investment.shares * investment.purchasePricePerShare);
    });
  }

  // Kar/zarar yüzdesini al
  double getProfitLossPercentage() {
    final totalInvestment = getTotalInvestment();
    if (totalInvestment == 0) return 0.0;

    final currentValue = getPortfolioValue();
    return ((currentValue - totalInvestment) / totalInvestment) * 100;
  }

  // Günlük fiyat güncellemesi yap
  void updateSharePrices(Map<String, double> priceUpdates) {
    final updatedList = state.map((investment) {
      if (priceUpdates.containsKey(investment.companyId)) {
        return investment.copyWith(
          currentPricePerShare: priceUpdates[investment.companyId]!,
        );
      }
      return investment;
    }).toList();
    state = updatedList;
  }
}
