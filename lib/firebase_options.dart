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
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
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
    apiKey: 'AIzaSyAVRVWvrznnuPEoOobUfgPPxI3mu_rN00c',
    appId: '1:811962041959:web:a4b04fa194163469f9b6c2',
    messagingSenderId: '811962041959',
    projectId: 'todo-1a11d',
    authDomain: 'todo-1a11d.firebaseapp.com',
    storageBucket: 'todo-1a11d.appspot.com',
    measurementId: 'G-SPXT6ND58W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9Al6Vq_T5W1mTNAHPYA8-zInilXCiUMQ',
    appId: '1:811962041959:android:e257a78bbdf6702bf9b6c2',
    messagingSenderId: '811962041959',
    projectId: 'todo-1a11d',
    storageBucket: 'todo-1a11d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAn_jrrJCKsOCRnq7W5B4agFFcixnJ3Rlk',
    appId: '1:811962041959:ios:51bfa8a0c431b9d3f9b6c2',
    messagingSenderId: '811962041959',
    projectId: 'todo-1a11d',
    storageBucket: 'todo-1a11d.appspot.com',
    iosClientId: '811962041959-e8est9ndbespov9u227qvj8hbiobq2p4.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseex',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAn_jrrJCKsOCRnq7W5B4agFFcixnJ3Rlk',
    appId: '1:811962041959:ios:51bfa8a0c431b9d3f9b6c2',
    messagingSenderId: '811962041959',
    projectId: 'todo-1a11d',
    storageBucket: 'todo-1a11d.appspot.com',
    iosClientId: '811962041959-e8est9ndbespov9u227qvj8hbiobq2p4.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseex',
  );
}