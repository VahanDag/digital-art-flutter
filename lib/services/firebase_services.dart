import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService.internal();

  factory FirebaseAuthService() {
    return _instance;
  }

  static final FirebaseAuthService _instance = FirebaseAuthService.internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  Future<bool> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }
}
