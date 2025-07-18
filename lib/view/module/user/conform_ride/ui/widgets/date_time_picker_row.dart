import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/text_styles.dart';

class DateTimePickerRow extends StatefulWidget {
  const DateTimePickerRow({super.key});

  @override
  State<DateTimePickerRow> createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
      print("Selected Date: ${DateFormat('yyyy-MM-dd').format(pickedDate)}");
    }
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? now,
    );

    if (pickedTime != null) {
      setState(() => selectedTime = pickedTime);
      print("Selected Time: ${pickedTime.format(context)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : 'Date';
    final timeText = selectedTime != null
        ? selectedTime!.format(context)
        : 'Time';

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.boxColors,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Schedule Ride", style: AppTextStyle.small16SizeText),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Date Picker
              Expanded(
                child: InkWell(
                  onTap: _pickDate,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 8),
                        Text(dateText, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
              // Divider
              Container(
                height: 30,
                width: 1,
                color: Colors.grey.shade300,
              ),
              // Time Picker
              Expanded(
                child: InkWell(
                  onTap: _pickTime,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 18),
                        const SizedBox(width: 8),
                        Text(timeText, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
