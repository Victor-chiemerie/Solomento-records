import 'package:flutter/material.dart';
import 'package:solomento_records/UI/authentication/auth_page.dart';
import '../../Components/custom_button.dart';
import '../../Components/screen_size.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 178, 132, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide()),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/solomento.jpg"),
                  ),
                ),
              ),
            ),
            CustomButton(
              width: double.infinity,
              height: 45,
              color: Colors.white,
              text: 'Welcome',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
