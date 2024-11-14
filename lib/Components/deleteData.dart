import 'package:flutter/material.dart';
import 'package:record_repository/record_repository.dart';

import '../UI/Theme/color_theme.dart';
import '../UI/Theme/text_theme.dart';

void deleteData(BuildContext context, Car car, VoidCallback action) {
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
