part of 'home_screen_imports.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String status = "Swipe to mark attendance";

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
  }

  @override
  void dispose() {
    // Dispose of any controllers or resources if needed
    super.dispose();
  }

  void _handleAttendanceMarked() {
    setState(() {
      status = "Attendance successfully marked!";
    });
    // You can add further logic here, like sending data to a server
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance Recorded!'),
        backgroundColor: Colors.green,
      ),
    );
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

        'status': 'pending', // Add status
      },
      {
        'taskName': 'Dashboard UI Design',
        'assignedTo': 'Completed by Sarah',
        'completionDate': 'June 20, 2025',
        'progress': 1.0,

        'status': 'accepted', // Add status
      },
      {
        'taskName': 'API Integration Testing',
        'assignedTo': 'Pending - Mark',
        'completionDate': 'June 28, 2025',
        'progress': 0.3,

        'status': 'pending', // Add status
      },
      // Add more sample data as needed
    ];

    void handleActivity(int index, String action) {
      setState(() {
        dailyActivities[index]['status'] = action;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Activity $action successfully!'),
            backgroundColor:
                action == 'accepted' ? Colors.green : Colors.orange),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.h),
          child: AppBar(
            //hide the lead icon
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0.w, top: 30.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextstyle(
                          text: 'Good Morning!',
                          style: appStyle(
                              size: 20.sp,
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
                              size: 32.sp,
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
                      size: 15.sp,
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
                    size: 15.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              // User ID Card
              UserIdCard(
                  division: "Engineering",
                  joinedDate: "16-06-2025",
                  totalPresentDays: 20,
                  lateDays: 5,
                  absentDays: 7),
              SizedBox(height: 20.h),

              SizedBox(height: 20.h),

              // Attendance Slider
              AttendanceSlider(
                onAttendanceMarked: _handleAttendanceMarked,
                instructionText: 'Swipe to Check In',
                successText: 'Sucessfully Checked In',
                iconColor: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.white,
                textColor: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.white,
                sliderColor: Theme.of(context).primaryColor,
              ),

              SizedBox(height: 20.h),

              //Check in and Check out card
              Row(
                children: [
                  Expanded(
                    child: CheckInCard(
                        headingText: 'Check In',
                        timeText: '9:00 AM',
                        statusText: 'On Time',
                        icon: Icons.arrow_forward_ios_rounded),
                  ),
                  SizedBox(width: 20.w), // Spacing between cards
                  Expanded(
                    child: CheckInCard(
                      headingText: 'Check Out',
                      timeText: '5:00 PM',
                      statusText: 'On Time',
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  ),
                ],
              ),

              // Daily Activities Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Daily Activities',
                      style: appStyle(
                          size: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: () {
                      context.push('/dailyactivities',
                          extra: true); // Navigate to all tasks page
                    },
                    child: Text('All Tasks', // As per UI image
                        style: appStyle(
                            size: 15.sp,
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
                    progress: activity['progress'],

                    isAdmin: true, // Assuming admin view for this example
                    status: activity['status'],
                    onAccept: () => handleActivity(index, 'accepted'),
                    onReject: () => handleActivity(index, 'rejected'),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
