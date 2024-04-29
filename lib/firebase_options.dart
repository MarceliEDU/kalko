// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCZBesMaSza-wFdafhePl35-Py6gUj-PLA',
    appId: '1:509299346684:web:0f9275f016c20af24cdb79',
    messagingSenderId: '509299346684',
    projectId: 'kalko-bcb0b',
    authDomain: 'kalko-bcb0b.firebaseapp.com',
    storageBucket: 'kalko-bcb0b.appspot.com',
    measurementId: 'G-F6YXHLZ811',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCORnXQkZi0a0AusiwY7WcBEX7OnpMd_wI',
    appId: '1:509299346684:android:23b47db309e9a0ad4cdb79',
    messagingSenderId: '509299346684',
    projectId: 'kalko-bcb0b',
    storageBucket: 'kalko-bcb0b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj-EdjvDe7poOpQ8jek58KPyMcbY8Z7Ug',
    appId: '1:509299346684:ios:2e500ada061bf15a4cdb79',
    messagingSenderId: '509299346684',
    projectId: 'kalko-bcb0b',
    storageBucket: 'kalko-bcb0b.appspot.com',
    iosBundleId: 'com.example.kalko',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj-EdjvDe7poOpQ8jek58KPyMcbY8Z7Ug',
    appId: '1:509299346684:ios:2e500ada061bf15a4cdb79',
    messagingSenderId: '509299346684',
    projectId: 'kalko-bcb0b',
    storageBucket: 'kalko-bcb0b.appspot.com',
    iosBundleId: 'com.example.kalko',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZBesMaSza-wFdafhePl35-Py6gUj-PLA',
    appId: '1:509299346684:web:ec12d3f2da49bad54cdb79',
    messagingSenderId: '509299346684',
    projectId: 'kalko-bcb0b',
    authDomain: 'kalko-bcb0b.firebaseapp.com',
    storageBucket: 'kalko-bcb0b.appspot.com',
    measurementId: 'G-8RGTDB4EX9',
  );

}