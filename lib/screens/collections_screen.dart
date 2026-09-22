import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});
  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  String _filter = 'Tous';
  @override
  Widget build(BuildContext context) {
    final items = context.watch<AppProvider>().collections.where((c) => _filter == 'Tous' || c.neighborhood == _filter).toList()
      ..sort((a,b) => a.date.compareTo(b.date));
    final neighborhoods = ['Tous', ...context.read<AppProvider>().collections.map((e) => e.neighborhood).toSet()];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Retrouvez les prochaines collectes selon votre quartier.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _filter, decoration: const InputDecoration(labelText: 'Quartier'),
        items: neighborhoods.map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
        onChanged: (value) => setState(() => _filter = value ?? 'Tous'),
      ),
      const SizedBox(height: 18),
      if (items.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(30), child: Text('Aucune collecte pour ce quartier.'))),
      ...items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(child: ListTile(
          contentPadding: const EdgeInsets.all(14),
          leading: Container(width: 52, height: 58, decoration: BoxDecoration(color: const Color(0xFFE4F2E8), borderRadius: BorderRadius.circular(13)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('${item.date.day}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF247A52))),
            Text(_month(item.date.month), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ])),
          title: Text(item.wasteType, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text(item.neighborhood)),
          trailing: const Icon(Icons.chevron_right),
        )),
      )),
      const SizedBox(height: 10),
      const Text('Calendrier de démonstration : les dates sont des données statiques embarquées.', style: TextStyle(fontSize: 12, color: Colors.black45)),
    ]);
  }
  String _month(int month) => const ['JAN','FÉV','MAR','AVR','MAI','JUIN','JUIL','AOÛT','SEPT','OCT','NOV','DÉC'][month - 1];
}
