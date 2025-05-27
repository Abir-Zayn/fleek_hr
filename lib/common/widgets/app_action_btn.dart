import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppActionBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double elevation;
  final Color borderColor;

  const AppActionBtn({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    this.iconSize = 16.0,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        );
    final double effectiveFontSize = fontSize ?? 12.0; // Or 12.sp;

    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: elevation,
        padding: effectivePadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        side: BorderSide(
          color: borderColor,
          width: 1.0,
        ),
      ),
      icon: Icon(icon, size: iconSize),
      label: AppTextstyle(
        text: label,
        style: appStyle(
          size: effectiveFontSize,
          fontWeight: fontWeight!,
          color: textColor,
        ),
      ),
    );
  }
}
