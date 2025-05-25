part of 'admin_home_imports.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String _status = "Swipe to mark attendance";

  void _handleAttendanceMarked() {
    setState(() {
      _status = "Attendance successfully marked!";
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
    //Sample demo data for the dashboard cards
    final List<Map<String, dynamic>> dashboardData = [
      {
        'title': 'Active Employee',
        'count': '4 users',
        'icon': Icons.person,
        'color': Colors.teal.shade100,
        'page': '/activeEmployees'
      },
      {
        'title': 'Pending Requests',
        'count': '2 requests',
        'icon': Icons.pending,
        'color': Colors.orange.shade300,
        'page': '/pendingRequests'
      },
      {
        'title': 'Work From Home',
        'count': '8 Requests',
        'icon': Icons.home_work_outlined,
        'color': Colors.green.shade100,
        'page': '/wfh-requests'
      },
      {
        'title': 'Today Present',
        'count': '130 Employees',
        'icon': Icons.person_4_sharp,
        'color': Colors.lightBlue.shade300,
        'page': '/today-present'
      },
      {
        'title': 'Loan Requests',
        'count': '3 Pending',
        'icon': Icons.monetization_on_outlined,
        'color': Colors.purple.shade100,
        'page': '/loan-requests'
      },
      {
        'title': 'Today Absent',
        'count': '20 Employees',
        'icon': Icons.person_off_outlined,
        'color': Colors.red.shade200,
        'page': '/today-absent'
      },
      {
        'title': 'Advance',
        'count': '5 Requests',
        'icon': Icons.request_quote_outlined,
        'color': Colors.indigo.shade300,
        'page': '/advance-requests'
      }
    ];

    //sample demo data for daily activities
    // Sample data for daily activities
    final List<Map<String, dynamic>> dailyActivities = [
      {
        'taskName': 'Mobile Application Design',
        'assignedTo': 'Assigned to Alex & Jordan',
        'completionDate': 'June 25, 2025',
        'progress': 0.75,
        'progressColor': Colors.blueAccent,
      },
      {
        'taskName': 'Dashboard UI Design',
        'assignedTo': 'Completed by Sarah',
        'completionDate': 'June 20, 2025',
        'progress': 1.0,
        'progressColor': Colors.green,
      },
      {
        'taskName': 'API Integration Testing',
        'assignedTo': 'Pending - Mark',
        'completionDate': 'June 28, 2025',
        'progress': 0.3,
        'progressColor': Colors.orangeAccent,
      },
    ];

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
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).textTheme.bodyMedium?.color ??
                            Colors.black,
                      ),
                      onPressed: () {
                        //handle menu button press
                        //show a drop down menu and upon clicking on the item
                        // it will navigate to the respective page
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(100, 100, 0, 0),
                          items: [
                            PopupMenuItem(
                              child: Text('Manage Employees',
                                  style: appStyle(
                                      size: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              onTap: () {
                                //Manage Employees Page
                                context.push('/manage-employees');
                              },
                            ),
                            PopupMenuItem(
                              child: Text('Work From Home Requests',
                                  style: appStyle(
                                      size: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              onTap: () {
                                Navigator.pushNamed(context, '/wfh-requests');
                              },
                            ),
                          ],
                        );
                      },
                    ),
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
              // User ID Card
              UserIdCard(
                  division: "Engineering",
                  joinedDate: "16-06-2025",
                  totalPresentDays: 20,
                  lateDays: 5,
                  absentDays: 7),
              SizedBox(height: 20.h),
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
              // Horizontal Scrollable Dashboard Cards
              SizedBox(
                height: 380, // Increased height to accommodate two rows
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two cards vertically
                      crossAxisSpacing: 25.0,
                      mainAxisSpacing: 40.0,
                      childAspectRatio:
                          1 // Adjust based on your card dimensions
                      ),
                  itemCount: dashboardData.length,
                  itemBuilder: (context, index) {
                    final item = dashboardData[index];
                    return DashboardCard(
                      title: item['title'],
                      count: item['count'],
                      icon: item['icon'],
                      iconColor:
                          Theme.of(context).textTheme.bodyMedium?.color ??
                              Colors.black,
                      color: item['color'],
                      onTap: () {},
                    );
                  },
                ),
              ),
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
                      icon: Icons.arrow_back_ios,
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
                      // Handle "View All" or filter for daily activities
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
                    progressColor: activity['progressColor'],
                  );
                },
              ),
            ],
          ),
        ));
  }
}
