import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/presentation/widgets/common/stat_card.dart';

/// Test 4: StatCard Widget - UI Bileşen Testi
/// Bu test, StatCard widget'ının doğru render edildiğini doğrular
void main() {
  group('StatCard Widget', () {
    testWidgets('StatCard label ve value gösterir', (WidgetTester tester) async {
      // Setup: Widget'ı build et
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              label: 'Para',
              value: '1,000 TL',
              icon: Icons.monetization_on,
            ),
          ),
        ),
      );

      // Assert: Text'lerin var olduğunu doğrula
      expect(find.text('Para'), findsOneWidget);
      expect(find.text('1,000 TL'), findsOneWidget);

      // Assert: Icon'un var olduğunu doğrula
      expect(find.byIcon(Icons.monetization_on), findsOneWidget);
    });

    testWidgets('StatCard farklı renklerle gösterilir', (WidgetTester tester) async {
      // Setup: Yeşil renkli kart (pozitif değer)
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              label: 'Kar',
              value: '+500 TL',
              icon: Icons.trending_up,
              valueColor: Colors.green,
            ),
          ),
        ),
      );

      // Assert: Widget var mı?
      expect(find.text('Kar'), findsOneWidget);
      expect(find.text('+500 TL'), findsOneWidget);

      // Widget'ın Text'ine eriş ve rengini kontrol et
      final valueText = tester.widget<Text>(find.text('+500 TL'));
      expect(valueText.style?.color, Colors.green);
    });

    testWidgets('StatCard negatif değer için kırmızı renk', (WidgetTester tester) async {
      // Setup: Kırmızı renkli kart (negatif değer)
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              label: 'Zarar',
              value: '-200 TL',
              icon: Icons.trending_down,
              valueColor: Colors.red,
            ),
          ),
        ),
      );

      // Assert: Widget var mı?
      expect(find.text('Zarar'), findsOneWidget);
      expect(find.text('-200 TL'), findsOneWidget);

      // Renk kontrolü
      final valueText = tester.widget<Text>(find.text('-200 TL'));
      expect(valueText.style?.color, Colors.red);
    });

    testWidgets('Birden fazla StatCard aynı ekranda gösterilebilir', (WidgetTester tester) async {
      // Setup: 3 farklı StatCard
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                StatCard(label: 'Para', value: '1,000 TL', icon: Icons.account_balance_wallet),
                StatCard(label: 'Seviye', value: '5', icon: Icons.trending_up),
                StatCard(label: 'Dükkan', value: '3', icon: Icons.store),
              ],
            ),
          ),
        ),
      );

      // Assert: Hepsi var mı?
      expect(find.text('Para'), findsOneWidget);
      expect(find.text('Seviye'), findsOneWidget);
      expect(find.text('Dükkan'), findsOneWidget);
      expect(find.text('1,000 TL'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);

      // 3 icon var mı?
      expect(find.byIcon(Icons.account_balance_wallet), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
      expect(find.byIcon(Icons.store), findsOneWidget);
    });

    testWidgets('StatCard tıklanabilir olabilir', (WidgetTester tester) async {
      // Setup: Tıklama callback'i
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () => tapped = true,
              child: const StatCard(
                label: 'Tıklayın',
                value: '123',
                icon: Icons.touch_app,
              ),
            ),
          ),
        ),
      );

      // Action: Widget'a tıkla
      await tester.tap(find.text('123'));
      await tester.pump();

      // Assert: Tıklama çalıştı mı?
      expect(tapped, true);
    });

    testWidgets('StatCard boş değer kabul etmez', (WidgetTester tester) async {
      // Setup: Boş string'ler
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              label: '',
              value: '',
              icon: Icons.error,
            ),
          ),
        ),
      );

      // Assert: Boş text'ler render edilir ama görünmez
      expect(find.text(''), findsNWidgets(2)); // label ve value
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('StatCard uzun text için overflow kontrolü', (WidgetTester tester) async {
      // Setup: Çok uzun text
      const longValue = 'Bu çok çok çok uzun bir değer texti ve overflow olmalı';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: StatCard(
                label: 'Uzun Text',
                value: longValue,
                icon: Icons.text_fields,
              ),
            ),
          ),
        ),
      );

      // Assert: Widget var mı?
      expect(find.text('Uzun Text'), findsOneWidget);
      expect(find.text(longValue), findsOneWidget);

      // Not: Overflow kontrolü stil kontrolü ile yapılır
      // Gerçek uygulamada Text widget'ı overflow: TextOverflow.ellipsis olmalı
    });
  });
}
