import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';

class Functions {
  /// Pick a date
  static Future<void> selectDate(
      BuildContext context, ValueChanged<DateTime?> onDatePicked) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // Pass the picked date to the callback
    onDatePicked(picked);
  }

  /// Join list of String in an array
  static String joinArrayContents(List<dynamic> array) {
    return array.join(', ');
  }

  /// Helper function to safely parse text to double
  static double parseDouble(String text, {double defaultValue = 0.0}) {
    try {
      return double.parse(text);
    } catch (e) {
      return defaultValue; // Or handle the error in another way if needed
    }
  }

  /// Hide loading page
  static void hideLoadingPage(BuildContext context) {
    // If the dialog is still shown, pop it
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Show loading page
  static void showLoadingPage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button press
          child: Stack(
            children: [
              // Blurry background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    color: const Color.fromARGB(255, 70, 70, 70)
                        .withOpacity(0.3), // Semi-transparent dark overlay
                  ),
                ),
              ),
              // Loading indicator in the center
              const Center(
                child: CircularProgressIndicator(
                  color: AppColor.mainGreen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
