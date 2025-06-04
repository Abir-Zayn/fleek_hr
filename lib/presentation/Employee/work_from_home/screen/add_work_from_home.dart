part of 'add_work_from_home_imports.dart';

/// WorkFromHomeScreen handles Work From Home request submission
class AddWorkFromHomeScreen extends StatefulWidget {
  const AddWorkFromHomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Work From Home Request",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            SizedBox(height: 24.h),
            _buildDateSelectionSection(),
            SizedBox(height: 24.h),
            _buildReasonSection(),
            SizedBox(height: 16.h),
            _buildCommonReasonsSection(),
            SizedBox(height: 40.h),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            size: 24.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your WFH request will be sent to your manager for approval. Please ensure you have discussed this with your team.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: appStyle(
            size: 16.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDateSelector(
                label: 'Start Date',
                date: startDate,
                onTap: () => _selectDate(true),
              ),
            ),
            SizedBox(width: 16.w),
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
          SizedBox(height: 12.h),
          _buildDurationInfo(),
        ],
      ],
    );
  }

  Widget _buildDurationInfo() {
    final days = endDate!.difference(startDate!).inDays + 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16.r,
            color: Colors.grey.shade700,
          ),
          SizedBox(width: 8.w),
          Text(
            'Duration: $days ${days == 1 ? 'day' : 'days'}',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
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
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.r,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  date == null
                      ? 'Select Date'
                      : '${date.day}/${date.month}/${date.year}',
                  style: TextStyle(
                    fontSize: 14.sp,
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

  Widget _buildReasonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Explain your reason',
          style: appStyle(
            size: 16.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: reasonController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Please explain why you need to work from home...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding: EdgeInsets.all(16.r),
          ),
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildCommonReasonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Reasons',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: commonReasons.map((reason) {
            return InkWell(
              onTap: () {
                reasonController.text = reason;
              },
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  reason,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    final bool isFormValid = startDate != null &&
        endDate != null &&
        reasonController.text.trim().isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isFormValid ? () => _submitRequest() : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
        ),
        child: Text(
          'Submit Request',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
    // Create WFH request model

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Dismiss loading

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Work From Home request submitted successfully",
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate back
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }
}
