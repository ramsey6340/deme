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
    apiKey: 'AIzaSyBO2SLA4kkpKTWf6XHPGemwmLVUA7ZHSqw',
    appId: '1:529085308483:web:34b055de7b377c83633ef6',
    messagingSenderId: '529085308483',
    projectId: 'deme-2bed9',
    authDomain: 'deme-2bed9.firebaseapp.com',
    storageBucket: 'deme-2bed9.appspot.com',
    measurementId: 'G-SWN0Y0NVE3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWpU6PM67yChgpq_e45-Ga49dwTNZplVQ',
    appId: '1:529085308483:android:d4327068421004f3633ef6',
    messagingSenderId: '529085308483',
    projectId: 'deme-2bed9',
    storageBucket: 'deme-2bed9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0wYs9g9kG0V6QaiJZA5B1oiP_nw4UBRg',
    appId: '1:529085308483:ios:c036cf038a6e06d8633ef6',
    messagingSenderId: '529085308483',
    projectId: 'deme-2bed9',
    storageBucket: 'deme-2bed9.appspot.com',
    iosBundleId: 'com.example.deme',
  );
}
