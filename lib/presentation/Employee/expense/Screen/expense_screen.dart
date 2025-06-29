part of 'expense_screen_imports.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String selectedFilter = 'All';

  void showcasingFilteringOptions() {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => FilteringBottomSheet(
          title: "Filter Expense History",
          filteringOpt: const ["All", "Pending", "Approved", "Rejected"],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
            debugPrint('Selected filter: $selectedFilter');
          },
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error showing filter options: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error showing filter options: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Expense History",
        actionButton: const Icon(Icons.filter_list, color: Colors.white),
        onActionButtonPressed: showcasingFilteringOptions,
      ),
      body: SafeArea(
        // ✅ Add SafeArea
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Expense History",
                    style: TextStyle(
                      fontSize:
                          20.clamp(16.0, 24.0).toDouble(), // ✅ Safe font size
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (selectedFilter != 'All')
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AppTextstyle(
                        text: 'Filter: $selectedFilter',
                        style: appStyle(
                          size: 12,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              expenseList(),
            ],
          ),
        ),
      ),

      // ✅ Add floating action button for new expense
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-expense');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget expenseList() {
    final filterExpenseStatus = ExpenseDataService.expenseDemoData
        .where((expense) =>
            selectedFilter == 'All' ||
            expense.status.toLowerCase() == selectedFilter.toLowerCase())
        .toList();

    if (filterExpenseStatus.isEmpty) {
      return Center(
        child: Text(
          "No expenses found for the selected filter",
          style: TextStyle(
            fontSize: 16,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black54,
          ),
        ),
      );
    }

    //If there are expenses, display them in a list
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filterExpenseStatus.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final expense = filterExpenseStatus[index];
        return UnifiedRequestCard.expense(
            onTap: () {
              context.push('/expense-details/${expense.id}');
            },
            id: expense.id,
            employeeName: expense.employeeName,
            status: expense.status,
            amount: expense.amount,
            expenseDate: expense.date);
      },
    );
  }
}
