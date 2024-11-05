import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
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

  runApp(MyApp(userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => MyUserBloc(myUserRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
            myUserRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
