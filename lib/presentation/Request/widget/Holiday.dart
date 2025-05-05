import 'package:flutter/material.dart' as material;

class Holiday {
  final String name;
  final material.Color color;

  const Holiday(this.name, {this.color = material.Colors.red});

  @override
  String toString() => name;
}

//Marking All holidays for BD Office except for the weekends
final Map<DateTime, List<Holiday>> bdOfficeHolidays = {
  DateTime.utc(2025, 2, 21): [
    const Holiday('International Mother Language Day')
  ],
  DateTime.utc(2025, 3, 26): [const Holiday('Independence Day')],
  DateTime.utc(2025, 3, 31): [
    const Holiday('Eid-ul-Fitr', color: material.Colors.green)
  ],
  DateTime.utc(2025, 4, 1): [
    const Holiday('Eid-ul-Fitr Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 4, 2): [
    const Holiday('Eid-ul-Fitr Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 5, 1): [
    const Holiday('May Day', color: material.Colors.blueGrey)
  ],
  DateTime.utc(2025, 5, 9): [
    const Holiday('Buddha Purnima', color: material.Colors.green)
  ],
  DateTime.utc(2025, 6, 15): [
    const Holiday('Eid-ul-Azha', color: material.Colors.green)
  ],
  DateTime.utc(2025, 6, 16): [
    const Holiday('Eid-ul-Azha Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 6, 17): [
    const Holiday('Eid-ul-Azha Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 6, 18): [
    const Holiday('Eid-ul-Azha Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 6, 19): [
    const Holiday('Eid-ul-Azha Holiday', color: material.Colors.green)
  ],
  DateTime.utc(2025, 7, 7): [
    const Holiday('Muharram/Ashura', color: material.Colors.green)
  ],
  DateTime.utc(2025, 8, 5): [
    Holiday('Dictator Free Day', color: material.Colors.orange.shade300)
  ],
  DateTime.utc(2025, 10, 5): [
    const Holiday('Durga Puja', color: material.Colors.green)
  ],
  DateTime.utc(2025, 10, 6): [
    const Holiday('Durga Puja', color: material.Colors.green)
  ],
  DateTime.utc(2025, 9, 16): [
    const Holiday('Ashura', color: material.Colors.green)
  ]
};

// Utility functions for date handling
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<Holiday> getHolidaysForDay(DateTime day) {
  //Normalize date to avoid tmezone issues
  final normalizedDate = DateTime.utc(day.year, day.month, day.day);
  List<Holiday> holidays = bdOfficeHolidays[normalizedDate] ?? [];

  //Add weekend holidays[Fridays only]
  if (day.weekday == 5 && holidays.isEmpty) {
    holidays = [Holiday('weekend', color: material.Colors.green.shade300)];
  }

  return holidays;
}
