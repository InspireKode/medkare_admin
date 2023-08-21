// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvsUFG-164UQhcOfhxKmjqGbQXbILnajI',
    appId: '1:45472486798:web:d56358b1663a33eac240df',
    messagingSenderId: '45472486798',
    projectId: 'medkare-b6510',
    authDomain: 'medkare-b6510.firebaseapp.com',
    storageBucket: 'medkare-b6510.appspot.com',
    measurementId: 'G-4FGKFSP6MS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4-5LxEDGRIi0T5XdZJ9jR3Gw_iyKyMHk',
    appId: '1:45472486798:android:c748854c5079e82bc240df',
    messagingSenderId: '45472486798',
    projectId: 'medkare-b6510',
    storageBucket: 'medkare-b6510.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGYjz9HbTnOkwnxVbCYQrymh7RIHIqw8M',
    appId: '1:45472486798:ios:e2a518c9aa0a7d5fc240df',
    messagingSenderId: '45472486798',
    projectId: 'medkare-b6510',
    storageBucket: 'medkare-b6510.appspot.com',
    iosClientId: '45472486798-m0sli4q9tbutkadn1da9t7ornslh976s.apps.googleusercontent.com',
    iosBundleId: 'com.example.medkareAdmin',
  );
}
