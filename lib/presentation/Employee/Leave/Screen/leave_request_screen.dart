part of 'leave_request_imports.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  List<LeaveTypeModel> leaveTypes = [];
  LeaveTypeModel? selectedLeaveType;

  // Date selection controllers
  DateTime? startDate;
  DateTime? endDate;
  String leaveType = 'Full Day'; // Default to Full Day
  TextEditingController reasonController = TextEditingController();
  String? attachmentPath;
  int leaveDuration = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the leave types from the data service
    leaveTypes = LeaveDataService.mockLeaveTypes();
    if (leaveTypes.isNotEmpty) {
      selectedLeaveType = leaveTypes[0]; // Set the first leave type as default
    }
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  void updateSelectedLeaveType(LeaveTypeModel type) {
    setState(() {
      selectedLeaveType = type;
      // Reset form when leave type changes
      startDate = null;
      endDate = null;
      leaveType = 'Full Day';
      leaveDuration = 0;
    });
  }

  void calculateDuration() {
    if (startDate == null || endDate == null) {
      setState(() {
        leaveDuration = 0;
      });
      return;
    }

    // If half-day selected, duration is 0.5
    if (leaveType == 'Half Day') {
      setState(() {
        leaveDuration = 1;
        endDate = startDate; // Force end date to be same as start date
      });
      return;
    }

    // Calculate full days between start and end dates
    final difference = endDate!.difference(startDate!).inDays + 1;
    setState(() {
      leaveDuration = difference;
    });
  }

  void onStartDateChanged(DateTime? date) {
    setState(() {
      startDate = date;
      // If end date is before new start date, reset it
      if (endDate != null && endDate!.isBefore(startDate!)) {
        endDate = startDate;
      }
      calculateDuration();
    });
  }

  void onEndDateChanged(DateTime? date) {
    setState(() {
      endDate = date;
      calculateDuration();
    });
  }

  void onDurationTypeChanged(String type) {
    setState(() {
      leaveType = type;
      if (type == 'Half Day' && startDate != null) {
        endDate = startDate; // Set end date to start date for half day
      }
      calculateDuration();
    });
  }

  void _handleAttachment() {
    // Placeholder for attachment functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attachment feature coming soon')),
    );
  }

  void _submitLeaveRequest() {
    // Placeholder for submitting the leave request
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Leave request submitted successfully'),
        backgroundColor: Colors.green,
      ),
    );
    // Here you would typically send the data to your backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave Management",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeaveTypeSelector(
              leaveTypes: leaveTypes,
              onLeaveTypeSelected: updateSelectedLeaveType,
              selectedType: selectedLeaveType,
            ),
            Divider(),
            if (selectedLeaveType != null) leaveRequestForm(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LeaveSubmitButton(
                isEnabled:
                    leaveDuration > 0 && reasonController.text.isNotEmpty,
                onPressed: _submitLeaveRequest,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget leaveRequestForm() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leave balance indicator
          LeaveBalanceDisplay(leaveType: selectedLeaveType!),
          SizedBox(height: 20),

          // Leave duration type selector (Full/Half day)
          LeaveDurationType(
            selectedType: leaveType,
            onTypeChanged: onDurationTypeChanged,
          ),
          SizedBox(height: 16),

          // Date selection
          LeaveDateSelector(
            startDate: startDate,
            endDate: endDate,
            durationType: leaveType,
            onStartDateChanged: onStartDateChanged,
            onEndDateChanged: onEndDateChanged,
          ),
          SizedBox(height: 16),

          // Leave duration indicator
          LeaveDurationIndicator(
            duration: leaveDuration,
            durationType: leaveType,
          ),
          SizedBox(height: 20),

          // Reason field
          LeaveReasonField(controller: reasonController),
          SizedBox(height: 20),

          // Attachment field
          LeaveAttachmentField(
            attachmentPath: attachmentPath,
            onTap: _handleAttachment,
          ),
        ],
      ),
    );
  }
}
