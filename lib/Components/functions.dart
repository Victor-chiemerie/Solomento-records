import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';

import '../UI/Theme/text_theme.dart';

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

  /// Detete car and owner data from database
  static void deleteData(BuildContext context, Car car, VoidCallback action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete car data?', style: TextThemes.headline1),
        content: Text(
          'All information on this vehicle and the customer associated with the vehicle will be deleted permanently',
          style: TextThemes.text,
        ),
        actions: [
          TextButton(
            onPressed: () => action(),
            child: Text('Yes',
                style: TextThemes.text.copyWith(color: AppColor.mainGreen)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No',
                style: TextThemes.text.copyWith(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  /// format int value to currency setting
  static String formatAmount(int amount) {
    // convert String value to double value
    final doubleAmount = double.parse(amount.toString());
    // Format the amount with commas for thousands and two decimal places
    final formattedAmount = NumberFormat('#,##0', 'en_US').format(doubleAmount);
    // NumberFormat('#,##0.00', 'en_US').format(doubleAmount);

    return formattedAmount;
  }

  /// Default value for empty date
  static DateTime emptyDate = DateTime.utc(1999, 7, 20, 20, 18, 04);
}
