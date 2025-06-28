import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttendanceSlider extends StatefulWidget {
  final VoidCallback onAttendanceMarked;
  final String instructionText;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color successBackgroundColor;

  const AttendanceSlider({
    super.key,
    required this.onAttendanceMarked,
    this.instructionText = "Swipe right to mark attendance",
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.successBackgroundColor = Colors.green,
  });

  @override
  State<AttendanceSlider> createState() => _AttendanceSliderState();
}

class _AttendanceSliderState extends State<AttendanceSlider>
    with SingleTickerProviderStateMixin {
  double _dragExtent = 0.0;
  bool _isCompleted = false;
  late AnimationController _animationController;

  // Constants
  final double _sliderWidth = 60.0;
  final double _padding = 14.0;
  final double _height = 60.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;

    setState(() {
      _dragExtent += details.delta.dx;
      // Clamp drag extent
      _dragExtent = _dragExtent.clamp(
          0.0, context.size!.width - _sliderWidth - _padding * 2);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isCompleted) return;

    final screenWidth = context.size!.width;
    final threshold = screenWidth * 0.7; // 70% of screen width

    if (_dragExtent > threshold - _sliderWidth) {
      _completeSwipe();
    } else {
      // Reset position if not swiped enough
      setState(() {
        _dragExtent = 0.0;
      });
    }
  }

  void _completeSwipe() {
    setState(() {
      _isCompleted = true;
      _dragExtent = context.size!.width - _sliderWidth - _padding * 2;
    });

    // Call the callback to mark attendance
    widget.onAttendanceMarked();

    // Short delay for visual feedback before navigation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        // Navigate directly to attendance screen
        context.push('/attendance');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _height,
      decoration: BoxDecoration(
        color: _isCompleted
            ? widget.successBackgroundColor
            : widget.backgroundColor,
        borderRadius: BorderRadius.circular(_height / 2),
      ),
      padding: EdgeInsets.all(_padding),
      child: Stack(
        children: [
          // Instruction text or success message
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 200),
            child: Align(
              alignment: Alignment.center,
              child: AppTextstyle(
                text: _isCompleted
                    ? "Checked In Completed"
                    : widget.instructionText,
                style: appStyle(
                  size: 16.0,
                  color: widget.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Slider handle with container
          if (!_isCompleted)
            Positioned(
              left: _dragExtent,
              child: GestureDetector(
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                child: Container(
                  width: _sliderWidth,
                  height: _height - (_padding * 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular((_height - (_padding * 2)) / 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: widget.backgroundColor,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),

          // Checkmark icon when completed
          if (_isCompleted)
            Positioned(
              right: 10,
              child: Container(
                width: _height - (_padding * 2),
                height: _height - (_padding * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: widget.successBackgroundColor,
                    size: 24.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
