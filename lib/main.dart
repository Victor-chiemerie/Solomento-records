import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/cubit/get_data_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'Logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'app_view.dart';
import 'firebase_options.dart';
import 'simple_bloc_observer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final userRepository = FirebaseUserRepository();
  final recordRepository = FirebaseRecordRepository();

  runApp(MyApp(userRepository, recordRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final RecordRepository recordRepository;
  MyApp(this.userRepository, this.recordRepository, {super.key});

  // create one instance of the bloc, and use it multiple times
  final AuthenticationBloc _authenticationBloc =
      AuthenticationBloc(myUserRepository: FirebaseUserRepository());
  final MyUserBloc _myUserBloc =
      MyUserBloc(myUserRepository: FirebaseUserRepository());
  final SignInBloc _signInBloc =
      SignInBloc(myUserRepository: FirebaseUserRepository());
  final GetDataCubit _getDataCubit =
      GetDataCubit(recordRepository: FirebaseRecordRepository());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _authenticationBloc,
        ),
        BlocProvider(
          create: (context) => _myUserBloc,
        ),
        BlocProvider(
          create: (context) => _signInBloc,
        ),
        BlocProvider.value(
          value: _getDataCubit..getData(),
        ),
      ],
      child: const AppView(),
    );
  }
}
