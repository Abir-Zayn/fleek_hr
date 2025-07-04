import 'package:flutter/material.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';

class LeaveDateSelector extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String durationType;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;

  const LeaveDateSelector({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.durationType,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate
        ? (startDate ?? DateTime.now())
        : (endDate ?? (startDate ?? DateTime.now()));

    final firstDate =
        isStartDate ? DateTime.now() : (startDate ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      if (isStartDate) {
        onStartDateChanged(picked);
      } else {
        onEndDateChanged(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Start Date',
                style: appStyle(
                    color: Colors.black,
                    size: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context, true),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        startDate == null
                            ? 'Select Date'
                            : '${startDate!.day}/${startDate!.month}/${startDate!.year}',
                      ),
                      Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'End Date',
                style: appStyle(
                    color: Colors.black,
                    size: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: durationType == 'Half Day'
                    ? null
                    : () => _selectDate(context, false),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: durationType == 'Half Day' ? Colors.grey[200] : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextstyle(
                        text: durationType == 'Half Day' && startDate != null
                            ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                            : endDate == null
                                ? 'Select Date'
                                : '${endDate!.day}/${endDate!.month}/${endDate!.year}',
                        style: TextStyle(
                          color: durationType == 'Half Day'
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Icon(Icons.calendar_today, size: 18),
                    ],
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
