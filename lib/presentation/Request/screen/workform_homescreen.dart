import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:fleekhr/presentation/Request/widget/DateRangetop_bar.dart';
import 'package:fleekhr/presentation/Request/widget/calendarpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkformHomescreen extends StatefulWidget {
  const WorkformHomescreen({super.key});

  @override
  State<WorkformHomescreen> createState() => _WorkformHomescreenState();
}

class _WorkformHomescreenState extends State<WorkformHomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AppTextstyle(
          text: "WFH Request",
          style: appStyle(
              size: 20.sp, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),

              //Row widget to display from --- days --- To
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DaterangetopBar(
                        startDate: DateTime.now(),
                        TopHead: "Starting From",
                      ),
                      //TODO: Modify here
                      DaterangetopBar(
                        startDate: DateTime.now(),
                        TopHead: "Total Days",
                      ),
                      DaterangetopBar(
                        startDate: DateTime.now(),
                        TopHead: "Ending At",
                      ),
                    ]),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 320.h,
                child: Calendarpage(
                  isRange: true,
                  onRangeDateSelected: (p0, p1) => {},
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      "Add Reason",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Apptextfield(
                  height: 100.h,
                  width: MediaQuery.of(context).size.width * 0.9,
                  borderRadius: 10,
                  contentPadding: EdgeInsets.all(30.0),
                  hintText: "Describe your reason",
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Appbtn(
                  text: "Submit",
                  color: Colors.blue.shade900,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50.h,
                  radius: 10,
                  fontSize: 18.sp,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
