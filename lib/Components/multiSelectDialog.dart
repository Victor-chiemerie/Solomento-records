import 'package:flutter/material.dart';

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
      title: const Text("Select Job Types"),
      content: SingleChildScrollView(
        child: Column(
          children: widget.jobTypes.map((jobType) {
            return CheckboxListTile(
              title: Text(jobType),
              value: _tempSelectedJobTypes.contains(jobType),
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
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context, _tempSelectedJobTypes);
          },
        ),
      ],
    );
  }
}
