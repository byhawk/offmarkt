import '../../data/models/player.dart';
import '../../data/models/loan.dart';

/// Gelişmiş kredi sistemi
class LoanSystem {
  /// Kredi notu hesaplama
  static CreditScore calculateCreditScore({
    required Player player,
    required List<Loan> playerLoans,
  }) {
    // Temel skor: 500 + (seviye * 10) + (yasal itibar * 3) + (sokak itibarı * 2)
    int baseScore = 500 + (player.level * 10) + (player.legalReputation * 3) + (player.streetReputation * 2);
    
    // Önceki kredilerden etkiler
    int totalLoans = playerLoans.length;
    int paidLoans = playerLoans.where((loan) => loan.status == LoanStatus.paid).length;
    int defaultedLoans = playerLoans.where((loan) => loan.status == LoanStatus.defaulted).length;
    
    // Ödenmiş kredi oranı
    double paidRatio = totalLoans > 0 ? paidLoans / totalLoans : 0;
    int ratioBonus = (paidRatio * 100).round();
    
    // İflas edilmiş krediler cezası
    int defaultPenalty = defaultedLoans * 50;
    
    // Mevcut borç oranı
    double currentDebtRatio = 0;
    if (player.cash + player.bankAccount > 0) {
      currentDebtRatio = player.debt / (player.cash + player.bankAccount);
    }
    
    // Borç oranı cezası
    int debtRatioPenalty = 0;
    if (currentDebtRatio > 1.0) {
      debtRatioPenalty = 100;
    } else if (currentDebtRatio > 0.5) {
      debtRatioPenalty = 50;
    } else if (currentDebtRatio > 0.2) {
      debtRatioPenalty = 20;
    }
    
    int finalScore = baseScore + ratioBonus - defaultPenalty - debtRatioPenalty;
    
    // Skoru sınırla (0-1000)
    finalScore = finalScore.clamp(0, 1000);
    
    return CreditScore(
      playerId: 'player_id_placeholder', // Gerçek uygulamada gerçek ID kullanılacak
      score: finalScore,
      legalReputationImpact: player.legalReputation,
      streetReputationImpact: player.streetReputation,
      riskMultiplier: finalScore > 700 ? 0.8 : finalScore > 500 ? 1.0 : 1.5,
      totalLoans: totalLoans,
      paidLoans: paidLoans,
      defaultedLoans: defaultedLoans,
      currentDebtRatio: currentDebtRatio,
    );
  }

  /// Kredi başvurusu değerlendirmesi
  static (bool, String?, double) evaluateLoanApplication({
    required LoanApplication application,
    required Player player,
    required CreditScore creditScore,
    required List<Loan> playerLoans,
  }) {
    // Maksimum kredi miktarı: oyuncunun seviyesi * 10000
    double maxLoanAmount = player.level * 10000;
    
    // Mevcut borç kontrolü
    if (player.debt > 0 && (player.debt + application.requestedAmount) > (player.cash + player.bankAccount) * 2) {
      return (false, 'Mevcut borç seviyeniz çok yüksek!', 0.0);
    }
    
    // Başvuru miktarı limit kontrolü
    if (application.requestedAmount > maxLoanAmount) {
      return (false, 'Bu seviyede bu kadar büyük kredi alamazsınız! Maksimum: ₺${maxLoanAmount.toStringAsFixed(2)}', 0.0);
    }
    
    // Kredi notuna göre teminat gereksinimi
    double requiredCollateral = 0.0;
    if (creditScore.score < 600) {
      requiredCollateral = application.requestedAmount * 0.5; // %50 teminat
    } else if (creditScore.score < 700) {
      requiredCollateral = application.requestedAmount * 0.3; // %30 teminat
    }
    
    // Teminat yeterliliği kontrolü
    if (requiredCollateral > 0 && application.collateralValue < requiredCollateral) {
      return (false, 'Yetersiz teminat! Gerekli: ₺${requiredCollateral.toStringAsFixed(2)}', 0.0);
    }
    
    // Faiz oranı hesapla
    double baseInterestRate = 0.10; // %10 temel faiz
    double interestRate = baseInterestRate * creditScore.interestRateModifier;
    
    // Vadeye göre faiz ayarı
    if (application.termInDays > 365) {
      interestRate += 0.02; // Uzun vadeli kredilere %2 fazla faiz
    } else if (application.termInDays > 180) {
      interestRate += 0.01; // Orta vadeli kredilere %1 fazla faiz
    }
    
    // Kredi risk puanı (kullanılmıyor şu an, gelecekte kullanılabilir)
    // calculateRiskScore(
    //   creditScore: creditScore,
    //   loanAmount: application.requestedAmount,
    //   player: player,
    // );

    return (true, null, interestRate);
  }

  /// Kredi risk puanı hesaplama
  static int calculateRiskScore({
    required CreditScore creditScore,
    required double loanAmount,
    required Player player,
  }) {
    int baseRisk = 100 - creditScore.score ~/ 10; // Kredi notu düşükse daha yüksek risk
    
    // Borç/gelir oranı
    double debtToIncome = player.debt / (player.cash + player.bankAccount + 1);
    int debtRisk = (debtToIncome * 50).round();
    
    // Kredi miktarı riski
    int amountRisk = (loanAmount / (player.level * 10000) * 30).round();
    
    int totalRisk = baseRisk + debtRisk + amountRisk;
    return totalRisk.clamp(0, 100);
  }

  /// Kredi oluşturma
  static Loan createLoan({
    required LoanApplication application,
    required double interestRate,
    required int riskScore,
  }) {
    // Toplam ödeme hesaplama (ana para + faiz)
    double totalAmount = application.requestedAmount * (1 + interestRate * (application.termInDays / 365));
    
    // Ödeme planı oluştur
    List<PaymentSchedule> paymentSchedules = _generatePaymentSchedules(
      application: application,
      totalAmount: totalAmount,
      interestRate: interestRate,
    );
    
    return Loan(
      id: 'loan_${DateTime.now().millisecondsSinceEpoch}',
      playerId: application.playerId,
      type: application.type,
      status: LoanStatus.approved,
      principal: application.requestedAmount,
      interestRate: interestRate,
      totalAmount: totalAmount,
      termInDays: application.termInDays,
      startDate: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: application.termInDays)),
      collateralValue: application.collateralValue,
      collateralDescription: application.collateralDescription,
      penaltyRate: interestRate * 1.5, // Cezai faiz oranı
      isSecured: application.collateralValue > 0,
      purpose: application.purpose,
      riskScore: riskScore,
      paymentSchedules: paymentSchedules,
    );
  }

  /// Ödeme planı oluştur
  static List<PaymentSchedule> _generatePaymentSchedules({
    required LoanApplication application,
    required double totalAmount,
    required double interestRate,
  }) {
    final schedules = <PaymentSchedule>[];
    final now = DateTime.now();
    
    // Vadeye göre ödeme sıklığı belirle
    int installmentCount;
    Duration interval;
    
    if (application.termInDays <= 30) {
      // Aylık ödeme
      installmentCount = 1;
      interval = Duration(days: application.termInDays);
    } else if (application.termInDays <= 90) {
      // 3 aylık vadelere 2 taksit
      installmentCount = 2;
      interval = Duration(days: application.termInDays ~/ 2);
    } else if (application.termInDays <= 365) {
      // 1 yıla kadar aylık taksit
      installmentCount = (application.termInDays / 30).ceil();
      interval = Duration(days: 30);
    } else {
      // 1 yıldan uzun vadeler için 3'er aylık taksit
      installmentCount = (application.termInDays / 90).ceil();
      interval = Duration(days: 90);
    }
    
    double installmentAmount = totalAmount / installmentCount;
    
    for (int i = 1; i <= installmentCount; i++) {
      schedules.add(
        PaymentSchedule(
          installmentNumber: i,
          dueDate: now.add(Duration(days: (interval.inDays * i))),
          amount: i == installmentCount 
              ? (totalAmount - (installmentAmount * (installmentCount - 1))) // Son taksitte kalanı tamamla
              : installmentAmount,
        ),
      );
    }
    
    return schedules;
  }

  /// Ödeme yap
  static (bool, String?) makePayment({
    required Loan loan,
    required double amount,
    required Player player,
  }) {
    if (amount <= 0) {
      return (false, 'Geçersiz ödeme miktarı!');
    }
    
    if (player.cash < amount) {
      return (false, 'Yetersiz bakiye!');
    }
    
    if (loan.status != LoanStatus.active && loan.status != LoanStatus.overdue) {
      return (false, 'Bu kredi için ödeme yapılamaz!');
    }
    
    // Gerçek ödeme işlemi burada yapılmalı
    // Bu örnek sadece hesaplamaları gösterir
    
    return (true, null);
  }

  /// Gecikmiş ödemeleri kontrol et
  static List<Loan> checkOverdueLoans({
    required List<Loan> loans,
  }) {
    final now = DateTime.now();
    return loans.where((loan) {
      if (loan.status != LoanStatus.active) return false;
      return now.isAfter(loan.dueDate);
    }).toList();
  }

  /// Kredi notu iyileştirme önerileri
  static List<String> getCreditScoreImprovementTips({
    required CreditScore creditScore,
    required Player player,
    required List<Loan> playerLoans,
  }) {
    final tips = <String>[];
    
    if (creditScore.score < 600) {
      tips.add('Kredi notunuzu artırmak için mevcut borçlarınızı düzenli ödeyin.');
    }
    
    if (player.debt > (player.cash + player.bankAccount) * 0.5) {
      tips.add('Borç/gelir oranınızı düşürmek için borçlarınızı azaltmaya çalışın.');
    }
    
    if (playerLoans.any((loan) => loan.status == LoanStatus.overdue)) {
      tips.add('Gecikmiş ödemeler kredi notunuzu olumsuz etkiler.');
    }
    
    if (creditScore.paidLoans == 0 && creditScore.totalLoans > 0) {
      tips.add('Daha fazla ödemiş kredi geçmişiniz notunuzu artırır.');
    }
    
    if (player.legalReputation < 70) {
      tips.add('Yasal itibar puanınızı artırmak kredi alımında avantaj sağlar.');
    }
    
    return tips;
  }
}