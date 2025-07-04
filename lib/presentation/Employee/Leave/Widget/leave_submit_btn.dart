import 'package:flutter/material.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';

class LeaveSubmitButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const LeaveSubmitButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: AppTextstyle(
        text: 'Submit Leave Request',
        style: appStyle(
            color: Colors.white, size: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
