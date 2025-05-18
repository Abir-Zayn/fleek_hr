import 'package:flutter/material.dart';

class Apptextfield extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final double borderRadius;
  final BorderSide borderSide;
  final Widget? leadingIcon;
  final double? width;
  final double? height;
  final String? errorText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final VoidCallback? onTap;

  const Apptextfield({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 8.0,
    this.borderSide = const BorderSide(width: 1.0, color: Colors.grey),
    this.width,
    this.height,
    this.errorText,
    this.validator,
    this.leadingIcon,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.contentPadding,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define a consistent text style for the field
    final TextStyle defaultStyle = TextStyle(
      fontSize: 16.0,
      color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87,
    );

    // Ensure consistent font sizes across all text styles
    final TextStyle fieldStyle = style ?? defaultStyle;
    final TextStyle fieldLabelStyle =
        labelStyle ?? defaultStyle.copyWith(color: Colors.grey[600]);
    final TextStyle fieldHintStyle =
        hintStyle ?? defaultStyle.copyWith(color: Colors.grey);
    final TextStyle fieldErrorStyle =
        errorStyle ?? defaultStyle.copyWith(color: Colors.red, fontSize: 12.0);

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: minLines,
        style: fieldStyle,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          labelStyle: fieldLabelStyle,
          hintStyle: fieldHintStyle,
          errorStyle: fieldErrorStyle,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          prefixIcon: leadingIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide,
          ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.red),
              ),
          focusedErrorBorder: focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
        ),
      ),
    );
  }
}
