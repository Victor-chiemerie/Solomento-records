import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc({required UserRepository myUserRepository})
      : _userRepository = myUserRepository,
        super(SignInIntitial()) {
    on<SignInRequired>((event, emit) async {
      // emit sign in being processed
      emit(SignInProcess());

      try {
        await _userRepository.signIn(event.email, event.password);

        // emit sign in successful
        emit(SignInSuccess());
      } catch (error) {
        log(error.toString());

        // emit sign in failed
        emit(const SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      // emit sign in being processed
      emit(SignInProcess());
      
      try {
        await _userRepository.logOut();
      } catch (error) {
        log(error.toString());
      }
    });
  }
}
