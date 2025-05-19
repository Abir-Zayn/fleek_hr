import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/Holiday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

//Calendar page render the calendar interface based on the table_calendar package.
// It allows user to select a date, view the currrent date, and see the
// office holidays based on the current month.

class Calendarpage extends StatefulWidget {
  final bool isRange;
  final Function(DateTime?, DateTime?)? onRangeDateSelected;
  final Function(DateTime)? onDateSelected;

  const Calendarpage(
      {super.key,
      this.isRange = false,
      this.onRangeDateSelected,
      this.onDateSelected});

  @override
  State<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  late final ValueNotifier<List<Holiday>> _selectedHolidays;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  //Add Variables for range selection
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

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

  // let say current date is 10-10-2025 and user select 10-10-2025
  // then it will turn its focus to the selected date
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedHolidays.value = getHolidaysForDay(selectedDay);
    }
  }

  // Handler for range selection
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null; // Clear single selection when range is selected
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // the selected range
    if (widget.onRangeDateSelected != null) {
      widget.onRangeDateSelected!(start, end);
    }

    // Update selected holidays based on focused day
    _selectedHolidays.value = getHolidaysForDay(focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
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

        //Date Range for the calendar
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 1, 1),
        calendarFormat: CalendarFormat.month,

        rangeStartDay: widget.isRange ? _rangeStart : null,
        rangeEndDay: widget.isRange ? _rangeEnd : null,
        rangeSelectionMode: widget.isRange
            ? _rangeSelectionMode
            : RangeSelectionMode.toggledOff,

        // Use appropriate selection handlers based on isRange
        onDaySelected: widget.isRange ? null : _onDaySelected,
        onRangeSelected: widget.isRange ? _onRangeSelected : null,

        selectedDayPredicate:
            widget.isRange ? null : (day) => isSameDay(day, _selectedDay),
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
          rangeStartBuilder: (context, day, focusedDay) {
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

          rangeEndBuilder: (context, day, focusedDay) {
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

          withinRangeBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
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
          rangeHighlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          rangeStartTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          rangeEndTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
