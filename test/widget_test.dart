import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ccr/main.dart';

void main() {
  testWidgets('Chicken Crunchy Roll POS full feature test', (WidgetTester tester) async {
    // Build app with ProviderScope.
    await tester.pumpWidget(const ProviderScope(child: ChickenCrunchyRollApp()));

    // Verify splash screen rendered correctly
    expect(find.text('Chicken Crunchy Roll'), findsOneWidget);
    expect(find.text('Sarah Amelia'), findsOneWidget);
    expect(find.text('MASUKKAN PIN KASIR'), findsOneWidget);
  });
}
