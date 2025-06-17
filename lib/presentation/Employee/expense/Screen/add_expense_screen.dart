part of 'add_expense_screen_imports.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  List<ExpenseTypeModel> expense_type = [];
  ExpenseTypeModel? expense;

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
    expense_type = ExpenseTypeData.mockExpenseTypes();
    if (expense_type.isNotEmpty) {
      expense = expense_type[0]; // Set the first expense type as default
    }
  }

  void updateSelectedExpense(ExpenseTypeModel type) {
    setState(() {
      expense = type;
    });
  }

  @override
  void dispose() {
    // Dispose of any controllers or resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Add Expense",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpenseTypeSeletor(
                expenseTypes: expense_type,
                onExpenseTypeSelected: updateSelectedExpense,
                selectedExpenseType: expense,
              )
            ],
          ),
        ));
  }
}
