import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';
import 'package:flutter/material.dart';

class ExpenseTypeSeletor extends StatefulWidget {
  final List<ExpenseType> expenseTypes;
  final ExpenseType? selectedExpenseType;
  final Function(ExpenseType) onExpenseTypeSelected;

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
  late ExpenseType selectedExpenseType;

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
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Expense Types',
                style: appStyle(
                  size: 15,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Selecting the expense type
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppTextstyle(
                        text: expenseType.name,
                        style: appStyle(
                          size: 14,
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
        ),
      ],
    );
  }
}
