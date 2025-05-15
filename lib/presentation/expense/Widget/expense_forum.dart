import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpenseForumDialog {
  final BuildContext context;
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
  final Function()? onSubmitSuccess;

  ExpenseForumDialog({
    required this.context,
    TextEditingController? subjectLeaveController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
    TextEditingController? reasonController,
    this.onSubmitSuccess,
  })  : _expensePurpose = subjectLeaveController ?? TextEditingController(),
        _from = startTimeController ?? TextEditingController(),
        _to = endTimeController ?? TextEditingController(),
        _amount = reasonController ?? TextEditingController();

  void show() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SizedBox(
          width: 500.w,
          child: AlertDialog(
            title: AppTextstyle(
              text: "Add Leave Request",
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
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),

              // Submit Button
              Appbtn(
                text: "Submit",
                color: Colors.blue.shade900,
                textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle Form Submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: AppTextstyle(
                          text: "Added Successfully",
                          style: appStyle(
                              size: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    // Call the success callback if provided
                    if (onSubmitSuccess != null) {
                      onSubmitSuccess!();
                    }

                    dialogContext.pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  // Method to dispose all controllers
  void dispose() {
    _from.dispose();
    _to.dispose();
  }
}
