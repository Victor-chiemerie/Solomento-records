import 'package:flutter/material.dart';

class Functions {
  /// pick a date
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
}
