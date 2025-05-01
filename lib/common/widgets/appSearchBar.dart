import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? initialValue;

  const SearchBarTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onTap,
    this.controller,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      textInputAction: TextInputAction.next,
      onEditingComplete: onTap,
      keyboardType: keyboardType,
      controller: controller,
      validator: (initialValue) {
        if (initialValue == null || initialValue.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
      style: appStyle(
          size: 13.sp, color: Colors.black, fontWeight: FontWeight.normal),
          
    );
  }
}
