part of 'add_expense_screen_imports.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  // Selected expense type
  ExpenseType selectedExpenseType = ExpenseType.Travel;

  // Controllers
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late final ExpenseCubit expenseCubit;
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    expenseCubit = context.read<ExpenseCubit>();
    profileCubit = context.read<ProfileCubit>();

    // Load profile if not already loaded
    if (profileCubit.state is! ProfileLoaded) {
      profileCubit.getUser();
    }
  }

  void updateSelectedExpenseType(ExpenseType type) {
    setState(() {
      selectedExpenseType = type;
    });
  }

  Future<void> _submitExpense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User profile not loaded. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      if (mounted) {
        toastification.show(
            context: context,
            title: Text('Invalid Amount'),
            type: ToastificationType.warning,
            style: ToastificationStyle.minimal);
      }
      return;
    }

    // Create expense entity using the simplified method
    // This will automatically get current user data and set employee name and timestamp
    await expenseCubit.createExpenseFromUI(
      expenseType: selectedExpenseType,
      from: fromController.text.trim().isEmpty
          ? null
          : fromController.text.trim(),
      to: toController.text.trim().isEmpty ? null : toController.text.trim(),
      amount: amount,
      status: ExpenseStatus.Pending, // Default status
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    fromController.clear();
    toController.clear();
    amountController.clear();
    descriptionController.clear();
    setState(() {
      selectedExpenseType = ExpenseType.Travel;
    });
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Add Expense",
      ),
      body: BlocListener<ExpenseCubit, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _resetForm();
            Navigator.of(context).pop(); // Go back to previous screen
          } else if (state is ExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Select Expense Type
                _buildExpenseTypeSelector(),

                // Form fields
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expense Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).textTheme.bodyMedium?.color ??
                                  Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // From field (optional)
                      Apptextfield(
                        controller: fromController,
                        labelText: "From (Optional)",
                        keyboardType: TextInputType.text,
                      ),

                      // To field (optional)
                      Apptextfield(
                        controller: toController,
                        labelText: "To (Optional)",
                        keyboardType: TextInputType.text,
                      ),

                      // Amount field (required)
                      Apptextfield(
                        controller: amountController,
                        labelText: "Amount *",
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Amount is required';
                          }
                          final amount = double.tryParse(value.trim());
                          if (amount == null || amount <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),

                      // Description field (optional)
                      Apptextfield(
                        controller: descriptionController,
                        labelText: "Description (Optional)",
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      BlocBuilder<ExpenseCubit, ExpenseState>(
                        builder: (context, state) {
                          final isLoading = state is ExpenseCreating;

                          return Appbtn(
                            bgColor: Theme.of(context).primaryColor,
                            text: isLoading ? "Submitting..." : "Submit",
                            textColor: Colors.white,
                            onPressed: isLoading ? null : _submitExpense,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Types',
            style: TextStyle(
              fontSize: 15,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          // Expense type selection
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ExpenseType.values.map((expenseType) {
              final isSelected = selectedExpenseType == expenseType;
              return GestureDetector(
                onTap: () => updateSelectedExpenseType(expenseType),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    expenseType.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
