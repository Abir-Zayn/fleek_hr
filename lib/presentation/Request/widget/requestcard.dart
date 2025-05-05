import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Requestcard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback? onTap;
  const Requestcard(
      {super.key,
      required this.icon,
      required this.text,
      this.iconColor = Colors.black,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 75,
        width: 90,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 5),
              AppTextstyle(
                text: text,
                style: appStyle(
                  size: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
