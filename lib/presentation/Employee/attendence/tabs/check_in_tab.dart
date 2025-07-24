import 'dart:async';
import 'dart:math';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/attendence/cubit/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// Check-In Tab UI Components:
/// - Live date and time display
/// - Circular check-in/out button with hold gesture
/// - Progress indicator animation
/// - Check-in time display after successful check-in
/// - If check-in is already done, it shows check-out option
/// - Snackbar notifications for check-in and check-out actions

class CheckInTab extends StatefulWidget {
  const CheckInTab({super.key});

  @override
  State<CheckInTab> createState() => _CheckInTabState();
}

class _CheckInTabState extends State<CheckInTab>
    with SingleTickerProviderStateMixin {
  DateTime currentTime = DateTime.now(); // Live current time
  Timer? timer; // Timer for live time updates

  // Hold gesture animation variables
  late AnimationController progressController;
  bool holdingForCheckInOUT = false; // Track if user is holding button
  double holdingProgression = 0.0; // Progress of hold gesture (0.0 to 1.0)
  final double holdingDuration = 2.5; // Required hold duration in seconds

  @override
  void initState() {
    super.initState();
    // Load today's attendance data
    context.read<AttendanceCubit>().loadTodayAttendance();
    
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
          _completeCheckInOUT();
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
  void _holdingStart() {
    final attendanceCubit = context.read<AttendanceCubit>();
    
    // Check if action is possible
    if (!attendanceCubit.canCheckIn() && !attendanceCubit.canCheckOut()) {
      return;
    }
    
    setState(() {
      holdingForCheckInOUT = true;
    });
    progressController.forward(from: 0.0);
  }

  // Cancel the hold action
  void _holdingStop() {
    setState(() {
      holdingForCheckInOUT = false;
    });
    progressController.reset();
  }

  // Complete check-in/out action when hold is successful
  void _completeCheckInOUT() {
    setState(() {
      holdingForCheckInOUT = false;
    });
    
    final attendanceCubit = context.read<AttendanceCubit>();
    
    // Perform the appropriate action
    if (attendanceCubit.canCheckIn()) {
      attendanceCubit.checkIn();
    } else if (attendanceCubit.canCheckOut()) {
      attendanceCubit.checkOut();
    }
    
    progressController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is CheckInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully checked in!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is CheckOutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully checked out!'),
                backgroundColor: Colors.blue,
              ),
            );
          } else if (state is AttendanceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            final attendanceCubit = context.read<AttendanceCubit>();
            final todayAttendance = attendanceCubit.todayAttendance;
            
            return Center(
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
                    text: '${DateFormat('HH:mm').format(currentTime)} ${DateFormat('a').format(currentTime)}',
                    style: appStyle(
                      size: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Check-in time display (visible only after check-in)
                  if (todayAttendance?.hasCheckedIn == true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: [
                          Text(
                            'Check-in time: ${DateFormat('hh:mm a').format(todayAttendance!.checkIn!)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          if (todayAttendance.hasCheckedOut)
                            Text(
                              'Check-out time: ${DateFormat('hh:mm a').format(todayAttendance.checkOut!)}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          if (todayAttendance.workDuration != null)
                            Text(
                              'Work duration: ${todayAttendance.workDurationFormatted}',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                        ],
                      ),
                    ),

                  // Status message
                  if (state is AttendanceProcessing)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: CircularProgressIndicator(),
                    ),

                  // Main circular check-in/out button with hold gesture
                  GestureDetector(
                    onLongPressStart: (_) => _holdingStart(),
                    onLongPressEnd: (_) => _holdingStop(),
                    onLongPressCancel: () => _holdingStop(),
                    child: Container(
                      width: 230,
                      height: 230,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Circular progress indicator
                          CustomPaint(
                            size: const Size(230, 230),
                            painter: CircularProgressPainter(
                              progress: holdingProgression,
                              progressColor: Theme.of(context).primaryColor,
                              startAngle: -pi / 2, // Start from top (12 o'clock position)
                            ),
                          ),

                          // Button background
                          Container(
                            width: 210,
                            height: 210,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getButtonColor(attendanceCubit, state),
                            ),
                            child: Center(
                              child: Text(
                                _getButtonText(attendanceCubit, state),
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
                  
                  const SizedBox(height: 20),
                  
                  // Instruction text
                  Text(
                    _getInstructionText(attendanceCubit, state),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  
  Color _getButtonColor(AttendanceCubit cubit, AttendanceState state) {
    if (state is AttendanceProcessing) {
      return Colors.grey;
    }
    if (!cubit.canCheckIn() && !cubit.canCheckOut()) {
      return Colors.green;
    }
    return Theme.of(context).primaryColor;
  }
  
  String _getButtonText(AttendanceCubit cubit, AttendanceState state) {
    if (state is AttendanceProcessing) {
      return 'Processing...';
    }
    if (cubit.canCheckIn()) {
      return 'Check In';
    } else if (cubit.canCheckOut()) {
      return 'Check Out';
    } else {
      return 'Day\nCompleted';
    }
  }
  
  String _getInstructionText(AttendanceCubit cubit, AttendanceState state) {
    if (state is AttendanceProcessing) {
      return 'Please wait...';
    }
    if (cubit.canCheckIn()) {
      return 'Hold the button to check in';
    } else if (cubit.canCheckOut()) {
      return 'Hold the button to check out';
    } else {
      return 'You have completed your day';
    }
  }
}

/// Custom painter for circular progress indicator around check-in button
/// Shows visual feedback during hold gesture
class CircularProgressPainter extends CustomPainter {
  final double progress; // Progress value from 0.0 to 1.0
  final Color progressColor; // Color of progress arc
  final double startAngle; // Starting angle in radians
  final double strokeWidth; // Thickness of progress arc

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

    // Calculate sweep angle based on progress (full circle = 2π)
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
