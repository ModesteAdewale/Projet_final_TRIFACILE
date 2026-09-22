import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:trifacile/providers/app_provider.dart';
import 'package:trifacile/screens/report_form_screen.dart';

void main() {
  testWidgets('Le formulaire de signalement affiche ses champs', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => AppProvider(),
        child: const MaterialApp(home: ReportFormScreen())),
    );
    expect(find.text('Nouveau signalement'), findsOneWidget);
    expect(find.text('Enregistrer le signalement'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
  });
}
