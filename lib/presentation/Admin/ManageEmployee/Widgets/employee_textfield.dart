import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeTextfield extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isObscure;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  const EmployeeTextfield(
      {super.key,
      required this.labelText,
      this.hintText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.isObscure = false,
      this.prefixIcon,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: appStyle(
                size: 14.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.w500),
            labelStyle: appStyle(
                size: 12.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.w500),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 12.h, horizontal: 12.w) // Adjust padding here
            ),
        validator: validator,
      ),
    );
  }
}
