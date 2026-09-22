import 'package:flutter/foundation.dart';
import '../models/collection.dart';
import '../models/recycling_point.dart';
import '../models/report.dart';
import '../models/tip.dart';
import '../services/local_storage_service.dart';

class AppProvider extends ChangeNotifier {
  AppProvider({LocalStorageService? storage}) : _storage = storage ?? LocalStorageService();
  final LocalStorageService _storage;
  bool isReady = false;
  List<WasteReport> reports = [];
  Set<String> favorites = {};

  final List<Collection> collections = [
    Collection(wasteType: 'Déchets ménagers', neighborhood: 'Mènontin', date: DateTime(2026, 9, 22)),
    Collection(wasteType: 'Plastique', neighborhood: 'Cadjèhoun', date: DateTime(2026, 9, 24)),
    Collection(wasteType: 'Papier & carton', neighborhood: 'Fidjrossè', date: DateTime(2026, 9, 26)),
    Collection(wasteType: 'Déchets ménagers', neighborhood: 'Akpakpa', date: DateTime(2026, 9, 28)),
  ];

  final List<RecyclingPoint> points = const [
    RecyclingPoint(id: 'p1', name: 'Écopoint Mènontin', address: 'Mènontin, près du stade', acceptedWaste: ['Plastique', 'Métal'], description: 'Dépôt de matières recyclables triées.'),
    RecyclingPoint(id: 'p2', name: 'Point de collecte Cadjèhoun', address: 'Cadjèhoun, centre-ville', acceptedWaste: ['Papier', 'Carton', 'Plastique']),
    RecyclingPoint(id: 'p3', name: 'Écopoint Akpakpa', address: 'Akpakpa, zone résidentielle', acceptedWaste: ['Verre', 'Métal']),
  ];

  final List<RecyclingTip> tips = const [
    RecyclingTip(title: 'Séparer les matières', description: 'Séparez le plastique, le papier, le verre et les déchets ménagers avant le dépôt.', category: 'Tous déchets'),
    RecyclingTip(title: 'Vider les emballages', description: 'Videz et, si nécessaire, rincez rapidement les emballages avant de les déposer.', category: 'Plastique'),
    RecyclingTip(title: 'Garder le papier au sec', description: 'Un papier propre et sec est plus facile à recycler. Évitez de le mélanger aux déchets humides.', category: 'Papier & carton'),
    RecyclingTip(title: 'Réduire les déchets', description: 'Privilégiez les sacs réutilisables et réemployez les contenants lorsque c’est possible.', category: 'Prévention'),
  ];

  Future<void> initialize() async {
    reports = await _storage.loadReports();
    favorites = await _storage.loadFavorites();
    isReady = true;
    notifyListeners();
  }

  Future<void> addReport({required String title, required String description, required String location}) async {
    final report = WasteReport(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(), description: description.trim(),
      location: location.trim(), createdAt: DateTime.now(),
    );
    reports = [report, ...reports];
    await _storage.saveReports(reports);
    notifyListeners();
  }

  Future<void> deleteReport(String id) async {
    reports = reports.where((report) => report.id != id).toList();
    await _storage.saveReports(reports);
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (!favorites.add(id)) favorites.remove(id);
    await _storage.saveFavorites(favorites);
    notifyListeners();
  }

  bool isFavorite(String id) => favorites.contains(id);
}
