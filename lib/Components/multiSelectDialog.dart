import 'package:flutter/material.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/Theme/text_theme.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> jobTypes;
  final List<String> selectedJobTypes;

  const MultiSelectDialog({
    super.key,
    required this.jobTypes,
    required this.selectedJobTypes,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelectedJobTypes;

  @override
  void initState() {
    super.initState();
    _tempSelectedJobTypes = List.from(widget.selectedJobTypes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Job Types", style: TextThemes.headline1,),
      content: SingleChildScrollView(
        child: Column(
          children: widget.jobTypes.map((jobType) {
            return CheckboxListTile(
              title: Text(jobType, style: TextThemes.text),
              value: _tempSelectedJobTypes.contains(jobType),
              activeColor: AppColor.mainGreen,
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _tempSelectedJobTypes.add(jobType);
                  } else {
                    _tempSelectedJobTypes.remove(jobType);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel", style: TextThemes.text.copyWith(color: Colors.red),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("OK", style: TextThemes.text.copyWith(color: AppColor.mainGreen),),
          onPressed: () {
            Navigator.pop(context, _tempSelectedJobTypes);
          },
        ),
      ],
    );
  }
}
