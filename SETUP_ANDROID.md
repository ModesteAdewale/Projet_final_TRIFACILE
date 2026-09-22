# Générer les fichiers de plateforme Android

Le ZIP contient le code source Flutter et ses tests. Pour générer les dossiers de plateforme Android avec votre version installée de Flutter :

```bash
flutter create --platforms=android .
flutter pub get
flutter run
```

Puis pour compiler :
```bash
flutter build apk --release
```

Le SDK Flutter/Android n'est pas embarqué dans ce livrable. La compilation APK doit être effectuée sur une machine configurée avec Flutter et Android SDK.
