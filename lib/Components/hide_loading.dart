import 'package:flutter/material.dart';

void hideLoadingPage(BuildContext context) {
    // If the dialog is still shown, pop it
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }