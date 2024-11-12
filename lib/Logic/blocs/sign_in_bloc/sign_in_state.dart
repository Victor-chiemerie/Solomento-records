part of 'sign_in_bloc.dart';

@immutable
class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInIntitial extends SignInState {}

/// [SignInState] is being processed.
class SignInProcess extends SignInState {}

/// User sign in is a [success].
class SignInSuccess extends SignInState {}

/// [failure] in trying to sign user in.
///
/// It takes a [message] property representing the error message from firebase [failure].
class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({this.message});
}
