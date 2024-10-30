import '../user_repository.dart';

abstract class UserRepository {
  /// Sign in method
  Future<void> signIn(String email, String password);

  /// Sign out method
  Future<void> logOut();

  /// Sign up method
  Future<MyUser> signUp(MyUser myUser, String password);

  /// Reset password method
  Future<void> resetPassword(String email);

  /// Update user data if aleady existing or creates and saves new user in document
  Future<void> setUserData(MyUser user);

  /// Get user data
  Future<MyUser> getMyUser(String myUserId);
}
