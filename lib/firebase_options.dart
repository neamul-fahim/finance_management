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
    apiKey: 'AIzaSyA0d4KkSrw01cWmp-CwVfYf9KoF6RlnZJQ',
    appId: '1:102382791021:web:00c2b5e1c9a78fe9cf9264',
    messagingSenderId: '102382791021',
    projectId: 'finance-management-16888',
    authDomain: 'finance-management-16888.firebaseapp.com',
    storageBucket: 'finance-management-16888.appspot.com',
    measurementId: 'G-FK1HZTSBW9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLU4-AUOB-paS5yEZYdbOtJEGU4CaqniE',
    appId: '1:102382791021:android:26531f2cec937131cf9264',
    messagingSenderId: '102382791021',
    projectId: 'finance-management-16888',
    storageBucket: 'finance-management-16888.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBG6TlwoPhjg0QDVAKQUpwj8KN4kVjRLsg',
    appId: '1:102382791021:ios:e37b912d7081a1bdcf9264',
    messagingSenderId: '102382791021',
    projectId: 'finance-management-16888',
    storageBucket: 'finance-management-16888.appspot.com',
    iosBundleId: 'com.example.financeManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBG6TlwoPhjg0QDVAKQUpwj8KN4kVjRLsg',
    appId: '1:102382791021:ios:e37b912d7081a1bdcf9264',
    messagingSenderId: '102382791021',
    projectId: 'finance-management-16888',
    storageBucket: 'finance-management-16888.appspot.com',
    iosBundleId: 'com.example.financeManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA0d4KkSrw01cWmp-CwVfYf9KoF6RlnZJQ',
    appId: '1:102382791021:web:7b14c10b83d719dbcf9264',
    messagingSenderId: '102382791021',
    projectId: 'finance-management-16888',
    authDomain: 'finance-management-16888.firebaseapp.com',
    storageBucket: 'finance-management-16888.appspot.com',
    measurementId: 'G-694867RG81',
  );
}
