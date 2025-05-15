import 'package:fleekhr/data/models/wfh_request/wfh_model.dart';
import 'package:fleekhr/data/service/wfh_req/wfh_api_service.dart';
import 'package:fleekhr/presentation/Request/widget/calendarpage.dart';
import 'package:fleekhr/presentation/Request/widget/common_reason_sheet.dart';
import 'package:fleekhr/presentation/Request/widget/date_range_display.dart';
import 'package:fleekhr/presentation/Request/widget/dialog.dart';
import 'package:fleekhr/presentation/Request/widget/info_card.dart';
import 'package:fleekhr/presentation/Request/widget/reason_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleekhr/common/widgets/appbtn.dart';


/// WorkFromHomeScreen handles Work From Home request submission
///
/// This screen provides a user interface for employees to:
/// - Select a date range for WFH
/// - Input a reason for the request
/// - Submit the request for manager approval
/// - View common reasons and help information
class WorkFromHomeScreen extends StatefulWidget {
  const WorkFromHomeScreen({super.key});

  @override
  State<WorkFromHomeScreen> createState() => _WorkFromHomeScreenState();
}

class _WorkFromHomeScreenState extends State<WorkFromHomeScreen> {
  // Dependencies
  final _wfhApiService = WfhApiService();
  
  // Controllers
  final _reasonController = TextEditingController();
  
  // State
  WfhModel _request = WfhModel.initial();
  bool _isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  /// Handles date range selection from calendar
  void _onDateRangeSelected(DateTime? start, DateTime? end) {
    if (start == null || end == null) return;
    setState(() {
      _request = _request.copyWith(
        startDate: start,
        endDate: end,
        totalDays: end.difference(start).inDays + 1,
      );
    });
  }

  /// Submits WFH request to API
  Future<void> _submitRequest() async {
    if (!_validateInput()) return;

    setState(() => _isLoading = true);

    try {
      _request = _request.copyWith(reason: _reasonController.text);
      await _wfhApiService.submitWFHReq(_request);
      
      _showSuccessMessage("Your WFH request has been submitted");
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showErrorMessage("Failed to submit request: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Validates form input
  bool _validateInput() {
    if (_reasonController.text.isEmpty) {
      _showErrorMessage("Please provide a reason for your request");
      return false;
    }
    return true;
  }

  /// Shows error snackbar
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Shows success snackbar
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: _buildAppBar(primaryColor),
      body: SafeArea(
        child: _isLoading
            ? const _LoadingState()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(),
                    SizedBox(height: 24.h),
                    DateRangeDisplay(
                      startDate: _request.startDate,
                      endDate: _request.endDate,
                      totalDays: _request.totalDays,
                    ),
                    SizedBox(height: 24.h),
                    Calendarpage(
                      onRangeDateSelected: _onDateRangeSelected,
                    ),
                    SizedBox(height: 24.h),
                    ReasonInput(
                      controller: _reasonController,
                      onCommonReasonsTap: () => CommonReasonsSheet.show(
                        context: context,
                        onReasonSelected: (reason) {
                          _reasonController.text = reason;
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Appbtn(
                      text: "Submit Request",
                      color: primaryColor,
                      width: double.infinity,
                      height: 54.h,
                      radius: 12,
                      fontSize: 16.sp,
                      textColor: Colors.white,
                      onPressed: _submitRequest,
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        "By submitting, you agree to company WFH policy",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
      ),
    );
  }

  /// Builds the app bar with title and actions
  AppBar _buildAppBar(Color primaryColor) {
    return AppBar(
      toolbarHeight: 60.h,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "WFH Request",
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.white),
          onPressed: () => HelpDialog.show(context),
        ),
      ],
    );
  }
}

/// Displays loading state with progress indicator
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            "Processing your request...",
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}