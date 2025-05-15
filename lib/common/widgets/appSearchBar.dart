import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarTextField extends StatelessWidget {
  final String? hintText;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? initialValue;

  const SearchBarTextField({
    super.key,
    this.hintText,
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
          size: 13.sp,
          color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.black,
          fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(10),
        hintStyle: appStyle(
            size: 14.sp,
            color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.black,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  Theme.of(context).textTheme.bodySmall?.color ?? Colors.black,
              width: 0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }
}
