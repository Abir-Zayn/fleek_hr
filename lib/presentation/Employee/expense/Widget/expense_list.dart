import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:fleekhr/presentation/Employee/expense/Widget/expense_card.dart';
import 'package:fleekhr/presentation/Employee/expense/Widget/expense_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ExpenseListWidget extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final String selectedFilter;
  final bool isLoading;
  final Future<void> Function() onRefresh;
  final void Function(ExpenseModel) onExpenseTap;

  const ExpenseListWidget({
    super.key,
    required this.expenses,
    required this.selectedFilter,
    required this.isLoading,
    required this.onRefresh,
    required this.onExpenseTap,
  });

  List<ExpenseModel> _getFilteredExpenses() {
    if (selectedFilter == "All") return expenses;
    return expenses.where((expense) {
      switch (selectedFilter) {
        case "Pending":
          return expense.status == StatusType.pending;
        case "Approved":
          return expense.status == StatusType.accepted;
        case "Rejected":
          return expense.status == StatusType.rejected;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses();
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: isLoading
          ? _buildLoadingState()
          : filteredExpenses.isEmpty
              ? _buildEmptyState(context)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpenseSummaryWidget(expenses: expenses),
                      SizedBox(height: 24.h),
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
                          const Spacer(),
                          if (selectedFilter != "All")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "Filter: $selectedFilter",
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
                      ...filteredExpenses.map(
                        (expense) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ExpenseCardWidget(
                            expense: expense,
                            onTap: () => onExpenseTap(expense),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            "Loading expense data...",
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
            selectedFilter != "All"
                ? "Try changing your filter"
                : "Tap the + button to add a new request",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          if (selectedFilter != "All") ...[
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                // Assuming parent widget handles filter state
                // This is a simplified approach; ideally, use a callback
                Navigator.pop(context); // Close filter sheet if open
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              child: const Text("Clear Filter"),
            ),
          ],
        ],
      ),
    );
  }
}