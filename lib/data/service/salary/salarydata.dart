import 'package:fleekhr/data/models/salary/salary_model.dart';

class SalarydataSrc {
  static List<SalaryModel> mockSalaries() {
    return [
      SalaryModel(
          month: 'January',
          dateRange: '01/01/2025 - 31/01/2025',
          amount: '22,500 TK'),
      SalaryModel(
          month: 'February',
          dateRange: '01/02/2025 - 28/02/2025',
          amount: '22,500 TK'),
      SalaryModel(
          month: 'March',
          dateRange: '01/03/2025 - 31/03/2025',
          amount: '26,500 TK'),
      SalaryModel(
          month: 'April',
          dateRange: '01/04/2025 - 30/04/2025',
          amount: '22,500 TK'),
      SalaryModel(
          month: 'May',
          dateRange: '01/05/2025 - 31/05/2025',
          amount: '22,500 TK'),
      SalaryModel(
          month: 'June',
          dateRange: '01/06/2025 - 30/06/2025',
          amount: '22,500 TK'),
      SalaryModel(
          month: 'July',
          dateRange: '01/07/2025 - 31/07/2025',
          amount: '22,500 TK'),
    ];
  }
}
