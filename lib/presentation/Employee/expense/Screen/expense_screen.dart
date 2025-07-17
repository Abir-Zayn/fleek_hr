part of 'expense_screen_imports.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String selectedFilter = 'All';
  late final ExpenseCubit expenseCubit;
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    expenseCubit = context.read<ExpenseCubit>();
    profileCubit = context.read<ProfileCubit>();

    // Initialize profile data
    if (profileCubit.state is! ProfileLoaded) {
      profileCubit.getUser();
    } else {
      // If profile is already loaded, load expenses immediately
      loadExpenses();
    }
  }

  void loadExpenses() {
    final employeeId = getEmployeeId();
    if (employeeId != null) {
      expenseCubit.getAllExpenses(employeeId);
    } else {
      debugPrint("Employee ID is null, cannot load expenses.");
      if (mounted) {
        toastification.show(
            context: context,
            title: Text('Employee ID not found.Login Again'),
            autoCloseDuration: const Duration(seconds: 2),
            alignment: Alignment.bottomCenter,
            borderRadius: BorderRadius.circular(8),
            style: ToastificationStyle.minimal,
            type: ToastificationType.error);
      }
    }
  }

  String? getEmployeeId() {
    final profileState = profileCubit.state;
    if (profileState is ProfileLoaded) {
      return profileState.user.id;
    } else {
      // Handle case where profile is not loaded
      return null;
    }
  }

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
        toastification.show(
          context: context,
          title: Text("Error showing filter options: $e"),
          autoCloseDuration: const Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
          borderRadius: BorderRadius.circular(8),
          style: ToastificationStyle.minimal,
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => expenseCubit,
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Expense History",
          actionButton: const Icon(Icons.filter_list, color: Colors.white),
          onActionButtonPressed: showcasingFilteringOptions,
        ),
        body: PageBackground(
          child: SafeArea(
            // ✅ Add SafeArea
            child: RefreshIndicator(
              onRefresh: () async {
                // show an animation while refreshing
                loadExpenses();
              },
              child: BlocConsumer<ExpenseCubit, ExpenseState>(
                listener: (context, state) {
                  if (state is ExpenseError) {
                    toastification.show(
                      context: context,
                      title: Text(state.message),
                      autoCloseDuration: const Duration(seconds: 2),
                      alignment: Alignment.bottomCenter,
                      borderRadius: BorderRadius.circular(8),
                      style: ToastificationStyle.minimal,
                      type: ToastificationType.error,
                    );
                  } else if (state is ExpenseDeleted) {
                    toastification.show(
                      context: context,
                      title: const Text('Expense deleted successfully'),
                      autoCloseDuration: const Duration(seconds: 2),
                      alignment: Alignment.bottomCenter,
                      borderRadius: BorderRadius.circular(8),
                      style: ToastificationStyle.minimal,
                      type: ToastificationType.success,
                    );
                    loadExpenses();
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        SizedBox(height: 16),
                        expenseList(
                          state,
                        ),
                      ],
                    ),
                  );
                },
              ),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "Expense History",
          style: TextStyle(
            fontSize: 20.clamp(16.0, 24.0).toDouble(),
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (selectedFilter != 'All')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    );
  }

  Widget expenseList(ExpenseState state) {
    if (state is ExpenseLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading expenses...'),
          ],
        ),
      );
    }

    if (state is ExpenseError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            AppTextstyle(
              text: 'Error loading expenses',
              style: appStyle(
                size: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            AppTextstyle(
              text: state.message,
              textAlign: TextAlign.center,
              style: appStyle(
                size: 14,
                color: Colors.red.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loadExpenses,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (state is ExpenseLoaded) {
      if (state.filteredExpenses.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                selectedFilter == 'All'
                    ? "No expenses found"
                    : "No expenses found for '$selectedFilter' filter",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              if (selectedFilter != 'All')
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'All';
                    });
                    expenseCubit.filterExpenses('All');
                  },
                  child: const Text('Show All Expenses'),
                ),
            ],
          ),
        );
      }

      //If there are expenses, display them in a list
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.filteredExpenses.length,
        padding: const EdgeInsets.symmetric(vertical: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final expense = state.filteredExpenses[index];
          return expenseCard(expense, state);
        },
      );
    }
    return const SizedBox.shrink(); // Fallback if no state matches
  }

  Widget expenseCard(ExpenseEntity expense, ExpenseLoaded state) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(builder: (context, state) {
      return UnifiedRequestCard.expense(
          onTap: () {
            context.push('/expense-details/${expense.id}');
          },
          id: expense.id.toString(),
          employeeName: expense.employeeName,
          status: expense.status.name,
          amount: expense.amount,
          expenseDate: expense.createdAt);
    });
  }
}
