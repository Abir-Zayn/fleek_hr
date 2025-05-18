import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/domain/repository/expense/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpenseForumDialog {
  final BuildContext context;
  final ExpenseModel expenseModel;
  final Function(ExpenseModel)? onSubmitSuccess;
  final ExpenseRepository expenseRepository;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _expensePurpose;
  final TextEditingController _from;
  final TextEditingController _to;
  final TextEditingController _amount;

  final List<String> _expenseTypes = [
    "Lunch",
    "Snacks",
    "Bus",
    "Rickshaw",
    "BIKE",
    "CNG",
    "Metro Rail"
  ];

  void showLeaveBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: _expenseTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: AppTextstyle(
                      text: _expenseTypes[index],
                      style: appStyle(
                          size: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      _expensePurpose.text = _expenseTypes[index];
                      Navigator.pop(context);
                    },
                  );
                },
              )),
            ],
          );
        });
  }

  // Callback for successful form submission

  ExpenseForumDialog({
    required this.context,
    required this.expenseModel,
    required this.expenseRepository,
    TextEditingController? subjectLeaveController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
    TextEditingController? reasonController,
    this.onSubmitSuccess,
  })  : _expensePurpose = subjectLeaveController ?? TextEditingController(),
        _from = startTimeController ?? TextEditingController(),
        _to = endTimeController ?? TextEditingController(),
        _amount = reasonController ?? TextEditingController() {
    // Initialize controllers with existing data if editing
    _expensePurpose.text = expenseModel.purpose;
    _from.text = expenseModel.from;
    _to.text = expenseModel.to;
    _amount.text = expenseModel.amount.toString();
  }

  void show() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SizedBox(
          width: 500.w,
          child: AlertDialog(
            title: AppTextstyle(
              text: "Add Expense",
              style: appStyle(
                  size: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: 400.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Company Name TextField
                      SizedBox(height: 5.h),
                      TextFormField(
                        controller: _expensePurpose,
                        decoration: InputDecoration(
                          labelText: "Expense Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                        ),
                        readOnly: true,
                        onTap: () {
                          showLeaveBottomSheet(context);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a leave type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // Start Time and End Time TextFields
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _from,
                              decoration: const InputDecoration(
                                  labelText: 'From(Optional)',
                                  border: OutlineInputBorder()),
                              readOnly: true,
                            ),
                          ),
                          SizedBox(
                              width: 10.w), // Add some space between the fields
                          Expanded(
                            child: TextFormField(
                              controller: _to,
                              decoration: const InputDecoration(
                                  labelText: 'To(Optional)',
                                  border: OutlineInputBorder()),
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      SizedBox(height: 10.h),
                      Apptextfield(
                        controller: _amount,
                        hintText: "Amount",
                        maxLines: 3,
                        minLines: 1,
                        borderRadius: 10,
                        contentPadding: EdgeInsets.all(10.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  dialogContext.pop();
                },
                child: AppTextstyle(
                  text: "Cancel",
                  style: appStyle(
                      size: 15.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color ??
                          Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),

              // Submit Button
              Appbtn(
                text: "Submit",
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newExpense = ExpenseModel(
                      id: expenseModel.id.isEmpty
                          ? "EXP${DateTime.now().millisecondsSinceEpoch}"
                          : expenseModel.id,
                      purpose: _expensePurpose.text,
                      amount: double.tryParse(_amount.text) ?? 0.0,
                      date: DateTime.now(),
                      status: expenseModel.status,
                      from: _from.text,
                      to: _to.text,
                    );
                    try {
                      final result = await expenseRepository
                          .submitExpense(newExpense.toEntity());
                      result.fold(
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed: ${failure.message}"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        (success) {
                          onSubmitSuccess?.call(newExpense);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AppTextstyle(
                                text: "Expense submitted successfully",
                                style: appStyle(
                                  size: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          dialogContext.pop();
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to dispose all controllers
  void dispose() {
    _expensePurpose.dispose();
    _amount.dispose();
    _from.dispose();
    _to.dispose();
  }
}
