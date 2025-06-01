import 'package:fleekhr/data/models/leave_request/leave_data_card.dart';

class LeaveDataCardSrc {
  static List<LeaveDataCard> get leaveDemoData => [
        LeaveDataCard(
          id: '4',
          employeeId: 'emp004',
          employeeName: 'Emily Davis',
          leaveType: 'Maternity Leave',
          startDate: DateTime.now().add(const Duration(days: 10)),
          endDate: DateTime.now().add(const Duration(days: 100)),
          isHalfDay: false,
          reason: 'Childbirth and recovery',
          status: 'Pending',
          halfDayType: 'None',
        ),
        LeaveDataCard(
          id: '5',
          employeeId: 'emp005',
          employeeName: 'Michael Brown',
          leaveType: 'Sick Leave',
          startDate: DateTime.now().subtract(const Duration(days: 2)),
          endDate: DateTime.now().subtract(const Duration(days: 1)),
          isHalfDay: false,
          reason: 'Fever and flu',
          status: 'Approved',
          halfDayType: 'None',
        ),
        LeaveDataCard(
          id: '6',
          employeeId: 'emp006',
          employeeName: 'Olivia Wilson',
          leaveType: 'Casual Leave',
          startDate: DateTime.now().add(const Duration(days: 2)),
          endDate: DateTime.now().add(const Duration(days: 2)),
          isHalfDay: true,
          halfDayType: 'Second Half',
          reason: 'Bank visit',
          status: 'Pending',
        ),
        LeaveDataCard(
          id: '7',
          employeeId: 'emp007',
          employeeName: 'Liam Martinez',
          leaveType: 'Annual Leave',
          startDate: DateTime.now().add(const Duration(days: 15)),
          endDate: DateTime.now().add(const Duration(days: 20)),
          isHalfDay: false,
          reason: 'Vacation abroad',
          status: 'Approved',
          halfDayType: 'None',
        ),
        LeaveDataCard(
          id: '8',
          employeeId: 'emp008',
          employeeName: 'Sophia Lee',
          leaveType: 'Sick Leave',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          isHalfDay: true,
          halfDayType: 'First Half',
          reason: 'Headache and rest',
          status: 'rejected',
        ),
      ];

  static LeaveDataCard findLeaveById(String id) {
    return leaveDemoData.firstWhere(
      (leave) => leave.id == id,
      orElse: () => leaveDemoData.first, // Fallback to first leave if not found
    );
  }
}
