import 'package:fleekhr/common/widgets/app_bar.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/calendarpage.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/requestcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FleekAppBar(
            backgroundColor: Theme.of(context).primaryColor, title: "Request"),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30.h,
            ),
            AppTextstyle(
              text: "Need a Request to be made?",
              style: appStyle(
                  size: 18.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            _buildRequestDashBoard(context),
            SizedBox(
              height: 20.h,
            ),
            AppTextstyle(
              text: "Calendar",
              style: appStyle(
                  size: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Calendar widget can be added here
            Calendarpage(),
          ]),
        ));
  }

  Widget _buildRequestDashBoard(BuildContext context) {
    final List<Map<String, dynamic>> reqList = [
      {'icon': Icons.laptop, 'text': "WFH Request", 'color': Colors.blue},
      {
        'icon': Icons.door_back_door_outlined,
        'text': "Leave Request",
        'color': Colors.pink
      },
      {
        'icon': Icons.shopping_bag,
        'text': "Expense Request",
        'color': Colors.teal
      }
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemCount: reqList.length,
          itemBuilder: (context, index) {
            return Requestcard(
              icon: reqList[index]['icon'],
              text: reqList[index]['text'],
              iconColor: reqList[index]['color'],
              onTap: () {
                // Handle the tap event here
                // You can navigate to a new page or perform any action you want
                reqList[index]['text'] == "WFH Request"
                    ? context.push('/workfromhome')
                    : reqList[index]['text'] == 'Leave Request'
                        ? context.push('/leave-history')
                        : reqList[index]['text'] == 'Expense Request'
                            ? context.push('/expense')
                            : () {};
              },
            );
          }),
    );
  }
}
