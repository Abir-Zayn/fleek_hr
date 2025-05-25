import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class CheckInCard extends StatelessWidget {
  final String headingText;
  final String timeText;
  final String statusText;
  final IconData? icon;
  const CheckInCard(
      {super.key,
      required this.headingText,
      required this.timeText,
      required this.statusText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Manadatory required properties
      //logo, check in text in a row
      //check in time
      //on time text .
      padding: const EdgeInsets.all(16.0),
      //decorate the card
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.blue, size: 20),
              ),
              SizedBox(width: 10),
              AppTextstyle(
                text: headingText,
                style: appStyle(
                    size: 20,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          AppTextstyle(
            text: timeText,
            style: appStyle(
                size: 15,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          AppTextstyle(
            text: statusText,
            style: appStyle(
                size: 15,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
