import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'report_form_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportFormScreen())),
        icon: const Icon(Icons.add), label: const Text('Nouveau signalement'),
      ),
      body: app.reports.isEmpty
        ? Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: const [
            Icon(Icons.assignment_outlined, size: 56, color: Color(0xFF8AA394)),
            SizedBox(height: 12),
            Text('Aucun signalement', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            SizedBox(height: 6),
            Text('Signalez une poubelle pleine, un dépôt sauvage ou une collecte manquée.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
          ])))
        : ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 100), children: app.reports.map((report) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: const CircleAvatar(backgroundColor: Color(0xFFFBE7E2), child: Icon(Icons.campaign_outlined, color: Color(0xFFB65A45))),
              title: Text(report.title, style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Padding(padding: const EdgeInsets.only(top: 6), child: Text('${report.location}\n${_date(report.createdAt)}\n${report.description}', maxLines: 4, overflow: TextOverflow.ellipsis)),
              isThreeLine: true,
              trailing: IconButton(
                tooltip: 'Supprimer',
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () async {
                  final confirm = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                    title: const Text('Supprimer ce signalement ?'),
                    content: const Text('Cette action est définitive sur cet appareil.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annuler')), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Supprimer'))],
                  ));
                  if (confirm == true && context.mounted) {
                    await context.read<AppProvider>().deleteReport(report.id);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signalement supprimé.')));
                  }
                },
              ),
            )),
          )).toList()),
    );
  }
  String _date(DateTime d) => '${d.day.toString().padLeft(2,'0')}/${d.month.toString().padLeft(2,'0')}/${d.year}';
}
