import 'dart:math';
import '../../data/models/player.dart';

/// Rastgele olay sistemi - Random event generator
class EventSystem {
  static final _random = Random();

  /// Rastgele olay tetikleme
  /// Returns: Event nesnesi veya null (olay olmazsa)
  static GameEvent? triggerRandomEvent({
    required Player player,
    required int currentDay,
  }) {
    // Olay olma şansı %30
    if (_random.nextDouble() > 0.3) return null;

    // Oyuncu durumuna göre olay seçimi
    final possibleEvents = _getPossibleEvents(player);
    if (possibleEvents.isEmpty) return null;

    final eventType = possibleEvents[_random.nextInt(possibleEvents.length)];
    return _createEvent(eventType, player);
  }

  /// Mevcut duruma göre olası olaylar
  static List<EventType> _getPossibleEvents(Player player) {
    final events = <EventType>[];

    // Her zaman olabilecek olaylar
    events.addAll([
      EventType.marketCrash,
      EventType.marketBoom,
      EventType.luckyFind,
      EventType.robbery,
    ]);

    // Duruma özel olaylar
    if (player.cash > 50000) {
      events.add(EventType.taxInspection);
    }

    if (player.legalReputation < 40) {
      events.add(EventType.policeRaid);
    }

    if (player.streetReputation > 60) {
      events.add(EventType.gangOffer);
    }

    if (player.debt > 20000) {
      events.add(EventType.debtCollector);
    }

    if (player.level >= 10) {
      events.add(EventType.businessOpportunity);
    }

    return events;
  }

  /// Olay oluştur
  static GameEvent _createEvent(EventType type, Player player) {
    switch (type) {
      case EventType.marketCrash:
        return GameEvent(
          id: 'market_crash_${_random.nextInt(1000)}',
          type: type,
          title: '📉 Piyasa Çöküşü',
          description: 'Ani bir kriz nedeniyle tüm ürünlerin fiyatları %20 düştü!',
          effects: [
            EventEffect(
              type: EffectType.priceChange,
              value: -0.20,
              target: 'all_products',
            ),
          ],
          duration: 2, // 2 gün
        );

      case EventType.marketBoom:
        final productCategory = ['electronics', 'jewelry', 'vehicles'][_random.nextInt(3)];
        return GameEvent(
          id: 'market_boom_${_random.nextInt(1000)}',
          type: type,
          title: '📈 Piyasa Canlanması',
          description: '$productCategory kategorisinde talep patlaması! Fiyatlar %30 arttı.',
          effects: [
            EventEffect(
              type: EffectType.priceChange,
              value: 0.30,
              target: productCategory,
            ),
          ],
          duration: 3,
        );

      case EventType.luckyFind:
        final amount = 5000 + _random.nextInt(15000);
        return GameEvent(
          id: 'lucky_find_${_random.nextInt(1000)}',
          type: type,
          title: '🍀 Şanslı Gün',
          description: 'Sokakta ₺${amount.toStringAsFixed(0)} buldunuz!',
          effects: [
            EventEffect(
              type: EffectType.cashGain,
              value: amount.toDouble(),
            ),
          ],
        );

      case EventType.robbery:
        final stolenAmount = (player.cash * 0.1).clamp(1000.0, 20000.0);
        return GameEvent(
          id: 'robbery_${_random.nextInt(1000)}',
          type: type,
          title: '🚨 Soygun',
          description: 'Hırsızlar sizi soydu! ₺${stolenAmount.toStringAsFixed(0)} kaybettiniz.',
          effects: [
            EventEffect(
              type: EffectType.cashLoss,
              value: stolenAmount,
            ),
            EventEffect(
              type: EffectType.reputationChange,
              value: -5,
              target: 'street',
            ),
          ],
        );

      case EventType.taxInspection:
        final tax = player.cash * 0.15;
        return GameEvent(
          id: 'tax_inspection_${_random.nextInt(1000)}',
          type: type,
          title: '🏛️ Vergi Denetimi',
          description: 'Vergi müfettişleri geldi! %15 vergi ödemek zorundasınız.',
          effects: [
            EventEffect(
              type: EffectType.cashLoss,
              value: tax,
            ),
            EventEffect(
              type: EffectType.reputationChange,
              value: 10,
              target: 'legal',
            ),
          ],
          choices: [
            EventChoice(
              id: 'pay',
              text: 'Vergini öde',
              effects: [], // Yukarıdaki effectler zaten uygulanacak
            ),
            EventChoice(
              id: 'bribe',
              text: 'Rüşvet ver (₺${(tax * 0.5).toStringAsFixed(0)})',
              effects: [
                EventEffect(
                  type: EffectType.cashLoss,
                  value: tax * 0.5,
                ),
                EventEffect(
                  type: EffectType.riskIncrease,
                  value: 20,
                ),
              ],
            ),
          ],
        );

      case EventType.policeRaid:
        return GameEvent(
          id: 'police_raid_${_random.nextInt(1000)}',
          type: type,
          title: '👮 Polis Baskını',
          description: 'Polis işyerinizi bastı! Yasadışı ürünler ele geçirildi.',
          effects: [
            EventEffect(
              type: EffectType.inventoryLoss,
              value: 0.3, // %30 stok kaybı
              target: 'illegal',
            ),
            EventEffect(
              type: EffectType.reputationChange,
              value: -20,
              target: 'legal',
            ),
            EventEffect(
              type: EffectType.cashLoss,
              value: 10000,
            ),
          ],
        );

      case EventType.gangOffer:
        return GameEvent(
          id: 'gang_offer_${_random.nextInt(1000)}',
          type: type,
          title: '🌃 Çete Teklifi',
          description: 'Yerel çete size özel bir iş teklif etti. Riskli ama karlı!',
          effects: [],
          choices: [
            EventChoice(
              id: 'accept',
              text: 'Kabul et (₺50,000 kar, yüksek risk)',
              effects: [
                EventEffect(
                  type: EffectType.cashGain,
                  value: 50000,
                ),
                EventEffect(
                  type: EffectType.riskIncrease,
                  value: 40,
                ),
                EventEffect(
                  type: EffectType.reputationChange,
                  value: 15,
                  target: 'street',
                ),
              ],
            ),
            EventChoice(
              id: 'decline',
              text: 'Reddet (Güvenli)',
              effects: [
                EventEffect(
                  type: EffectType.reputationChange,
                  value: -5,
                  target: 'street',
                ),
              ],
            ),
          ],
        );

      case EventType.debtCollector:
        return GameEvent(
          id: 'debt_collector_${_random.nextInt(1000)}',
          type: type,
          title: '💀 Borç Tahsildarı',
          description: 'Borcunuz için tehditler alıyorsunuz. Hemen ödeyin!',
          effects: [
            EventEffect(
              type: EffectType.riskIncrease,
              value: 30,
            ),
          ],
        );

      case EventType.businessOpportunity:
        return GameEvent(
          id: 'business_opportunity_${_random.nextInt(1000)}',
          type: type,
          title: '💼 İş Fırsatı',
          description: 'Bir yatırımcı sizinle ortaklık kurmak istiyor.',
          effects: [],
          choices: [
            EventChoice(
              id: 'invest',
              text: 'Yatırım yap (₺30,000)',
              effects: [
                EventEffect(
                  type: EffectType.cashLoss,
                  value: 30000,
                ),
                EventEffect(
                  type: EffectType.futureIncome,
                  value: 60000,
                  duration: 5, // 5 gün sonra gelir
                ),
              ],
            ),
            EventChoice(
              id: 'decline',
              text: 'Reddet',
              effects: [],
            ),
          ],
        );
    }
  }

  /// Özel olaylar (gün bazlı)
  static GameEvent? getDailySpecialEvent(int dayNumber) {
    // Her 7 günde özel olay
    if (dayNumber % 7 == 0) {
      return GameEvent(
        id: 'weekly_bonus_$dayNumber',
        type: EventType.luckyFind,
        title: '🎁 Haftalık Bonus',
        description: 'Bir hafta tamamladınız! İşte bonus ödülünüz.',
        effects: [
          EventEffect(
            type: EffectType.cashGain,
            value: 10000,
          ),
          EventEffect(
            type: EffectType.expGain,
            value: 500,
          ),
        ],
      );
    }

    // Her 30 günde büyük olay
    if (dayNumber % 30 == 0) {
      return GameEvent(
        id: 'monthly_event_$dayNumber',
        type: EventType.businessOpportunity,
        title: '🎊 Aylık Kutlama',
        description: 'Bir ay tamamladınız! Özel ödüller kazandınız.',
        effects: [
          EventEffect(
            type: EffectType.cashGain,
            value: 50000,
          ),
          EventEffect(
            type: EffectType.expGain,
            value: 2000,
          ),
          EventEffect(
            type: EffectType.reputationChange,
            value: 10,
            target: 'both',
          ),
        ],
      );
    }

    return null;
  }
}

/// Olay tipleri
enum EventType {
  marketCrash,
  marketBoom,
  luckyFind,
  robbery,
  taxInspection,
  policeRaid,
  gangOffer,
  debtCollector,
  businessOpportunity,
}

/// Etki tipleri
enum EffectType {
  cashGain,
  cashLoss,
  priceChange,
  reputationChange,
  riskIncrease,
  riskDecrease,
  inventoryLoss,
  inventoryGain,
  expGain,
  futureIncome,
}

/// Oyun olayı
class GameEvent {
  final String id;
  final EventType type;
  final String title;
  final String description;
  final List<EventEffect> effects;
  final List<EventChoice>? choices;
  final int duration; // Kaç gün sürecek (0 = anında)

  GameEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.effects,
    this.choices,
    this.duration = 0,
  });
}

/// Olay etkisi
class EventEffect {
  final EffectType type;
  final double value;
  final String? target; // Hangi kategoriye/özge uygulanacak
  final int? duration; // Effect'in kaç gün süreceği

  EventEffect({
    required this.type,
    required this.value,
    this.target,
    this.duration,
  });
}

/// Olay seçeneği
class EventChoice {
  final String id;
  final String text;
  final List<EventEffect> effects;

  EventChoice({
    required this.id,
    required this.text,
    required this.effects,
  });
}
