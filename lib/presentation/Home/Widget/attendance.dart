import 'dart:async';

import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  double _progress = 0.0;
  Timer? timer;
  bool _isLongPressing = false;

  void _startProgress() {
    setState(() {
      _isLongPressing = true;
      _progress = 0.0;
    });

    timer = Timer.periodic(Duration(microseconds: 50), (t) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 100.0) {
          // Check if progress is 100%
          _progress = 100.0;
          t.cancel();

          showSnackBar(
              message: "Congrats! You have attended to office.",
              bgCol: Colors.green);
        }
      });
    });
  }

  void _stopProgress() {
    if (_isLongPressing) {
      timer?.cancel();
      setState(() {
        _isLongPressing = false;
      });

      if (_progress < 100.0) {
        showSnackBar(
          message: "OOPS! Present sheet hasn't updated",
          bgCol: Colors.red,
        );
      }
    }
  }

  void showSnackBar({required String message, required Color bgCol}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextstyle(
            text: message,
            style: appStyle(
                size: 12.sp, color: Colors.white, fontWeight: FontWeight.w400)),
        backgroundColor: bgCol,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onLongPressStart: (_) => _startProgress(),
        onLongPressEnd: (_) => _stopProgress(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background circle with dynamic green fill
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            // Green fill based on progress
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(_progress / 100),
              ),
            ),
            // Text
            AppTextstyle(
              text: _isLongPressing ? '${_progress.toInt()}%' : 'Check In',
              textAlign: TextAlign.center,
              style: appStyle(
                size: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
