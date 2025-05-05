import 'package:fleekhr/common/utils/src_link/appvectors.dart';
import 'package:fleekhr/common/widgets/appSearchBar.dart';
import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Home/Widget/activitydataform.dart';
import 'package:fleekhr/presentation/Home/Widget/attendance.dart';
import 'package:fleekhr/presentation/Home/Widget/daily_activities_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.h),
                //Search Bar
                //Search Bar is used to search for any data in the app
                SearchBarTextField(
                  hintText: "Enter your query",
                  suffixIcon: Icon(CupertinoIcons.search),
                  onTap: () {},
                ),
                SizedBox(height: 20.h),
                //Profile Card
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: profileCard()),
                SizedBox(height: 30.h),

                AppTextstyle(
                  text: "Yunus's Statistics",
                  style: appStyle(
                      size: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),

                //Dashboard UI
                //Dashboard UI represent the following data
                // 1. Daily Activities
                // 2. attendence of current month
                // 3. Work from Home Request
                // 4. Leave Request
                buildDashBoardLayOut(context),

                SizedBox(height: 20.h),
                AppTextstyle(
                  text: "Attendance",
                  style: appStyle(
                      size: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),

                Attendance(),

                SizedBox(height: 10.h),
                AppTextstyle(
                  text: "Daily Activities",
                  style: appStyle(
                      size: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
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
              ],
            ),
          ),
        ),
      ),

      //Clicking on Floating Action button will open up the add activity form
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
        backgroundColor: Colors.blue.shade900,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  //Helper Method to build the dashboard layout
  Widget buildDashBoardLayOut(BuildContext context) {
    //Dashboard Data
    final List<Map<String, String>> dashboardItems = [
      {"heading": "Daily Activities", "value": "5"},
      {"heading": "Attendence", "value": "20"},
      {"heading": "WFH Request", "value": "2"},
      {"heading": "Leave Request", "value": "3"},
      // Add more items as needed
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GridView.builder(
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
      ),
    );
  }

  Widget detailsMinimalist(
    String heading,
    String txt,
  ) {
    //
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            //Circle Avatar
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
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.h),
                  AppTextstyle(
                    text: txt,
                    style: appStyle(
                      size: 13.sp,
                      color: Colors.black,
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
              //Welcome Text
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
