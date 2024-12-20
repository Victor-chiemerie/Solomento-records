import 'package:flutter/material.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/Theme/text_theme.dart';
import 'package:solomento_records/UI/authentication/auth_page.dart';
import '../../Components/custom_button.dart';
import '../../Components/screen_size.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return Scaffold(
      backgroundColor: AppColor.mainGreen,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/solomento.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Peace of mind...',
                    style: TextThemes.headline1.copyWith(color: Colors.white),
                  )
                ],
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
