import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActivityFormDialog {
  final BuildContext context;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _companyNameController;
  final TextEditingController _departmentController;
  final TextEditingController _projectNameController;
  final TextEditingController _startTimeController;
  final TextEditingController _endTimeController;
  final TextEditingController _deliveryTimeController;
  final TextEditingController _workStatusController;
  final TextEditingController _workTypeController;
  final TextEditingController _assignedByController;
  final TextEditingController _workDetailsController;
  final TextEditingController _feedbackController;
  final TextEditingController _remarksController;

  // Callback for successful form submission
  final Function()? onSubmitSuccess;

  ActivityFormDialog({
    required this.context,
    TextEditingController? companyNameController,
    TextEditingController? departmentController,
    TextEditingController? projectNameController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
    TextEditingController? deliveryTimeController,
    TextEditingController? workStatusController,
    TextEditingController? workTypeController,
    TextEditingController? assignedByController,
    TextEditingController? workDetailsController,
    TextEditingController? feedbackController,
    TextEditingController? remarksController,
    this.onSubmitSuccess,
  })  : _companyNameController = companyNameController ??
            TextEditingController(text: "Fleek Bangladesh"),
        _departmentController = departmentController ?? TextEditingController(),
        _projectNameController =
            projectNameController ?? TextEditingController(),
        _startTimeController = startTimeController ?? TextEditingController(),
        _endTimeController = endTimeController ?? TextEditingController(),
        _deliveryTimeController =
            deliveryTimeController ?? TextEditingController(),
        _workStatusController = workStatusController ?? TextEditingController(),
        _workTypeController = workTypeController ?? TextEditingController(),
        _assignedByController = assignedByController ?? TextEditingController(),
        _workDetailsController =
            workDetailsController ?? TextEditingController(),
        _feedbackController = feedbackController ?? TextEditingController(),
        _remarksController = remarksController ?? TextEditingController();

  void show() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SizedBox(
          width: 500.w,
          child: AlertDialog(
            title: AppTextstyle(
              text: "Add Activity",
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
                        readOnly: true,
                        controller: _companyNameController,
                        decoration: InputDecoration(
                          labelText: "Company Name",
                          labelStyle: appStyle(
                              size: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Department TextField
                      Apptextfield(
                        controller: _departmentController,
                        labelText: "Department",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your department';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // Project Name TextField
                      Apptextfield(
                        controller: _projectNameController,
                        labelText: "Project Name",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),
                      // Start Time and End Time TextFields
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _startTimeController,
                              decoration: const InputDecoration(
                                  labelText: 'Start Time',
                                  border: OutlineInputBorder()),
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: dialogContext,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  _startTimeController.text =
                                      picked.format(dialogContext);
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
                                  labelText: 'End Time',
                                  border: OutlineInputBorder()),
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: dialogContext,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  _endTimeController.text =
                                      picked.format(dialogContext);
                                }
                              },
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Delivery Time TextField
                      TextFormField(
                        controller: _deliveryTimeController,
                        decoration: const InputDecoration(
                            labelText: 'Delivery Time',
                            border: OutlineInputBorder()),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: dialogContext,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            _deliveryTimeController.text =
                                picked.format(dialogContext);
                          }
                        },
                        readOnly: true,
                      ),
                      SizedBox(height: 10.h),

                      // Work Status TextField
                      Apptextfield(
                        controller: _workStatusController,
                        labelText: "Work Status",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter work status';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // Work Type TextField
                      Apptextfield(
                        controller: _workTypeController,
                        labelText: "Work Type",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),

                      // Assigned By TextField
                      Apptextfield(
                        controller: _assignedByController,
                        labelText: "Assigned By",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),

                      // Work Details TextField
                      Apptextfield(
                        maxLines: 5,
                        height: 100.h,
                        controller: _workDetailsController,
                        labelText: "Work Details",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),

                      // Feedback TextField
                      Apptextfield(
                        controller: _feedbackController,
                        labelText: "Feedback",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),

                      // Remarks TextField
                      Apptextfield(
                        controller: _remarksController,
                        labelText: "Remarks",
                        labelStyle: appStyle(
                            size: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        borderRadius: 10.r,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.h),
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
                          text: "Activity Added Successfully",
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
    _companyNameController.dispose();
    _departmentController.dispose();
    _projectNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _deliveryTimeController.dispose();
    _workStatusController.dispose();
    _workTypeController.dispose();
    _assignedByController.dispose();
    _workDetailsController.dispose();
    _feedbackController.dispose();
    _remarksController.dispose();
  }
}
