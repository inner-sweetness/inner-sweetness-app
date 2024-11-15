import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions(
        apiKey: '',
        messagingSenderId: '',
        appId: '',
        projectId: '',
      );
}
