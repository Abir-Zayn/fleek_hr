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
              // User ID Card
              UserIdCard(
                  division: "Engineering",
                  joinedDate: "16-06-2025",
                  totalPresentDays: 20,
                  lateDays: 5,
                  absentDays: 7),
              SizedBox(height: 20),

              SizedBox(height: 20),

              // Attendance Slider
              AttendanceSlider(
                onAttendanceMarked: _handleAttendanceMarked,
                instructionText: 'Swipe to Check In',
                iconColor: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.white,
                textColor: Colors.white,
              ),

              SizedBox(height: 20),

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
                  SizedBox(width: 20), // Spacing between cards
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
