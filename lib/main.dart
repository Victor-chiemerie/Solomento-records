import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';
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
  runApp(MyApp(FirebaseUserRepository()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository),
        )
      ],
      child: const AppView(),
    );
  }
}
