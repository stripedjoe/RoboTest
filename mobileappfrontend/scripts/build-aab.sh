echo 'Generate an app bundle release'

clear
flutter clean
flutter pub get
flutter build appbundle --release

echo 'Done generating an app bundle release'