import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Leave/Widget/leaveFormDialog.dart';

import 'package:fleekhr/presentation/Request/widget/statuscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnualleavePage extends StatelessWidget {
  const AnnualleavePage({super.key});

  @override
  Widget build(BuildContext context) {
    void showFormDialog() {
      final activityDialog = LeaveFormDialog(
        context: context,
        onSubmitSuccess: () {},
      );
      activityDialog.show();
    }

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
          text: "Leave Request",
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
                //Text : Total Number of Leaves you can have
                // table with 3x3 columns

                SizedBox(
                  height: 40.h,
                ),
                //Table
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                    },
                    textDirection: TextDirection.ltr,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Leave Type",
                                style: appStyle(
                                    size: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Used",
                                style: appStyle(
                                    size: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Total Leave",
                                style: appStyle(
                                    size: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Annual Leave",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "0 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "12 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Leave Without Pay",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "0 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "12 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "Casual Leave",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "0 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Center(
                              child: AppTextstyle(
                                text: "12 Days",
                                style: appStyle(
                                    size: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppTextstyle(
                  text: "All Leave History",
                  style: appStyle(
                      size: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),

                SizedBox(
                  height: 20.h,
                ),
                //List of leave history
                Statuscard(
                    title: "Maternity Leave",
                    subtitle: "5 days",
                    date: "12/10/2025",
                    status: "pending"),
                SizedBox(
                  height: 10,
                ),
                Statuscard(
                  title: "Annual Leave",
                  subtitle: "5 days",
                  date: "12/10/2025",
                  status: "approved",
                  gradientColors: [
                    Colors.green.shade500,
                    Colors.green.shade200,
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Statuscard(
                  title: "Annual Leave",
                  subtitle: "5 days",
                  date: "12/10/2025",
                  status: "rejected",
                  gradientColors: [
                    Colors.red.shade500,
                    Colors.red.shade200,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: AppTextstyle(
              text: "Request",
              style: appStyle(
                size: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
          backgroundColor: Colors.blue.shade900,
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showFormDialog();
          }),
    );
  }
}
