import 'package:flutter/material.dart';

class SelectDateWidget extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  final DateTime? selectedDate;

  const SelectDateWidget({
    required this.onDateSelected,
    this.selectedDate,
    super.key,
  });

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  String title = 'select date of birth';
  late final DateTime initialDate;

  @override
  void initState() {
    if (widget.selectedDate != null) {
      title = widget.selectedDate.toString().split(' ').first;
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => OutlinedButton(
        key: const Key('dateOfBirth'),
        onPressed: () async {
          final DateTime? selectedDate = await showDatePicker(
            context: context,
            confirmText: 'Submit Date',
            initialDate: widget.selectedDate ?? DateTime.now(),
            firstDate: DateTime(1910),
            lastDate: DateTime.now(),
          );
          if (selectedDate != null) {
            setState(() {
              title = selectedDate.toString().split(' ').first;
            });
            widget.onDateSelected.call(selectedDate);
          }
        },
        child: Text(title),
      );
}
