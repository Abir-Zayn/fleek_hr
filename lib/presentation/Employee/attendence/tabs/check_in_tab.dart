import 'dart:async';
import 'dart:math';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInTab extends StatefulWidget {
  const CheckInTab({super.key});

  @override
  State<CheckInTab> createState() => _CheckInTabState();
}

class _CheckInTabState extends State<CheckInTab>
    with SingleTickerProviderStateMixin {
  DateTime? checkInTime;
  DateTime? checkOutTime;
  DateTime currentTime = DateTime.now(); // Initialize directly
  Timer? timer; // Make timer nullable to handle disposal safely

  // Animation controller for the circular progress
  late AnimationController progressController;
  bool holdingForCheckInOUT = false;
  double holdingProgression = 0.0;
  final double holdingDuration = 2.5; // Hold duration in seconds

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

    // Initialize the progress controller
    progressController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (holdingDuration * 1000).toInt()),
    )..addListener(() {
        setState(() {
          holdingProgression = progressController.value;
        });

        // Complete the check-in/out when progress reaches 1.0
        if (progressController.value == 1.0) {
          completeCheckInOUT();
        }
      });
  }

  @override
  void dispose() {
    timer?.cancel();
    progressController.dispose();
    super.dispose();
  }

  // Start the hold action and animation
  void holdingStart() {
    setState(() {
      holdingForCheckInOUT = true;
    });
    progressController.forward(from: 0.0);
  }

  // Cancel the hold action
  void holdingStop() {
    setState(() {
      holdingForCheckInOUT = false;
    });
    progressController.reset();
  }

  // Complete check-in/out action when hold is successful
  void completeCheckInOUT() {
    setState(() {
      holdingForCheckInOUT = false;
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
    progressController.reset();
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

            // Custom circular button with progress indicator
            GestureDetector(
              onLongPressStart: (_) => holdingStart(),
              onLongPressEnd: (_) => holdingStop(),
              onLongPressCancel: () => holdingStop(),
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress indicator
                    CustomPaint(
                      size: Size(230, 230),
                      painter: CircularProgressPainter(
                        progress: holdingProgression,
                        progressColor: Theme.of(context).primaryColor,
                        startAngle:
                            -pi / 2, // Start from top (12 o'clock position)
                      ),
                    ),

                    // Button background
                    Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          checkInTime == null
                              ? 'Check In'
                              : 'Check Out',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),        
           
          ],
        ),
      ),
    );
  }
}

// Custom painter for circular progress indicator
class CircularProgressPainter extends CustomPainter {
  final double progress; // Progress value from 0.0 to 1.0
  final Color progressColor;
  final double startAngle; // Starting angle in radians
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    this.startAngle = 0,
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Don't draw anything if progress is 0
    if (progress == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Setup paint for the progress arc
    final paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Calculate the sweep angle based on progress
    final sweepAngle = 2 * pi * progress;

    // Draw the progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor;
  }
}
