part of 'homepage_imports.dart';

// This is the main homepage of the app
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _showFormDialog() {
    final activityDialog = ActivityFormDialog(
      context: context,
      onSubmitSuccess: () {},
    );
    activityDialog.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.h),

                // Search Bar
                SearchBarTextField(
                  hintText: "Enter your query",
                  suffixIcon: Icon(CupertinoIcons.search),
                  onTap: () {},
                ),

                SizedBox(height: 20.h),

                // Profile Card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: profileCard(),
                ),

                SizedBox(height: 30.h),

                AppTextstyle(
                  text: "Yunus's Statistics",
                  style: appStyle(
                    size: 20.sp,
                    color: Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 10.h),
              ]),
            ),
          ),

          // Dashboard UI Grid
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverToBoxAdapter(
              child: buildDashBoardLayOut(context),
            ),
          ),

          // Attendance Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20.h),
                AppTextstyle(
                  text: "Attendance",
                  style: appStyle(
                    size: 20.sp,
                    color: Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Attendance(),
              ]),
            ),
          ),

          // Daily Activities Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.h),
                AppTextstyle(
                  text: "Daily Activities",
                  style: appStyle(
                    size: 15.sp,
                    color: Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 10.h),

                DailyActivitiesCard(
                  taskTitle: "Data Entry",
                  completionPercentage: "75%",
                  taskDate: "April 30, 2025",
                  status: TaskStatus.onProgress,
                ),

                DailyActivitiesCard(
                  taskTitle: "UI Design",
                  completionPercentage: "100%",
                  taskDate: "April 30, 2025",
                  status: TaskStatus.completed,
                ),

                DailyActivitiesCard(
                  taskTitle: "Code Review",
                  completionPercentage: "50%",
                  taskDate: "April 30, 2025",
                  status: TaskStatus.cancelled,
                ),

                // Add space at the bottom to avoid FAB overlap
                SizedBox(height: 80.h),
              ]),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showFormDialog();
        },
        icon: const Icon(Icons.add, color: Colors.white, size: 24),
        label: Text(
          "Add",
          style: appStyle(
              size: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Helper Method to build the dashboard layout
  Widget buildDashBoardLayOut(BuildContext context) {
    // Dashboard Data
    final List<Map<String, String>> dashboardItems = [
      {"heading": "Daily Activities", "value": "5"},
      {"heading": "Attendence", "value": "20"},
      {"heading": "WFH Request", "value": "2"},
      {"heading": "Leave Request", "value": "3"},
      // Add more items as needed
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1.5,
      ),
      itemCount: dashboardItems.length,
      itemBuilder: (context, index) {
        return detailsMinimalist(
          dashboardItems[index]["heading"]!,
          dashboardItems[index]["value"]!,
        );
      },
    );
  }

  Widget detailsMinimalist(
    String heading,
    String txt,
  ) {
    return Card(
      color: Theme.of(context).cardTheme.color ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Circle Avatar
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.circle,
                color: Colors.green,
                size: 30,
              ),
            ),
            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: heading,
                    style: appStyle(
                      size: 15.sp,
                      color: Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.h),
                  AppTextstyle(
                    text: txt,
                    style: appStyle(
                      size: 20.sp,
                      color: Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Card
  Widget profileCard() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue.shade600,
          Colors.blue.shade900,
          Colors.deepPurpleAccent.shade400,
        ]),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              // Welcome Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextstyle(
                    text: "Welcome Muhammad Yunus",
                    style: appStyle(
                        size: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextstyle(
                    text: "Here is whats happening in your\naccount today.",
                    style: appStyle(
                        size: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Appbtn(
                    height: 50.h,
                    width: 150.w,
                    text: "Explore Now",
                    color: Colors.transparent,
                    textColor: Colors.white,
                    radius: 10,
                    onPressed: () {},
                  )
                ],
              ),

              Positioned(
                top: 50.h,
                right: 10.w,
                child: Image.asset(
                  Appvectors.homeProfileImg,
                  height: 140.h,
                  width: 140.w,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )),
    );
  }
}
