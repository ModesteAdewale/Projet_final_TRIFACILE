import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});
  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  bool _favoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final points = app.points.where((p) => !_favoritesOnly || app.isFavorite(p.id)).toList();
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Les points de tri et les matières qu’ils acceptent.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 12),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Afficher uniquement mes favoris', style: TextStyle(fontWeight: FontWeight.w600)),
        value: _favoritesOnly, onChanged: (v) => setState(() => _favoritesOnly = v),
      ),
      const SizedBox(height: 8),
      if (points.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('Aucun favori pour le moment. Appuyez sur le cœur d’un point.'))),
      ...points.map((point) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFE4F2E8), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.recycling, color: Color(0xFF247A52))),
            const SizedBox(width: 12),
            Expanded(child: Text(point.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))),
            IconButton(
              tooltip: app.isFavorite(point.id) ? 'Retirer des favoris' : 'Ajouter aux favoris',
              onPressed: () => context.read<AppProvider>().toggleFavorite(point.id),
              icon: Icon(app.isFavorite(point.id) ? Icons.favorite : Icons.favorite_border, color: app.isFavorite(point.id) ? Colors.redAccent : Colors.black45),
            ),
          ]),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.location_on_outlined, size: 18, color: Colors.black54),
            const SizedBox(width: 5),
            Expanded(child: Text(point.address, style: const TextStyle(color: Colors.black54))),
          ]),
          if (point.description.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(point.description)),
          const SizedBox(height: 12),
          Wrap(spacing: 7, runSpacing: 7, children: point.acceptedWaste.map((w) => Chip(label: Text(w), visualDensity: VisualDensity.compact, backgroundColor: const Color(0xFFEAF4ED))).toList()),
        ]))),
      )),
    ]);
  }
}
