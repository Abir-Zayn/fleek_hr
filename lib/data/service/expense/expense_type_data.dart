import 'package:fleekhr/data/models/expense/expense_model.dart';

class ExpenseTypeData {
  static List<ExpenseTypeModel> mockExpenseTypes() {
    return [
      ExpenseTypeModel(name: 'Travel'),
      ExpenseTypeModel(name: 'Meals'),
      ExpenseTypeModel(name: 'Supplies'),
      ExpenseTypeModel(name: 'Equipment'),
      ExpenseTypeModel(name: 'Other'),
      ExpenseTypeModel(name: 'Entertainment'),
      ExpenseTypeModel(name: 'Accommodation'),
      ExpenseTypeModel(name: 'Utilities'),
      ExpenseTypeModel(name: 'Communication'),
      ExpenseTypeModel(name: 'Training')
    ];
  }
}
