import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/report.dart';

class LocalStorageService {
  static const _reportsKey = 'trifacile_reports';
  static const _favoritesKey = 'trifacile_favorites';

  Future<List<WasteReport>> loadReports() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_reportsKey) ?? [];
    return raw.map((item) => WasteReport.fromMap(
      jsonDecode(item) as Map<String, dynamic>,
    )).toList();
  }

  Future<void> saveReports(List<WasteReport> reports) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _reportsKey, reports.map((r) => jsonEncode(r.toMap())).toList(),
    );
  }

  Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_favoritesKey) ?? []).toSet();
  }

  Future<void> saveFavorites(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, ids.toList());
  }
}
