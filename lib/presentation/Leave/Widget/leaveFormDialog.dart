import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LeaveFormDialog {
  final BuildContext context;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _subjectLeave;
  final TextEditingController _startTimeController;
  final TextEditingController _endTimeController;
  final TextEditingController _reason;

  final List<String> _leaveTypes = [
    "Annual Leave",
    "Leave Without Pay",
    "Sick Leave",
  ];

  void showLeaveBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _leaveTypes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: AppTextstyle(
                        text: _leaveTypes[index],
                        style: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        _subjectLeave.text = _leaveTypes[index];
                        Navigator.pop(context);
                      },
                    );
                  },
                )),
              ],
            ),
          );
        });
  }

  // Callback for successful form submission
  final Function()? onSubmitSuccess;

  LeaveFormDialog({
    required this.context,
    TextEditingController? subjectLeaveController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
    TextEditingController? reasonController,
    this.onSubmitSuccess,
  })  : _subjectLeave = subjectLeaveController ?? TextEditingController(),
        _startTimeController = startTimeController ?? TextEditingController(),
        _endTimeController = endTimeController ?? TextEditingController(),
        _reason = reasonController ?? TextEditingController();

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
                        controller: _subjectLeave,
                        decoration: InputDecoration(
                          labelText: "Leave Type",
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
                              controller: _startTimeController,
                              decoration: const InputDecoration(
                                  labelText: 'Starting Date',
                                  border: OutlineInputBorder()),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: dialogContext,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)),
                                );
                                if (picked != null) {
                                  // Format the date
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(picked);
                                  _startTimeController.text = formattedDate;
                                }
                              },
                              readOnly: true,
                            ),
                          ),
                          SizedBox(
                              width: 10.w), // Add some space between the fields
                          Expanded(
                            child: TextFormField(
                              controller: _endTimeController,
                              decoration: const InputDecoration(
                                  labelText: 'Ending Date',
                                  border: OutlineInputBorder()),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: dialogContext,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)),
                                );
                                if (picked != null) {
                                  // Format the date
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(picked);
                                  _endTimeController.text = formattedDate;
                                }
                              },
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      SizedBox(height: 10.h),
                      Apptextfield(
                        controller: _reason,
                        hintText: "Describe your reason",
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
    _startTimeController.dispose();
    _endTimeController.dispose();
  }
}
