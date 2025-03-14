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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC-RTveBtKwiQIFsMPz0ZeMFWSNxRBYS4U',
    appId: '1:768549133048:web:0e4d5fa85b7107be00f90d',
    messagingSenderId: '768549133048',
    projectId: 'embed-sri-1111',
    authDomain: 'embed-sri-1111.firebaseapp.com',
    storageBucket: 'embed-sri-1111.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJdLAeattmnzO3Mid5hYXVPmUykwR6ZDU',
    appId: '1:768549133048:android:61089529d3ff2f7700f90d',
    messagingSenderId: '768549133048',
    projectId: 'embed-sri-1111',
    storageBucket: 'embed-sri-1111.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-RTveBtKwiQIFsMPz0ZeMFWSNxRBYS4U',
    appId: '1:768549133048:web:c5cc4527f9c6a2de00f90d',
    messagingSenderId: '768549133048',
    projectId: 'embed-sri-1111',
    authDomain: 'embed-sri-1111.firebaseapp.com',
    storageBucket: 'embed-sri-1111.appspot.com',
  );

}