import 'package:box_this/src/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  static final FirebaseAuthRepository _instance = FirebaseAuthRepository._internal();

  static FirebaseAuthRepository get instance => _instance;

  factory FirebaseAuthRepository() {
    return _instance;
  }

  FirebaseAuthRepository._internal();
  
  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> deleteAccount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.delete();
    } else {
      return Future.value();
    }
  }

  @override
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}