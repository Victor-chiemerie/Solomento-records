import 'package:flutter/material.dart';

late double deviceWidth;
late double deviceHeight;

void initializeDeviceSize(BuildContext context) {
  final size = MediaQuery.of(context).size;
  deviceWidth = size.width;
  deviceHeight = size.height;
}