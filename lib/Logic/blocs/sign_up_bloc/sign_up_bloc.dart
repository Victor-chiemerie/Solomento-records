import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({required UserRepository myUserRepository})
      : _userRepository = myUserRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      // display signup processing
      emit(SignUpProcess());

      try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        // display signup successful
        emit(SignUpSuccess());
        
      } catch (error) {
        // display signup failure
        emit(SignUpFailure());
      }
    });
  }
}
