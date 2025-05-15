/// Expense Screen allows user to submit and track expense request.
part of 'expense_screen_imports.dart';
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  // Controllers for the expense form
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  // For filtering and viewing expenses
  String _selectedFilter = "All";
  bool _isLoading = false;
  
  // Sample expense data - will be replaced by API calls
  final List<Map<String, dynamic>> _expenseRequests = [
    {
      "id": "EXP001",
      "purpose": "Rickshaw",
      "amount": "60 Tk",
      "date": "23-10-15",
      "status": StatusType.pending,
      "from": "Office",
      "to": "Home"
    },
    {
      "id": "EXP002",
      "purpose": "Pizza",
      "amount": "450 Tk",
      "date": "23-10-14",
      "status": StatusType.accepted,
      "from": "",
      "to": ""
    },
    {
      "id": "EXP003",
      "purpose": "Bus Fare",
      "amount": "35 Tk",
      "date": "23-10-12",
      "status": StatusType.rejected,
      "from": "Home",
      "to": "Office"
    },
    {
      "id": "EXP004",
      "purpose": "Office Supplies",
      "amount": "250 Tk",
      "date": "23-10-10",
      "status": StatusType.accepted,
      "from": "",
      "to": ""
    }
  ];
  
  @override
  void dispose() {
    _purposeController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  /// Shows dialog to add a new expense
  void _showExpenseDialog() {
    final expenseDialog = ExpenseForumDialog(
      context: context,
      subjectLeaveController: TextEditingController(),
      startTimeController: TextEditingController(),
      endTimeController: TextEditingController(),
      reasonController: TextEditingController(),
      onSubmitSuccess: _handleExpenseSubmitSuccess,
    );
    expenseDialog.show();
  }
  
  /// Handles successful submission of expense
  void _handleExpenseSubmitSuccess() {
    setState(() {
      // In real app, this would add the new expense from API response
      _expenseRequests.insert(0, {
        "id": "EXP00${_expenseRequests.length + 1}",
        "purpose": _purposeController.text.isEmpty ? "New Expense" : _purposeController.text,
        "amount": _amountController.text.isEmpty ? "0 Tk" : "${_amountController.text} Tk",
        "date": DateTime.now().toString().substring(0, 10),
        "status": StatusType.pending,
        "from": _fromController.text,
        "to": _toController.text
      });
    });
  }

  /// Filters expense requests by status
  List<Map<String, dynamic>> _getFilteredExpenseRequests() {
    if (_selectedFilter == "All") {
      return _expenseRequests;
    } else {
      StatusType filterStatus;
      switch (_selectedFilter) {
        case "Pending":
          filterStatus = StatusType.pending;
          break;
        case "Approved":
          filterStatus = StatusType.accepted;
          break;
        case "Rejected":
          filterStatus = StatusType.rejected;
          break;
        default:
          return _expenseRequests;
      }
      return _expenseRequests.where((expense) => expense["status"] == filterStatus).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final filteredExpenses = _getFilteredExpenseRequests();
    
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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
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
          // Filter button
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      
      // Floating action button to add new expense
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showExpenseDialog,
        backgroundColor: primaryColor,
        label: Text("Add Expense"),
        icon: Icon(Icons.add),
      ),
      
      body: _isLoading 
        ? _buildLoadingState()
        : _buildExpenseList(filteredExpenses),
    );
  }
  
  /// Builds loading indicator
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text("Loading expense data...",
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
  
  /// Builds the list of expense requests
  Widget _buildExpenseList(List<Map<String, dynamic>> expenses) {
    return RefreshIndicator(
      onRefresh: _refreshExpenses,
      child: expenses.isEmpty
        ? _buildEmptyState() 
        : SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary card at the top
                _buildExpenseSummaryCard(),
                SizedBox(height: 24.h),
                
                // Expense history title with filter info
                Row(
                  children: [
                    Text(
                      "Expense History",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    Spacer(),
                    if (_selectedFilter != "All")
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "Filter: $_selectedFilter",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                
                // List of expense requests
                ...expenses.map((expense) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildExpenseCard(expense),
                )),
              ],
            ),
          ),
    );
  }
  
  /// Builds the empty state when no expenses are available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.doc_text_search,
            size: 70.sp,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            "No expense requests found",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _selectedFilter != "All" 
                ? "Try changing your filter" 
                : "Tap the + button to add a new request",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),
          if (_selectedFilter != "All")
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedFilter = "All";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              child: Text("Clear Filter"),
            ),
        ],
      ),
    );
  }
  
  /// Shows filter options for expense list
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Filter Expenses",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Divider(),
              
              // Filter options
              _buildFilterOption("All"),
              _buildFilterOption("Pending"),
              _buildFilterOption("Approved"),
              _buildFilterOption("Rejected"),
            ],
          ),
        );
      },
    );
  }
  
  /// Builds individual filter option
  Widget _buildFilterOption(String filterName) {
    final isSelected = _selectedFilter == filterName;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = filterName;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            SizedBox(width: 16.w),
            Text(
              filterName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds expense summary card with statistics
  Widget _buildExpenseSummaryCard() {
    // Calculate expense statistics
    int totalExpenses = _expenseRequests.length;
    int pendingCount = _expenseRequests.where((e) => e["status"] == StatusType.pending).length;
    int approvedCount = _expenseRequests.where((e) => e["status"] == StatusType.accepted).length;
    int rejectedCount = _expenseRequests.where((e) => e["status"] == StatusType.rejected).length;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense Overview",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Total", totalExpenses.toString(), Colors.blue),
                _buildStatItem("Pending", pendingCount.toString(), Colors.orange),
                _buildStatItem("Approved", approvedCount.toString(), Colors.green),
                _buildStatItem("Rejected", rejectedCount.toString(), Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds individual expense status statistic item
  Widget _buildStatItem(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  /// Builds individual expense card
  Widget _buildExpenseCard(Map<String, dynamic> expense) {
    final status = expense["status"] as StatusType;
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => _showExpenseDetails(expense),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Expense icon based on purpose
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: _getExpenseColor(expense["purpose"]).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      _getExpenseIcon(expense["purpose"]),
                      color: _getExpenseColor(expense["purpose"]),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
                  // Expense details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense["purpose"],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Date: ${expense["date"]}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Status and amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          _getStatusText(status),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: _getStatusColor(status),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        expense["amount"],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Shows detailed view of an expense
  void _showExpenseDetails(Map<String, dynamic> expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          // Use a higher height, about 70% of screen
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Row(
                children: [
                  Text(
                    "Expense Details",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 12.h),
              
              // ID and status
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: _getExpenseColor(expense["purpose"]).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getExpenseIcon(expense["purpose"]),
                      color: _getExpenseColor(expense["purpose"]),
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID: ${expense["id"]}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _getStatusColor(expense["status"]).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              _getStatusText(expense["status"]),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: _getStatusColor(expense["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              
              // Details list
              _buildDetailItem("Purpose", expense["purpose"]),
              _buildDetailItem("Amount", expense["amount"]),
              _buildDetailItem("Date", expense["date"]),
              if (expense["from"]?.isNotEmpty ?? false)
                _buildDetailItem("From", expense["from"]),
              if (expense["to"]?.isNotEmpty ?? false)
                _buildDetailItem("To", expense["to"]),
              
              Spacer(),
              
              // Action buttons based on status
              if (expense["status"] == StatusType.pending)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // In a real app, this would call API to cancel the expense
                          _showMessage("Expense request cancelled");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text("Cancel Request"),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showExpenseDialog(); // Pre-fill with current data
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text("Edit Request"),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
  
  /// Builds individual detail item in expense details
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Get appropriate icon for expense type
  IconData _getExpenseIcon(String purpose) {
    purpose = purpose.toLowerCase();
    if (purpose.contains("rickshaw") || purpose.contains("taxi"))
      return CupertinoIcons.car_detailed;
    else if (purpose.contains("bus") || purpose.contains("train") || purpose.contains("metro"))
      return CupertinoIcons.bus;
    else if (purpose.contains("food") || purpose.contains("lunch") || purpose.contains("pizza"))
      return CupertinoIcons.flame;
    else if (purpose.contains("office") || purpose.contains("supplies"))
      return CupertinoIcons.doc_text;
    else
      return CupertinoIcons.money_dollar_circle;
  }
  
  /// Get appropriate color for expense type
  Color _getExpenseColor(String purpose) {
    purpose = purpose.toLowerCase();
    if (purpose.contains("rickshaw") || purpose.contains("taxi") || purpose.contains("bus"))
      return Colors.blue;
    else if (purpose.contains("food") || purpose.contains("lunch") || purpose.contains("pizza"))
      return Colors.orange;
    else if (purpose.contains("office") || purpose.contains("supplies"))
      return Colors.green;
    else
      return Theme.of(context).primaryColor;
  }
  
  /// Get color based on status
  Color _getStatusColor(StatusType status) {
    switch (status) {
      case StatusType.pending:
        return Colors.orange;
      case StatusType.accepted:
        return Colors.green;
      case StatusType.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  /// Get text based on status
  String _getStatusText(StatusType status) {
    switch (status) {
      case StatusType.pending:
        return "Pending";
      case StatusType.accepted:
        return "Approved";
      case StatusType.rejected:
        return "Rejected";
      default:
        return "Unknown";
    }
  }
  
  /// Shows a snackbar message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  
  /// Simulates refreshing expenses from API
  Future<void> _refreshExpenses() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
      // In a real app, this would update with fresh data from API
    });
  }
}