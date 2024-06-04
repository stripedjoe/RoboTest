echo 'Generate an apk release'

clear
flutter clean
flutter pub get
flutter build apk --release

echo 'Done generating an apk release'