import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/authentication_bloc/authentication_bloc.dart';

import 'UI/home/home_page.dart';
import 'UI/authentication/welcome_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solomento workshop records',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Colors.white,
            onSurface: Colors.black,
            primary: Color.fromRGBO(206, 147, 216, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(244, 143, 177, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return const HomePage();
        } else {
          return const WelcomePage();
        }
      }),
    );
  }
}
