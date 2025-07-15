part of 'add_work_from_home_imports.dart';

/// WorkFromHomeScreen handles Work From Home request submission
class AddWorkFromHomeScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  const AddWorkFromHomeScreen({
    super.key,
    required this.employeeId,
    required this.employeeName,
  });

  @override
  State<AddWorkFromHomeScreen> createState() => _AddWorkFromHomeScreenState();
}

class _AddWorkFromHomeScreenState extends State<AddWorkFromHomeScreen> {
  final TextEditingController reasonController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  final List<String> commonReasons = [
    'Mild illness/recovery',
    'Family commitments',
    'Home repairs/maintenance',
    'Awaiting delivery',
    'Transport issues'
  ];

  late final WorkFromHomeCubit _workFromHomeCubit;

  @override
  void initState() {
    super.initState();
    _workFromHomeCubit = sl<WorkFromHomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Return false to prevent default back button behavior
      // We'll handle navigation manually
      onWillPop: () async {
        context.pop(
            false); // Navigate back with false to indicate no refresh needed
        return false;
      },
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Work From Home Request",
          onBackButtonPressed: () {
            // Handle back button press with the same logic
            context.pop(false);
          },
        ),
        body: BlocConsumer<WorkFromHomeCubit, WorkFromHomeState>(
          bloc: _workFromHomeCubit,
          listener: (context, state) {
            if (state is WorkFromHomeLoading) {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
              );
            } else {
              // Dismiss loading dialog if it's showing
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              if (state is WorkFromHomeSuccess) {
                // Show success message
                toastification.show(
                    context: context,
                    title: Text('Request Submitted'),
                    type: ToastificationType.success,
                    autoCloseDuration: Duration(seconds: 2),
                    direction: TextDirection.ltr,
                    animationDuration: const Duration(milliseconds: 300),
                    style: ToastificationStyle.flatColored);

                // Navigate back with true to indicate refresh needed
                context.pop(true);
              } else if (state is WorkFromHomeError) {
                // Show error message
                toastification.show(
                    context: context,
                    title: Text('Error: ${state.message}'),
                    type: ToastificationType.error,
                    autoCloseDuration: Duration(seconds: 2),
                    direction: TextDirection.ltr,
                    animationDuration: const Duration(milliseconds: 300),
                    style: ToastificationStyle.fillColored);
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  SizedBox(height: 24),
                  dateSelection(),
                  SizedBox(height: 24),
                  reasonSelection(),
                  SizedBox(height: 16),
                  commonReasonSelection(),
                  SizedBox(height: 40),
                  submitBtn(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: AppTextstyle(
              text:
                  'Your WFH request will be sent to your manager for approval. Please ensure you have discussed this with your team.',
              style: appStyle(
                size: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Date Range',
          style: appStyle(
            size: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDateSelector(
                label: 'Start Date',
                date: startDate,
                onTap: () => _selectDate(true),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildDateSelector(
                label: 'End Date',
                date: endDate,
                onTap: () => _selectDate(false),
              ),
            ),
          ],
        ),
        if (startDate != null && endDate != null) ...[
          SizedBox(height: 12),
          _buildDurationInfo(),
        ],
      ],
    );
  }

  Widget _buildDurationInfo() {
    final days = endDate!.difference(startDate!).inDays + 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: Colors.grey.shade700,
          ),
          SizedBox(width: 8),
          AppTextstyle(
            text: 'Duration: $days ${days == 1 ? 'day' : 'days'}',
            style: appStyle(
              size: 13,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: label,
              style: appStyle(
                size: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8),
                AppTextstyle(
                  text: date == null
                      ? 'Select Date'
                      : '${date.day}/${date.month}/${date.year}',
                  style: appStyle(
                    size: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget reasonSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Explain your reason',
          style: appStyle(
            size: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: reasonController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Please explain why you need to work from home...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget commonReasonSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Common Reasons',
          style: appStyle(
            size: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: commonReasons.map((reason) {
            return InkWell(
              onTap: () {
                reasonController.text = reason;
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: AppTextstyle(
                  text: reason,
                  style: appStyle(
                    size: 12,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget submitBtn() {
    final bool isFormValid = reasonController.text.trim().isNotEmpty &&
        startDate != null &&
        endDate != null;

    return Appbtn(
      text: 'Submit',
      bgColor: Colors.black87,
      textColor: Colors.white,
      onPressed: isFormValid ? _submitRequest : null,
    );
  }

  void _selectDate(bool isStartDate) async {
    final DateTime currentDate = DateTime.now();
    final DateTime initialDate = isStartDate
        ? startDate ?? currentDate
        : endDate ?? (startDate ?? currentDate);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isStartDate ? currentDate : (startDate ?? currentDate),
      lastDate: currentDate.add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
          // Reset end date if it's before the new start date
          if (endDate != null && endDate!.isBefore(pickedDate)) {
            endDate = pickedDate;
          }
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  void _submitRequest() {
    // Validate form fields
    if (startDate == null ||
        endDate == null ||
        reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextstyle(
            text: 'Please fill in all required fields',
            style: appStyle(
              size: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create WFH request entity
    final now = DateTime.now();
    final workFromHomeRequest = WorkFromHomeEntity(
      id: '', // Will be generated by Supabase
      startDate: startDate!,
      endDate: endDate!,
      reason: reasonController.text.trim(),
      employeeId: widget.employeeId,
      employeeName: widget.employeeName,
      status: WorkFromHomeStatus.pending,
      createdAt: now,
      updatedAt: now,
    );

    // Submit request using cubit
    _workFromHomeCubit.createWorkFromHomeRequest(workFromHomeRequest);
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }
}
