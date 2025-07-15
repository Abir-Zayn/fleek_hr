part of 'add_expense_screen_imports.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  List<ExpenseTypeModel> expense_type = [];
  ExpenseTypeModel? expense;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController amountController = TextEditingController();

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
              SizedBox(height: 20),
              // Select Expense Type
              ExpenseTypeSeletor(
                expenseTypes: expense_type,
                onExpenseTypeSelected: updateSelectedExpense,
                selectedExpenseType: expense,
              ),

              //Textfields for expense {From, To, Amount}
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Expense",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium?.color ??
                            Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),

                    Apptextfield(
                      controller: fromController,
                      labelText: "From ( Optional )",
                      keyboardType: TextInputType.datetime,
                    ),
                    Apptextfield(
                      controller: toController,
                      labelText: "To ( Optional )",
                      keyboardType: TextInputType.datetime,
                    ),
                    Apptextfield(
                      controller: amountController,
                      labelText: "Amount",
                      keyboardType: TextInputType.number,
                    ),
                    // Submit Button
                    Appbtn(
                      bgColor: Theme.of(context).primaryColor,
                      text: "Submit",
                      textColor: Colors.white,
                      onPressed: () {
                        // Handle the submit action
                        if (amountController.text.isNotEmpty) {
                          // Here you would typically send the data to your backend
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Expense submitted successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid amount'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
