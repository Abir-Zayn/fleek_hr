part of 'expense_screen_imports.dart';

class ExpenseScreen extends StatefulWidget {
  final ExpenseRepository repository;
  final ExpenseModel? expenseModel;

  const ExpenseScreen({super.key, required this.repository, this.expenseModel});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String _selectedFilter = "All";
  bool _isLoading = false;
  List<ExpenseModel> _expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await widget.repository.getExpenses();
      setState(() {
        result.fold(
          (failure) => _showMessage("Failed to load expenses: $failure"),
          (expenses) {
            _expenses = expenses
                .map((entity) => ExpenseModel(
                    id: entity.id,
                    purpose: entity.purpose,
                    amount: entity.amount,
                    date: entity.date,
                    status: entity.status,
                    from: entity.from,
                    to: entity.to))
                .toList();
          },
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showMessage("Failed to load expenses: $e");
    }
  }

  void _handleExpenseSubmitSuccess(ExpenseModel newExpense) {
    setState(() {
      // Check if we're editing an existing expense
      final existingIndex = _expenses.indexWhere((e) => e.id == newExpense.id);
      if (existingIndex >= 0) {
        _expenses[existingIndex] = newExpense;
      } else {
        _expenses.insert(0, newExpense);
      }
    });
  }

  void showcasingFilteringOptions() {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (context) => FilteringBottomSheet(
          title: "Filter Expenses",
          filteringOpt: ["All", "Pending", "Approved", "Rejected"],
          selectedFilter: _selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              _selectedFilter = filter;
            });
            // Optional: Refresh or filter data after selection
            _fetchExpenses();
          },
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
        ),
      );
    } catch (e) {
      _showMessage("Error showing filter options: $e");
    }
  }

  void _showAddExpenseDialog() {
    ExpenseForumDialog(
      context: context,
      expenseModel: ExpenseModel(
          id: '',
          purpose: '',
          amount: 0,
          date: DateTime.now(),
          status: StatusType.pending,
          from: '',
          to: ''), // Create empty expense model for a new expense
      expenseRepository: widget.repository,
      onSubmitSuccess: _handleExpenseSubmitSuccess,
    ).show();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Expense Requests",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: showcasingFilteringOptions,
          ),
        ],
      ),
      body: ExpenseListWidget(
        expenses: _expenses,
        selectedFilter: _selectedFilter,
        isLoading: _isLoading,
        onRefresh: _fetchExpenses,
        onExpenseTap: (expense) => ExpenseForumDialog(
          context: context,
          expenseModel: expense,
          onSubmitSuccess: _handleExpenseSubmitSuccess,
          expenseRepository: widget.repository,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
