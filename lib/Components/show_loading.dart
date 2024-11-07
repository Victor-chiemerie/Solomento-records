import 'dart:ui';
import 'package:flutter/material.dart';

void showLoadingPage(BuildContext context) {
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
                  color: Color.fromRGBO(66, 178, 132, 1.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

