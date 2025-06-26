import 'package:fleekhr/data/models/daily_activities/employee_model.dart';

class Employeedata {
  static List<EmployeeModel> get mockEmployees => [
        EmployeeModel(
            id: 'emp004',
            name: 'Emily Davis',
            email: 'emily.davis@technova.com',
            department: 'dept001',
            phone: '+880 128972123'),
        EmployeeModel(
          id: 'emp005',
          name: 'Michael Brown',
          email: 'testuser002@gmail.com',
          phone: '+8801780000005',
          department: 'dept002',
        ),
        EmployeeModel(
          id: 'emp006',
          name: 'Olivia Wilson',
          email: 'wilson@gmail.com',
          phone: '+8801780000006',
          department: 'dept003',
        ),
        EmployeeModel(
          id: 'emp007',
          name: 'Liam Martinez',
          email: 'liam@gmail.com',
          phone: '+8801780000007',
          department: 'dept004',
        ),
      ];
}
