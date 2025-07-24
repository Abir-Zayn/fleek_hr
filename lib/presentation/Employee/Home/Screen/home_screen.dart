part of 'home_screen_imports.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load today's attendance when screen initializes
    context.read<AttendanceCubit>().loadTodayAttendance();
  }

  void _handleAttendanceAction() {
    final attendanceCubit = context.read<AttendanceCubit>();
    
    // Check if user can check in or check out
    if (attendanceCubit.canCheckIn()) {
      attendanceCubit.checkIn();
    } else if (attendanceCubit.canCheckOut()) {
      attendanceCubit.checkOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    //sample demo data for daily activities
    // Sample data for daily activities
    final List<Map<String, dynamic>> dailyActivities = [
      {
        'taskName': 'Mobile Application Design',
        'assignedTo': 'Assigned to Alex & Jordan',
        'completionDate': 'June 25, 2025',
        'progress': 0.75,
        'startedAt': 'June 1, 2025',
        'status': 'pending', // Add status
      },
      {
        'taskName': 'Dashboard UI Design',
        'assignedTo': 'Completed by Sarah',
        'completionDate': 'June 20, 2025',
        'progress': 1.0,
        'startedAt': 'June 5, 2025',
        'status': 'accepted', // Add status
      },
      {
        'taskName': 'API Integration Testing',
        'assignedTo': 'Pending - Mark',
        'completionDate': 'June 28, 2025',
        'progress': 0.3,
        'startedAt': 'June 10, 2025',
        'status': 'pending', // Add status
      },
      // Add more sample data as needed
    ];

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            //hide the lead icon
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextstyle(
                          text: 'Good Morning!',
                          style: appStyle(
                              size: 20,
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color ??
                                  Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        AppTextstyle(
                          text: 'Hi! Admin',
                          style: appStyle(
                              size: 32,
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color ??
                                  Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    const SizedBox(width: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: appStyle(
                      size: 15,
                      color: Theme.of(context).textTheme.bodyMedium?.color ??
                          Colors.black,
                      fontWeight: FontWeight.w400),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: appStyle(
                    size: 15,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              
              // User ID Card with real attendance data
              BlocBuilder<AttendanceCubit, AttendanceState>(
                builder: (context, state) {
                  int presentDays = 0;
                  int lateDays = 0;
                  int absentDays = 0;
                  
                  if (state is AttendanceDashboardLoaded) {
                    presentDays = state.monthlyPresentDays;
                    lateDays = state.monthlyLateDays;
                    absentDays = state.monthlyAbsentDays;
                  }
                  
                  return UserIdCard(
                    division: "Engineering",
                    joinedDate: "16-06-2025",
                    totalPresentDays: presentDays,
                    lateDays: lateDays,
                    absentDays: absentDays,
                  );
                },
              ),
              
              SizedBox(height: 20),

              // Attendance Slider with BlocListener for feedback
              BlocListener<AttendanceCubit, AttendanceState>(
                listener: (context, state) {
                  if (state is CheckInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully checked in!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is CheckOutSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully checked out!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else if (state is AttendanceError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<AttendanceCubit, AttendanceState>(
                  builder: (context, state) {
                    String instructionText = 'Swipe to Check In';
                    bool canPerformAction = true;
                    
                    if (state is AttendanceProcessing) {
                      instructionText = 'Processing...';
                      canPerformAction = false;
                    } else {
                      final attendanceCubit = context.read<AttendanceCubit>();
                      if (attendanceCubit.canCheckOut()) {
                        instructionText = 'Swipe to Check Out';
                      } else if (!attendanceCubit.canCheckIn()) {
                        instructionText = 'Day Completed';
                        canPerformAction = false;
                      }
                    }
                    
                    return AttendanceSlider(
                      onAttendanceMarked: canPerformAction ? _handleAttendanceAction : () {},
                      instructionText: instructionText,
                      iconColor: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                      textColor: Colors.white,
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // Check in and Check out cards with real data
              BlocBuilder<AttendanceCubit, AttendanceState>(
                builder: (context, state) {
                  String checkInTime = 'Not checked in';
                  String checkInStatus = 'Pending';
                  String checkOutTime = 'Not checked out';
                  String checkOutStatus = 'Pending';
                  
                  final attendanceCubit = context.read<AttendanceCubit>();
                  final todayAttendance = attendanceCubit.todayAttendance;
                  
                  if (todayAttendance != null) {
                    // Check-in data
                    if (todayAttendance.hasCheckedIn) {
                      checkInTime = DateFormat('h:mm a').format(todayAttendance.checkIn!);
                      checkInStatus = todayAttendance.isLate ? 'Late' : 'On Time';
                    }
                    
                    // Check-out data
                    if (todayAttendance.hasCheckedOut) {
                      checkOutTime = DateFormat('h:mm a').format(todayAttendance.checkOut!);
                      checkOutStatus = todayAttendance.leftEarly ? 'Left Early' : 'On Time';
                    }
                  }
                  
                  return Row(
                    children: [
                      Expanded(
                        child: CheckInCard(
                          headingText: 'Check In',
                          timeText: checkInTime,
                          statusText: checkInStatus,
                          icon: Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CheckInCard(
                          headingText: 'Check Out',
                          timeText: checkOutTime,
                          statusText: checkOutStatus,
                          icon: Icons.arrow_back_ios_rounded,
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Daily Activities Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Daily Activities',
                      style: appStyle(
                          size: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: () {
                      context.push('/dailyactivities',
                          extra: true); // Navigate to all tasks page
                    },
                    child: Text('All Tasks', // As per UI image
                        style: appStyle(
                            size: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap:
                    true, // Important for ListView inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Also important
                itemCount: dailyActivities.length,
                itemBuilder: (context, index) {
                  final activity = dailyActivities[index];
                  return DailyActivitiesCard(
                    taskName: activity['taskName'],
                    assignedTo: activity['assignedTo'],
                    completionDate: activity['completionDate'],
                    // Assuming admin view for this example
                    status: activity['status'],
                    startedAt: activity['startedAt'],
                  );
                },
              ),
            ],
          ),
        ));
  }
}
