# Correspondance cahier des charges → réalisation

| Besoin | Écran / composant | Données / action |
|---|---|---|
| F1 Calendrier | `CollectionsScreen` | `Collection`, filtre quartier |
| F2 Points de tri + favoris | `PointsScreen` | `RecyclingPoint`, `AppProvider.toggleFavorite` |
| F3 Conseils | `TipsScreen` | `RecyclingTip`, filtre catégorie |
| F4 Signalements | `ReportsScreen`, `ReportFormScreen` | `WasteReport`, ajout/liste/suppression |
| Persistance | `LocalStorageService` | `shared_preferences`, JSON et liste d'identifiants |
| Gestion d'état | `AppProvider` | Provider / ChangeNotifier |
| Navigation | `HomeScreen`, `AppDrawer`, `NavigationBar` | IndexedStack et routes MaterialPageRoute |
