import 'dart:async';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInTab extends StatefulWidget {
  const CheckInTab({super.key});

  @override
  State<CheckInTab> createState() => _CheckInTabState();
}

class _CheckInTabState extends State<CheckInTab> {
  DateTime? checkInTime;
  DateTime? checkOutTime;
  DateTime currentTime = DateTime.now(); // Initialize directly
  Timer? timer; // Make timer nullable to handle disposal safely

  @override
  void initState() {
    super.initState();
    // Start timer to update current time every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _handleCheckInOut() {
    setState(() {
      if (checkInTime == null) {
        checkInTime = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Checked In')),
        );
      } else {
        checkOutTime = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Checked Out'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Date display
            AppTextstyle(
              text: DateFormat('EEEE, MMMM d').format(currentTime),
              style: appStyle(
                size: 25,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Live time display
            AppTextstyle(
              text:
                  '${DateFormat('HH:mm').format(currentTime)} ${DateFormat('a').format(currentTime)}',
              style: appStyle(
                size: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Check-in time display (visible only after check-in)
            if (checkInTime != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Check-in time: ${DateFormat('hh:mm a').format(checkInTime!)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            // Circular check-in/out button
            ElevatedButton(
              onPressed: _handleCheckInOut,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(100),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(
                checkInTime == null ? 'Check In' : 'Check Out',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
