part of 'expense_details_imports.dart';

/// Screen for displaying detailed information about a specific expense
/// Includes expense status, information, description, and available actions
class ExpenseDetailsScreen extends StatefulWidget {
  final String id;
  const ExpenseDetailsScreen({super.key, required this.id});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late final ExpenseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = sl<ExpenseCubit>();
    _loadExpenseDetails();
  }

  /// Loads expense details with simulated loading delay for better UX
  Future<void> _loadExpenseDetails() async {
    try {
      // Simulate loading time for viewing single expense detail (500ms)
      await Future.delayed(const Duration(milliseconds: 500));
      cubit.getExpenseById(widget.id);
    } catch (e) {
      debugPrint('Error loading expense details: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load expense details. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Formats amount value to currency string with dollar sign and 2 decimal places
  String _formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  /// Handles back navigation with proper state restoration and simulated delay
  Future<void> _handleBackNavigation() async {
    try {
      // Simulate navigation delay (500ms)
      await Future.delayed(const Duration(milliseconds: 500));

      final currentState = cubit.state;
      if (currentState is ExpenseDetailSuccess ||
          currentState is ExpenseDetailLoaded) {
        cubit.restoreListState();
      }
    } catch (e) {
      debugPrint('Error during navigation: $e');
    }
  }

  /// Builds the main UI structure with app bar and body content
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _handleBackNavigation();
        return true;
      },
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: 'Expense Details',
          onBackButtonPressed: () async {
            await _handleBackNavigation();
            if (mounted) {
              context.pop();
            }
          },
        ),
        body: BlocBuilder<ExpenseCubit, ExpenseState>(
          bloc: cubit,
          builder: (context, state) {
            return _buildStateContent(state);
          },
        ),
      ),
    );
  }

  /// Builds content based on the current expense state
  Widget _buildStateContent(ExpenseState state) {
    if (state is ExpenseLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ExpenseError) {
      return _buildErrorContent(state.message);
    }

    if (state is ExpenseDetailLoaded || state is ExpenseDetailSuccess) {
      final ExpenseEntity expense = state is ExpenseDetailLoaded
          ? state.expense
          : (state as ExpenseDetailSuccess).expense;
      return _buildDetailsContent(expense);
    }

    return _buildEmptyContent();
  }

  /// Builds error state UI with retry functionality
  Widget _buildErrorContent(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          AppTextstyle(
            text: message,
            style: appStyle(
              size: 16,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadExpenseDetails,
            child: AppTextstyle(
              text: 'Retry',
              style: appStyle(
                size: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds empty state UI when no expense data is available
  Widget _buildEmptyContent() {
    return Center(
      child: AppTextstyle(
        text: 'No expense details available',
        style: appStyle(
          size: 16,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Builds the main details content with all expense information cards
  Widget _buildDetailsContent(ExpenseEntity expense) {
    final statusString = _formatStatusString(expense.status.toString());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(statusString),
          const SizedBox(height: 24),
          _buildInfoCard(expense),
          const SizedBox(height: 24),
          if (_hasDescription(expense)) ...[
            _buildDescriptionCard(expense.description!),
            const SizedBox(height: 24),
          ],
          _buildActionsCard(expense),
        ],
      ),
    );
  }

  /// Formats status string to capitalize first letter
  String _formatStatusString(String status) {
    final statusString = status.split('.').last;
    return statusString[0].toUpperCase() + statusString.substring(1);
  }

  /// Checks if expense has a non-empty description
  bool _hasDescription(ExpenseEntity expense) {
    return expense.description != null && expense.description!.isNotEmpty;
  }

  /// Builds status card with colored indicator and icon
  Widget _buildStatusCard(String status) {
    final statusConfig = _getStatusConfiguration(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusConfig.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusConfig.color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(
            statusConfig.icon,
            color: statusConfig.color,
            size: 32,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Status',
                style: appStyle(
                  size: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextstyle(
                text: status,
                style: appStyle(
                  size: 18,
                  color: statusConfig.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Gets color and icon configuration for different expense statuses
  ({Color color, IconData icon}) _getStatusConfiguration(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return (color: Colors.green, icon: Icons.check_circle);
      case 'reject':
        return (color: Colors.red, icon: Icons.cancel);
      case 'pending':
      default:
        return (color: Colors.orange, icon: Icons.hourglass_empty);
    }
  }

  /// Builds information card with expense details like type, amount, locations, and employee ID
  Widget _buildInfoCard(ExpenseEntity expense) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Expense Information',
              style: appStyle(
                size: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Expense Type', expense.expenseType.name),
            const Divider(),
            _buildInfoRow('Amount', _formatAmount(expense.amount)),
            if (expense.from?.isNotEmpty == true) ...[
              const Divider(),
              _buildInfoRow('From', expense.from!),
            ],
            if (expense.to?.isNotEmpty == true) ...[
              const Divider(),
              _buildInfoRow('To', expense.to!),
            ],
            const Divider(),
            _buildInfoRow('Employee ID', expense.employeeId),
            const Divider(),
            _buildInfoRow('Employee Name', expense.employeeName),
            const Divider(),
            _buildInfoRow('Created At', _formatDateTime(expense.createdAt)),
          ],
        ),
      ),
    );
  }

  /// Formats DateTime to readable string format
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Builds a single information row with label and value
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: AppTextstyle(
              text: value,
              style: appStyle(
                size: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds description card with expense description text
  Widget _buildDescriptionCard(String description) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Description',
              style: appStyle(
                size: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppTextstyle(
                text: description,
                style: appStyle(
                  size: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds actions card with delete button for pending expenses
  Widget _buildActionsCard(ExpenseEntity expense) {
    // Only show delete action for pending expenses
    if (expense.status != ExpenseStatus.Pending) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Actions',
              style: appStyle(
                size: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Appbtn(
                text: 'Delete Expense',
                onPressed: () => _showDeleteConfirmation(expense.id.toString()),
                bgColor: Colors.red,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows confirmation dialog before deleting expense
  void _showDeleteConfirmation(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppTextstyle(
          text: 'Delete Expense',
          style: appStyle(
            size: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: AppTextstyle(
          text:
              'Are you sure you want to delete this expense? This action cannot be undone.',
          style: appStyle(
            size: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppTextstyle(
              text: 'Cancel',
              style: appStyle(
                size: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
              _deleteExpense(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: AppTextstyle(
              text: 'Delete',
              style: appStyle(
                size: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Deletes expense with error handling and navigation back to list
  Future<void> _deleteExpense(String id) async {
    try {
      // Get current expense details to retrieve employeeId
      final currentState = cubit.state;
      String? employeeId;

      if (currentState is ExpenseDetailLoaded) {
        employeeId = currentState.expense.employeeId;
      } else if (currentState is ExpenseDetailSuccess) {
        employeeId = currentState.expense.employeeId;
      }

      if (employeeId == null) {
        throw Exception('Unable to retrieve employee ID for expense deletion');
      }

      // Perform delete operation
      await cubit.deleteExpense(id, employeeId);

      if (!mounted) return;

      // Show success message
      toastification.show(
        context: context,
        title: const Text('Expense Deleted'),
        description: const Text('The expense has been successfully deleted.'),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 3),
      );

      // Simulate navigation delay (500ms) and navigate back
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      debugPrint('Error deleting expense: $e');

      if (!mounted) return;

      // Show error message
      toastification.show(
        context: context,
        title: const Text('Delete Failed'),
        description: Text('Failed to delete expense: ${e.toString()}'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }
}
