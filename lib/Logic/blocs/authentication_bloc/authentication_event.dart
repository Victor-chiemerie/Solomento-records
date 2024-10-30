part of 'authentication_bloc.dart';

// Events like, a user clicking on the login button

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}
