import 'package:flutter_test/flutter_test.dart';
import 'package:trifacile/models/report.dart';

void main() {
  test('WasteReport se convertit en map puis se reconstruit', () {
    final report = WasteReport(
      id: '42', title: 'Poubelle pleine', description: 'Conteneur débordant',
      location: 'Mènontin', createdAt: DateTime(2026, 9, 20),
    );
    final restored = WasteReport.fromMap(report.toMap());
    expect(restored.id, '42');
    expect(restored.title, 'Poubelle pleine');
    expect(restored.location, 'Mènontin');
    expect(restored.createdAt, DateTime(2026, 9, 20));
  });
}
