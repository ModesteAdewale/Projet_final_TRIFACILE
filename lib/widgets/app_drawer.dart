import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onNavigate});
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) => Drawer(
    child: SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
        padding: EdgeInsets.all(22),
        child: Row(children: [
          CircleAvatar(radius: 25, backgroundColor: Color(0xFFE1F1E6), child: Icon(Icons.recycling, color: Color(0xFF247A52), size: 29)),
          SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('TriFacile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            Text('Les bons gestes au quotidien', style: TextStyle(fontSize: 12)),
          ]),
        ]),
      ),
      const Divider(),
      _item(context, Icons.home_outlined, 'Accueil', 0),
      _item(context, Icons.calendar_month_outlined, 'Collectes', 1),
      _item(context, Icons.location_on_outlined, 'Points de tri', 2),
      _item(context, Icons.lightbulb_outline, 'Conseils', 3),
      _item(context, Icons.report_outlined, 'Signalements', 4),
      const Spacer(),
      const Padding(padding: EdgeInsets.all(18), child: Text('TriFacile • Version pédagogique hors ligne', style: TextStyle(color: Colors.black54, fontSize: 12))),
    ])),
  );

  Widget _item(BuildContext context, IconData icon, String label, int index) => ListTile(
    leading: Icon(icon), title: Text(label), onTap: () { Navigator.pop(context); onNavigate(index); },
  );
}
