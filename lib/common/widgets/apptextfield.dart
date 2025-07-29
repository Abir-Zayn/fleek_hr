import 'package:flutter/material.dart';

class Apptextfield extends StatefulWidget {
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
  final double? inputHeight;
  final EdgeInsets? innerPadding;
  final bool expandContent;
  final bool isPassword;
  final Widget? suffixIcon;

  const Apptextfield({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 8.0,
    this.borderSide = const BorderSide(width: 1.0, color: Colors.grey),
    this.width = double.infinity,
    this.height = 80.0,
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
    this.inputHeight,
    this.innerPadding,
    this.expandContent = false,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  State<Apptextfield> createState() => _ApptextfieldState();
}

class _ApptextfieldState extends State<Apptextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    // Define a consistent text style for the field
    final TextStyle defaultStyle = TextStyle(
      fontSize: 16.0,
      color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87,
    );

    // Ensure consistent font sizes across all text styles
    final TextStyle fieldStyle = widget.style ?? defaultStyle;
    final TextStyle fieldLabelStyle =
        widget.labelStyle ?? defaultStyle.copyWith(color: Colors.grey[600]);
    final TextStyle fieldHintStyle =
        widget.hintStyle ?? defaultStyle.copyWith(color: Colors.grey);
    final TextStyle fieldErrorStyle = widget.errorStyle ??
        defaultStyle.copyWith(color: Colors.red, fontSize: 12.0);

    // Calculate content padding based on input height or custom padding
    final EdgeInsetsGeometry effectiveContentPadding = widget.contentPadding ??
        widget.innerPadding ??
        EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        );

    return SizedBox(
      width: widget.width,
      height: widget.expandContent ? null : widget.height,
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        maxLines: widget.expandContent ? null : widget.maxLines,
        minLines: widget.minLines,
        style: fieldStyle,
        validator: widget.validator,
        expands: widget.expandContent,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelStyle: fieldLabelStyle,
          hintStyle: fieldHintStyle,
          errorStyle: fieldErrorStyle,
          contentPadding: effectiveContentPadding,
          prefixIcon: widget.leadingIcon,
          isDense: widget.inputHeight != null,
          isCollapsed: widget.inputHeight != null,
          // Add suffix icon for password toggle if isPassword is true, or custom suffix
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: widget.borderSide,
          ),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: Colors.red),
              ),
          focusedErrorBorder: widget.focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
        ),
      ),
    );
  }
}
