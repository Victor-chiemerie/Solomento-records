part of 'authentication_bloc.dart';

// This is what tells the app what stage or state of authentication
// is currently enabled and sets the UI based on the state

// create 1 class that says or tells everything

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  /// No information about the [AuthenticationStatus] of the current user.
  const AuthenticationState.unknown() : this._();

  /// Current user is [authenticated].
  ///
  /// It takes a [MyUser] property representing the current [authenticated] user.
  const AuthenticationState.authenticated(User user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  /// Current user is [unauthenticated].
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
