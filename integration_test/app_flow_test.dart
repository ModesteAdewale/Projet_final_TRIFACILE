import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trifacile/providers/app_provider.dart';
import 'package:trifacile/screens/home_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Parcours de consultation des collectes', (tester) async {
    final provider = AppProvider();
    await provider.initialize();
    await tester.pumpWidget(ChangeNotifierProvider.value(
      value: provider,
      child: const MaterialApp(home: HomeScreen()),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Voir les collectes'));
    await tester.pumpAndSettle();
    expect(find.text('Retrouvez les prochaines collectes selon votre quartier.'), findsOneWidget);
  });
}
