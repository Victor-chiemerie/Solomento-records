import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  // Sign Up
  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      // set the ID of the created user to the ID gotten from firebase
      myUser = myUser.copyWith(id: user.user!.uid);

      return myUser;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Sign In
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Sign Out
  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Reset Password
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
