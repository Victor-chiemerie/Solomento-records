import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  logOut(BuildContext context) {
    context.read<SignInBloc>().add(const SignOutRequired());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton.outlined(
            onPressed: () {
              logOut(context);
            },
            icon: const Icon(CupertinoIcons.square_arrow_right),
          ),
        ],
      ),
    );
  }
}
