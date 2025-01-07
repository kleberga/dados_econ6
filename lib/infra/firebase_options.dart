import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: dotenv.get('FIREBASE_WEB_API_KEY'),
        appId: dotenv.get('FIREBASE_WEB_APPID'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGINGSENDERID'),
        projectId: dotenv.get('FIREBASE_PROJECTID'),
        authDomain: dotenv.get('FIREBASE_AUTHDOMAIN'),
        storageBucket: dotenv.get('FIREBASE_STORAGEBUCKET'),
        measurementId: dotenv.get('FIREBASE_WEB_MEASUREMENTID'),
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: dotenv.get('FIREBASE_ANDROID_API_KEY'),
          appId: dotenv.get('FIREBASE_ANDROID_APPID'),
          messagingSenderId: dotenv.get('FIREBASE_MESSAGINGSENDERID'),
          projectId: dotenv.get('FIREBASE_PROJECTID'),
          storageBucket: dotenv.get('FIREBASE_STORAGEBUCKET'),
        );
      case TargetPlatform.iOS:
        return  FirebaseOptions(
          apiKey: dotenv.get('FIREBASE_IOS_MACOS_API_KEY'),
          appId: dotenv.get('FIREBASE_IOS_MACOS_APPID'),
          messagingSenderId: dotenv.get('FIREBASE_MESSAGINGSENDERID'),
          projectId: dotenv.get('FIREBASE_PROJECTID'),
          storageBucket: dotenv.get('FIREBASE_STORAGEBUCKET'),
          iosBundleId: dotenv.get('FIREBASE_IOS_MACOS_IOSBUNDLEID')
        );
      case TargetPlatform.macOS:
        return FirebaseOptions(
          apiKey: dotenv.get('FIREBASE_IOS_MACOS_API_KEY'),
          appId: dotenv.get('FIREBASE_IOS_MACOS_APPID'),
          messagingSenderId: dotenv.get('FIREBASE_MESSAGINGSENDERID'),
          projectId: dotenv.get('FIREBASE_PROJECTID'),
          storageBucket: dotenv.get('FIREBASE_STORAGEBUCKET'),
          iosBundleId: dotenv.get('FIREBASE_IOS_MACOS_IOSBUNDLEID')
        );
      case TargetPlatform.windows:
        return FirebaseOptions(
          apiKey: dotenv.get('FIREBASE_WINDOWS_API_KEY'),
          appId: dotenv.get('FIREBASE_WINDOWS_APPID'),
          messagingSenderId: dotenv.get('FIREBASE_MESSAGINGSENDERID'),
          projectId: dotenv.get('FIREBASE_PROJECTID'),
          authDomain: dotenv.get('FIREBASE_AUTHDOMAIN'),
          storageBucket: dotenv.get('FIREBASE_STORAGEBUCKET'),
          measurementId: dotenv.get('FIREBASE_WINDOWS_MEASUREMENTID'),
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

/*  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA5DgvcYzmNThqwbIurcmeOgsb1h3fqJcs',
    appId: '1:860456425765:web:b460661368ff3034ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    authDomain: 'dados-eco.firebaseapp.com',
    storageBucket: 'dados-eco.firebasestorage.app',
    measurementId: 'G-7EHRWZHL68',
  );*/

/*  var FIREBASE_ANDROID_API_KEY = dotenv.get('FIREBASE_ANDROID_API_KEY');

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrqU60ew999-c7mGns6_UMLBAFt26rPWo',
    appId: '1:860456425765:android:4da09d11f0fe999aba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.firebasestorage.app',
  );*/

/*  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByuWw26RkZIYotWkbsVMBpCV3kam63_rs',
    appId: '1:860456425765:ios:885aeab7b2476151ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.firebasestorage.app',
    iosBundleId: 'com.example.dadosEconomicos6',
  );*/

/*  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByuWw26RkZIYotWkbsVMBpCV3kam63_rs',
    appId: '1:860456425765:ios:885aeab7b2476151ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.firebasestorage.app',
    iosBundleId: 'com.example.dadosEconomicos6',
  );*/

/*  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWsCOWtJ9XbuCD89HNu6uIfyp0ClIZadE',
    appId: '1:860456425765:web:e0d8daf709bc45b9ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    authDomain: 'dados-eco.firebaseapp.com',
    storageBucket: 'dados-eco.firebasestorage.app',
    measurementId: 'G-BQFDRRVHV8',
  );*/

}