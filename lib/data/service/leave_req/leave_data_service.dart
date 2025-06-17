import 'package:fleekhr/data/models/leave_request/leave_type.dart';

class LeaveDataService {
  static List<LeaveTypeModel> mockLeaveTypes() {
    return [
      LeaveTypeModel(
        name: 'Annual Leave',
        availableDays: 20,
        usedDates: [
          DateTime(2023, 1, 10),
          DateTime(2023, 2, 15),
        ],
      ),
      LeaveTypeModel(
        name: 'Sick Leave',
        availableDays: 10,
        usedDates: [
          DateTime(2023, 3, 5),
        ],
      ),
      LeaveTypeModel(
        name: 'Casual Leave',
        availableDays: 5,
        usedDates: [],
      ),
      LeaveTypeModel(
        name: 'Leave Without Pay',
        availableDays: 15,
        usedDates: [
          DateTime(2023, 4, 20),
          DateTime(2023, 5, 25),
        ],
      ),
      LeaveTypeModel(
        name: 'Maternity Leave',
        availableDays: 90,
        usedDates: [],
      ),
      LeaveTypeModel(
        name: 'Paternity Leave',
        availableDays: 15,
        usedDates: [
          DateTime(2024, 6, 15),
          DateTime(2024, 6, 16),
          DateTime(2024, 6, 17),
        ],
      ),
      LeaveTypeModel(
        name: 'Bereavement Leave',
        availableDays: 5,
        usedDates: [],
      ),
    ];
  }
}
