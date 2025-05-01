import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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

               //Search Bar 
                //Search Bar is used to search for any data in the app
                



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
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
