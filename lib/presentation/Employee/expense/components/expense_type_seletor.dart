import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/data/service/expense/expense_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseTypeSeletor extends StatefulWidget {
  final List<ExpenseTypeModel> expenseTypes;
  final ExpenseTypeModel? selectedExpenseType;
  final Function(ExpenseTypeModel) onExpenseTypeSelected;
  const ExpenseTypeSeletor({
    super.key,
    required this.expenseTypes,
    this.selectedExpenseType,
    required this.onExpenseTypeSelected,
  });

  @override
  State<ExpenseTypeSeletor> createState() => _ExpenseTypeSeletorState();
}

class _ExpenseTypeSeletorState extends State<ExpenseTypeSeletor> {
  late ExpenseTypeModel selectedExpenseType;

  @override
  void initState() {
    super.initState();
    // Initialize the first expense type as selected by default
    selectedExpenseType =
        widget.selectedExpenseType ?? widget.expenseTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Expense Types',
                style: appStyle(
                  size: 15.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),

              //Selecting the expense type
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.expenseTypes.map((expenseType) {
                  final isSelected = selectedExpenseType == expenseType;
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExpenseType = expenseType;
                        });
                        widget.onExpenseTypeSelected(expenseType);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: AppTextstyle(
                          text: expenseType.name,
                          style: appStyle(
                            size: 14.sp,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
