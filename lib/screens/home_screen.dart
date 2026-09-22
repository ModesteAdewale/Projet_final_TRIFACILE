import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/section_heading.dart';
import 'collections_screen.dart';
import 'points_screen.dart';
import 'tips_screen.dart';
import 'reports_screen.dart';

const _green = Color(0xFF247A32);
const _muted = Color(0xFF64736A);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _titles = const ['Accueil', 'Calendrier de collecte', 'Points de tri', 'Conseils', 'Signalements'];

  void _navigate(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _dashboard(context),
      const CollectionsScreen(),
      const PointsScreen(),
      const TipsScreen(),
      const ReportsScreen(),
    ];
    return Scaffold(
      drawer: AppDrawer(onNavigate: _navigate),
      appBar: AppBar(
        title: Text(_titles[_index], style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: 'Mes signalements',
            onPressed: () => _navigate(4),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SafeArea(child: IndexedStack(index: _index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index == 4 ? 0 : _index,
        onDestinationSelected: _navigate,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Collectes'),
          NavigationDestination(icon: Icon(Icons.location_on_outlined), selectedIcon: Icon(Icons.location_on), label: 'Points'),
          NavigationDestination(icon: Icon(Icons.lightbulb_outline), selectedIcon: Icon(Icons.lightbulb), label: 'Conseils'),
        ],
      ),
    );
  }

  Widget _dashboard(BuildContext context) {
    final app = context.watch<AppProvider>();
    final today = DateUtils.dateOnly(DateTime.now());
    final upcoming = app.collections.where((c) => !DateUtils.dateOnly(c.date).isBefore(today)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final next = upcoming.isEmpty ? null : upcoming.first;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF176B2B), Color(0xFF3C984B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.eco_rounded, color: Colors.white, size: 23),
              const SizedBox(width: 8),
              const Text('TRIFACILE • ÉCO-GESTES', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: .7)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(20)),
                child: const Text('Bienvenue', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ]),
            const SizedBox(height: 16),
            const Text('Bienvenue sur TriFacile !', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            const Text('Gérez la collecte des déchets, trouvez un point de tri et signalez les problèmes près de chez vous.', style: TextStyle(color: Colors.white, height: 1.4)),
            const SizedBox(height: 16),
            Row(children: [
              const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
              const SizedBox(width: 7),
              const Expanded(child: Text('Un quartier propre commence par chacun de nous.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))),
            ]),
          ]),
        ),
        const SizedBox(height: 20),
        const SectionHeading(title: 'Votre zone de collecte'),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(color: const Color(0xFFE4F3E6), borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.location_on_outlined, color: _green),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Secteur : Centre-ville', style: TextStyle(fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text('Choisissez votre quartier dans le calendrier.', style: TextStyle(color: _muted, fontSize: 12)),
              ])),
              TextButton(onPressed: () => _navigate(1), child: const Text('Modifier')),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeading(title: 'Prochaine collecte', action: 'Tout voir'),
        const SizedBox(height: 10),
        if (next == null)
          const _InfoCard(icon: Icons.event_busy_outlined, title: 'Aucune collecte à venir', subtitle: 'Consultez le calendrier pour les dates disponibles.')
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(children: [
                Container(
                  width: 55, height: 60,
                  decoration: BoxDecoration(color: const Color(0xFFE4F3E6), borderRadius: BorderRadius.circular(13)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('${next.date.day}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: _green)),
                    Text(_month(next.date.month), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: _green)),
                  ]),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(next.wasteType, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(next.neighborhood, style: const TextStyle(color: _muted, fontSize: 12)),
                  const SizedBox(height: 5),
                  const Text('Voir les consignes de collecte', style: TextStyle(color: _green, fontSize: 11, fontWeight: FontWeight.w600)),
                ])),
                const Icon(Icons.chevron_right, color: _green),
              ]),
            ),
          ),
        const SizedBox(height: 20),
        const SectionHeading(title: 'Actions rapides', subtitle: 'Accédez aux services essentiels'),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.38,
          children: [
            _ActionCard(icon: Icons.calendar_month_rounded, title: 'Calendrier', subtitle: 'Jours de ramassage', tint: const Color(0xFFE4F3E6), onTap: () => _navigate(1)),
            _ActionCard(icon: Icons.location_on_rounded, title: 'Points de tri', subtitle: 'Bornes & déchetteries', tint: const Color(0xFFE5EFFB), onTap: () => _navigate(2)),
            _ActionCard(icon: Icons.lightbulb_outline_rounded, title: 'Conseils', subtitle: 'Gestes éco-responsables', tint: const Color(0xFFFFF2D8), onTap: () => _navigate(3)),
            _ActionCard(icon: Icons.campaign_rounded, title: 'Signalements', subtitle: 'Déclarer un problème', tint: const Color(0xFFFCE8E2), onTap: () => _navigate(4)),
          ],
        ),
        const SizedBox(height: 20),
        const SectionHeading(title: 'Mon impact', subtitle: 'Chaque geste compte'),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              Container(
                width: 54, height: 54,
                decoration: BoxDecoration(color: const Color(0xFFE4F3E6), borderRadius: BorderRadius.circular(27)),
                child: const Icon(Icons.eco_outlined, color: _green, size: 29),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Adoptez un geste aujourd’hui', style: TextStyle(fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('Triez vos emballages et gardez-les propres et secs avant le dépôt.', style: TextStyle(color: _muted, fontSize: 12, height: 1.35)),
              ])),
            ]),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFEAF4EA),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              const Icon(Icons.tips_and_updates_outlined, color: _green, size: 25),
              const SizedBox(width: 10),
              const Expanded(child: Text('Le saviez-vous ? Séparer les matières facilite leur valorisation.', style: TextStyle(fontSize: 12, height: 1.35))),
              TextButton(onPressed: () => _navigate(3), child: const Text('Découvrir')),
            ]),
          ),
        ),
      ],
    );
  }

  String _month(int month) => const ['JAN','FÉV','MAR','AVR','MAI','JUIN','JUIL','AOÛT','SEPT','OCT','NOV','DÉC'][month - 1];
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.tint, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    child: InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE8EEE8))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: _green, size: 21)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 3),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: _muted)),
          ]),
        ]),
      ),
    ),
  );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
    Icon(icon, color: _green, size: 28),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12)),
    ])),
  ])));
}
