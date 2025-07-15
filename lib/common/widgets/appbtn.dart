import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class Appbtn extends StatelessWidget {
  final String text;
  final Color bgColor;
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
    required this.bgColor,
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
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null ? bgColor : Colors.grey.shade300,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isIconLeading) ...[
              Icon(
                icon,
                color: onPressed != null
                    ? (iconColor ?? Colors.black)
                    : Colors.grey.shade500,
                size: iconSize ?? 20,
              ),
              SizedBox(width: 8),
            ],
            AppTextstyle(
              text: text,
              style: appStyle(
                size: fontSize,
                color: onPressed != null ? textColor : Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            if (icon != null && !isIconLeading) ...[
              SizedBox(width: 8),
              Icon(
                icon,
                color: onPressed != null
                    ? (iconColor ?? Colors.yellow.shade700)
                    : Colors.grey.shade500,
                size: iconSize ?? 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
