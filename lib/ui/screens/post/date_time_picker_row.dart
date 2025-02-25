import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';

class DateTimePickerRow extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;

  const DateTimePickerRow(
      {Key? key, required this.dateController, required this.timeController})
      : super(key: key);

  @override
  State<DateTimePickerRow> createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      setState(() {
        widget.dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        widget.timeController.text =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: CustomTextField(
                label: 'Date', controller: widget.dateController),
          ),
        )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: GestureDetector(
          onTap: _selectTime,
          child: AbsorbPointer(
            child: CustomTextField(
                label: 'Time', controller: widget.timeController),
          ),
        ))
      ],
    );
  }
}
