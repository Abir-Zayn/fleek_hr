part of 'leave_request_imports.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  List<LeaveType> leaveTypes = [];
  LeaveType? selectedLeaveType;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave Management",
      ),
      body: Column(
        //dynamic leave buttons
        children: [
          LeaveTypeSelector(leaveTypes: leaveTypes),
          Divider(),
        ],
      ),
    );
  }
}
