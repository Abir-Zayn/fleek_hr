part of 'expense_details_imports.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final ExpenseEntity expense;

  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late final ExpenseCubit expenseCubit;

  @override
  void initState() {
    super.initState();
    expenseCubit = context.read<ExpenseCubit>();
  }

  Future<void> _deleteExpense() async {
    final confirmed = await _showDeleteConfirmationDialog();
    if (confirmed == true) {
      // Fixed: Added both expenseId and employeeId parameters
      await expenseCubit.deleteExpense(
        widget.expense.id.toString(),
        widget.expense.employeeId,
      );
    }
  }

  Future<bool?> _showDeleteConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
              const SizedBox(width: 8),
              const Text('Delete Expense'),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete this expense? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Expense Details",
        actionButton: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: widget.expense.status == ExpenseStatus.Pending
              ? _deleteExpense
              : null,
        ),
      ),
      body: BlocListener<ExpenseCubit, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(state.message),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
            Navigator.of(context).pop(); // Go back to expense list
          } else if (state is ExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh the expense details if needed
            await expenseCubit.getExpenseById(widget.expense.id.toString());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with expense type
                _buildHeaderSection(),

                const SizedBox(height: 16),

                // Status badge
                _buildStatusSection(),

                const SizedBox(height: 16),

                // Expense details
                _buildDetailsSection(),

                const SizedBox(height: 16),

                // Travel details (if applicable)
                if (widget.expense.from != null ||
                    widget.expense.to != null) ...[
                  _buildTravelSection(),
                  const SizedBox(height: 16),
                ],

                // Description section (if available)
                if (widget.expense.description != null &&
                    widget.expense.description!.isNotEmpty) ...[
                  _buildDescriptionSection(),
                  const SizedBox(height: 16),
                ],

                const SizedBox(height: 8),

                // Action buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getExpenseTypeIcon(widget.expense.expenseType),
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextstyle(
                      text: widget.expense.expenseType.name,
                      style: appStyle(
                        size: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppTextstyle(
                      text: 'ID: ${widget.expense.employeeId}',
                      style: appStyle(
                        size: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _getStatusColor(widget.expense.status),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: _getStatusColor(widget.expense.status).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getStatusIcon(widget.expense.status),
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              AppTextstyle(
                text: widget.expense.status.name.toUpperCase(),
                style: appStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return _buildInfoCard(
      title: 'Expense Information',
      icon: Icons.receipt_long,
      children: [
        _buildDetailRow(
            'Expense ID', '#${widget.expense.id.toString().padLeft(6, '0')}'),
        _buildDetailRow('Employee ID', widget.expense.employeeId),
        _buildDetailRow('Expense Type', widget.expense.expenseType.name),
        _buildDetailRow(
            'Amount', '\$${widget.expense.amount.toStringAsFixed(2)}'),
        _buildDetailRow('Status', _getStatusDisplayName(widget.expense.status)),
        _buildDetailRow('Created Date',
            _formatDate(DateTime.now())), // Add createdAt to entity later
      ],
    );
  }

  Widget _buildTravelSection() {
    return _buildInfoCard(
      title: 'Travel Information',
      icon: Icons.map_outlined,
      children: [
        if (widget.expense.from != null && widget.expense.from!.isNotEmpty)
          _buildDetailRow('From', widget.expense.from!),
        if (widget.expense.to != null && widget.expense.to!.isNotEmpty)
          _buildDetailRow('To', widget.expense.to!),
        if (widget.expense.from != null &&
            widget.expense.to != null &&
            widget.expense.from!.isNotEmpty &&
            widget.expense.to!.isNotEmpty)
          _buildDetailRow(
              'Route', '${widget.expense.from!} → ${widget.expense.to!}'),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return _buildInfoCard(
      title: 'Description',
      icon: Icons.description_outlined,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: AppTextstyle(
            text: widget.expense.description!,
            style: appStyle(
              size: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor, size: 22),
              const SizedBox(width: 12),
              AppTextstyle(
                text: title,
                style: appStyle(
                  size: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: AppTextstyle(
              text: '$label:',
              style: appStyle(
                fontWeight: FontWeight.w600,
                size: 15,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: AppTextstyle(
              text: value,
              style: appStyle(
                size: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        final isDeleting = state is ExpenseDeleting &&
            state.expenseId == widget.expense.id.toString();

        return Column(
          children: [
            // Delete button (only show if expense is pending)
            if (widget.expense.status == ExpenseStatus.Pending) ...[
              SizedBox(
                width: double.infinity,
                child: Appbtn(
                  bgColor: Colors.red,
                  text: isDeleting ? "Deleting..." : "Delete Expense",
                  textColor: Colors.white,
                  onPressed: isDeleting ? null : _deleteExpense,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Back button
            SizedBox(
              width: double.infinity,
              child: Appbtn(
                bgColor: Colors.grey.shade600,
                text: "Back to Expenses",
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getExpenseTypeIcon(ExpenseType type) {
    switch (type) {
      case ExpenseType.Travel:
        return Icons.flight_rounded;
      case ExpenseType.Meals:
        return Icons.restaurant_rounded;
      case ExpenseType.Entertainment:
        return Icons.celebration_rounded;
      case ExpenseType.Equipment:
        return Icons.devices_rounded;
      case ExpenseType.Utilities:
        return Icons.business_rounded;
      case ExpenseType.Supplies:
        return Icons.inventory_2_rounded;
      case ExpenseType.Class:
        return Icons.school_rounded;
    }
  }

  IconData _getStatusIcon(ExpenseStatus status) {
    switch (status) {
      case ExpenseStatus.Pending:
        return Icons.schedule_rounded;
      case ExpenseStatus.Approved:
        return Icons.check_circle_rounded;
      case ExpenseStatus.Reject:
        return Icons.cancel_rounded;
    }
  }

  Color _getStatusColor(ExpenseStatus status) {
    switch (status) {
      case ExpenseStatus.Approved:
        return Colors.green.shade600;
      case ExpenseStatus.Pending:
        return Colors.orange.shade600;
      case ExpenseStatus.Reject:
        return Colors.red.shade600;
    }
  }

  String _getStatusDisplayName(ExpenseStatus status) {
    switch (status) {
      case ExpenseStatus.Approved:
        return 'Approved';
      case ExpenseStatus.Pending:
        return 'Pending Approval';
      case ExpenseStatus.Reject:
        return 'Rejected';
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
