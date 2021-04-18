import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final FirebaseAuth _firebaseAuth;
  UserRepo() : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredetial(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSingedIn() async {
    final currentuser = await _firebaseAuth.currentUser;
    return currentuser != null;
  }

  Future<User> getUser() async {
    return await _firebaseAuth.currentUser;
  }
}
