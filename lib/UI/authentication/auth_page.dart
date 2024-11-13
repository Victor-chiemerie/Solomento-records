import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:solomento_records/UI/Theme/text_theme.dart';
import 'package:solomento_records/UI/authentication/sign_in_page.dart';
import 'package:solomento_records/UI/authentication/sign_up_page.dart';

import '../../Components/screen_size.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: deviceHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.08),
                  child: Text(
                    'Welcome Back!',
                    style: TextThemes.headline1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                TabBar(
                  controller: tabController,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Sign In',
                        style: TextThemes.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Sign Up',
                        style: TextThemes.text,
                      ),
                    ),
                  ],
                ),
                // Wrap TabBarView with Expanded to give it bounded height
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BlocProvider<SignInBloc>(
                        create: (context) => SignInBloc(
                          myUserRepository:
                              context.read<AuthenticationBloc>().userRepository,
                        ),
                        child: const SignInPage(),
                      ),
                      BlocProvider<SignUpBloc>(
                        create: (context) => SignUpBloc(
                          myUserRepository:
                              context.read<AuthenticationBloc>().userRepository,
                        ),
                        child: const SignUpPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
