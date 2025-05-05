import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/presentation/Request/widget/Holiday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarpage extends StatefulWidget {
  const Calendarpage({super.key});

  @override
  State<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  late final ValueNotifier<List<Holiday>> _selectedHolidays;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedHolidays = ValueNotifier(getHolidaysForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedHolidays.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedHolidays.value = getHolidaysForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: TableCalendar(
        focusedDay: _focusedDay,
        rowHeight: 44,
        daysOfWeekHeight: 30,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: appStyle(
            color: Colors.black,
            size: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 1, 1),
        calendarFormat: CalendarFormat.month,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        eventLoader: getHolidaysForDay,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            // Check if the day is a weekend
            // if its a weekend , show a circle of green with the date inside
            if (day.weekday == 5) {
              return Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: appStyle(
                      size: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return null;
          },
          //Styling the selected day
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          markersMaxCount: 3,
          markerDecoration: BoxDecoration(
            color: Colors.green.shade700,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
