import 'package:fleekhr/data/models/leave_request/leave_type.dart';

class LeaveDataService {
  static List<LeaveType> mockLeaveTypes() {
    return [
      LeaveType(
        name: 'Annual Leave',
        availableDays: 20,
        usedDates: [
          DateTime(2023, 1, 10),
          DateTime(2023, 2, 15),
        ],

      ),
      LeaveType(
        name: 'Sick Leave',
        availableDays: 10,
        usedDates: [
          DateTime(2023, 3, 5),
        ],
   
      ),
      LeaveType(
        name: 'Casual Leave',
        availableDays: 5,
        usedDates: [],
       
      ),
      LeaveType(
        name: 'Leave Without Pay',
        availableDays: 15,
        usedDates: [
          DateTime(2023, 4, 20),
          DateTime(2023, 5, 25),
        ],
       
      ),
      LeaveType(
        name: 'Maternity Leave',
        availableDays: 90,
        usedDates: [],
  
      ),
      LeaveType(
        name: 'Paternity Leave',
        availableDays: 15,
        usedDates: [
          DateTime(2024, 6, 15),
          DateTime(2024, 6, 16),
          DateTime(2024, 6, 17),
        ],
      ),
      LeaveType(
        name: 'Bereavement Leave',
        availableDays: 5,
        usedDates: [],
      ),
    ];
  }
}
