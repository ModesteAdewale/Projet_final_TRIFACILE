# TriFacile — Application mobile Flutter

TriFacile aide les habitants à mieux gérer leurs déchets au quotidien grâce à un calendrier de collecte, une liste de points de tri, des conseils pratiques et des signalements locaux.

## Fonctionnalités
- Calendrier de collecte par quartier et type de déchet.
- Points de tri, matières acceptées et favoris persistants.
- Conseils classés par catégorie.
- Création, consultation et suppression de signalements persistés localement.

## Technologies
- Flutter / Dart
- Provider pour la gestion d'état
- shared_preferences pour la persistance locale
- flutter_test et integration_test

## Prérequis
- Flutter SDK stable installé
- Android Studio ou VS Code avec extensions Flutter/Dart
- Un émulateur Android ou un appareil connecté

## Installation
```bash
flutter pub get
```

## Lancement
```bash
flutter run
```

## Tests
```bash
flutter test
```
Test d'intégration sur appareil/émulateur :
```bash
flutter test integration_test/app_flow_test.dart
```

## Générer un APK
```bash
flutter build apk --release
```
Le fichier sera généré dans `build/app/outputs/flutter-apk/app-release.apk`.

## Structure
```text
lib/
  main.dart
  models/
  providers/
  screens/
  services/
  widgets/
test/
integration_test/
```

## Données de démonstration
Les calendriers, points de tri et conseils sont des données statiques d'exemple embarquées dans l'application. Les dates et lieux doivent être vérifiés et adaptés avant une diffusion réelle. Les signalements et favoris sont conservés localement sur l'appareil et ne sont pas transmis à une municipalité.

## Tests prévus
- Test unitaire de sérialisation du modèle `WasteReport`.
- Test de widget du formulaire de signalement.
- Test d'intégration du parcours d'accès au calendrier.

## Limites connues de la V1
- Pas de compte utilisateur ni d'authentification.
- Pas de carte interactive ni de géolocalisation.
- Pas de notification.
- Aucun envoi des signalements vers un service municipal.

## Auteur
À compléter par l'apprenant.


## État de cette version adaptée au wireframe
Cette révision harmonise le thème Flutter (CardThemeData) et retravaille l'écran d'accueil avec une identité verte, une zone de collecte, la prochaine collecte, des actions rapides et un bloc d'impact.
Les autres écrans et fonctionnalités proviennent de la version source fournie et doivent être vérifiés sur votre environnement.

## Vérifications à effectuer avant remise
Exécuter `flutter pub get`, `flutter analyze`, puis `flutter test`.
Tester le parcours complet sur Android et/ou Windows. Générer et installer un APK Android avec `flutter build apk --release`.
Cette archive n'a pas été compilée ni testée dans un environnement Flutter pendant sa préparation ; ne présenter les tests ou le déploiement comme réussis qu'après exécution locale.
