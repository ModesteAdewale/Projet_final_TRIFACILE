import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});
  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  String _category = 'Toutes';
  @override
  Widget build(BuildContext context) {
    final all = context.watch<AppProvider>().tips;
    final categories = ['Toutes', ...all.map((t) => t.category).toSet()];
    final tips = all.where((t) => _category == 'Toutes' || t.category == _category).toList();
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Des gestes simples pour mieux trier chaque jour.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _category, decoration: const InputDecoration(labelText: 'Catégorie'),
        items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
        onChanged: (v) => setState(() => _category = v ?? 'Toutes'),
      ),
      const SizedBox(height: 18),
      ...tips.map((tip) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(child: ExpansionTile(
          leading: const CircleAvatar(backgroundColor: Color(0xFFE4F2E8), child: Icon(Icons.lightbulb_outline, color: Color(0xFF247A52))),
          title: Text(tip.title, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text(tip.category),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
          children: [Text(tip.description, style: const TextStyle(height: 1.45))],
        )),
      )),
    ]);
  }
}
