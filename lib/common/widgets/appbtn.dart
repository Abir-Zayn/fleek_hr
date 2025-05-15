import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Appbtn extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final double radius;
  final Color textColor;
  final double fontSize;
  final IconData? icon;
  final bool isIconLeading;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onPressed;
  const Appbtn({
    super.key,
    required this.text,
    required this.color,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 8,
    this.textColor = const Color(0xFFFFD600),
    this.fontSize = 16,
    this.icon,
    this.isIconLeading = true,
    this.iconColor,
    this.iconSize,
    this.onPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isIconLeading) ...[
              Icon(
                icon,
                color: iconColor ?? Colors.black,
                size: iconSize ?? 20.sp,
              ),
              SizedBox(width: 8.w),
            ],
            AppTextstyle(
              text: text,
              style: appStyle(
                size: fontSize.sp,
                color: textColor,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            if (icon != null && !isIconLeading) ...[
              SizedBox(width: 8.w),
              Icon(
                icon,
                color: iconColor ?? Colors.yellow.shade700,
                size: iconSize ?? 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
