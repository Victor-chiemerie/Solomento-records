import 'package:flutter/material.dart';
import 'screen_size.dart';

class MyDropDownMenu extends StatelessWidget {
  const MyDropDownMenu({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint,
  });

  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        menuWidth: deviceWidth * 0.5,
        menuMaxHeight: deviceHeight * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        value: value,
        isExpanded: true,
        hint: hint != null ? Text(hint!) : null,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
