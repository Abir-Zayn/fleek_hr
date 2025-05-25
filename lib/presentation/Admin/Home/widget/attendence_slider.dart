import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class AttendanceSlider extends StatefulWidget {
  final VoidCallback onAttendanceMarked;
  final String instructionText;
  final String successText;
  final Color backgroundColor;
  final Color sliderColor;
  final Color iconColor;
  final Color textColor;
  final Color successBackgroundColor;

  const AttendanceSlider({
    super.key,
    required this.onAttendanceMarked,
    this.instructionText = "Swipe right to mark attendance",
    this.successText = "Attendance Marked!",
    this.backgroundColor = Colors.black,
    this.sliderColor = Colors.green,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.successBackgroundColor = Colors.lightGreen,
  });

  @override
  State<AttendanceSlider> createState() => _AttendanceSliderState();
}

class _AttendanceSliderState extends State<AttendanceSlider>
    with SingleTickerProviderStateMixin {
  double _dragExtent = 0.0;
  bool _isDismissed = false;
  late AnimationController _animationController;
  late Animation<double> slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isDismissed) return;
    setState(() {
      _dragExtent += details.delta.dx;
      // Clamp dragExtent to be non-negative and not exceed the container width
      _dragExtent = _dragExtent.clamp(
          0.0, context.size!.width - _sliderWidth() - _padding * 2);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isDismissed) return;
    final screenWidth = context.size!.width;
    final threshold = screenWidth * 0.7; // 60% of screen width to dismiss

    if (_dragExtent > threshold - _sliderWidth()) {
      _markAttendance();
    } else {
      // Reset position if not swiped enough
      setState(() {
        _dragExtent = 0.0;
      });
    }
  }

  void _markAttendance() {
    setState(() {
      _isDismissed = true;
      _dragExtent =
          context.size!.width - _sliderWidth() - _padding * 2; // Full swipe
    });
    _animationController.forward();
    widget.onAttendanceMarked();
  }

  double _sliderWidth() => 60.0;
  final double _padding = 14.0;
  final double _height = 60.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _height,
          decoration: BoxDecoration(
            color: _isDismissed
                ? widget.successBackgroundColor
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(_height / 2),
          ),
          padding: EdgeInsets.all(_padding),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _isDismissed ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: AppTextstyle(
                    text: widget.successText,
                    style: appStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _isDismissed ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Align(
                  alignment: Alignment.center,
                  child: AppTextstyle(
                    text: widget.instructionText,
                    style: appStyle(
                      size: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (!_isDismissed)
                Positioned(
                  left: _dragExtent,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    child: Container(
                      width: _sliderWidth(),
                      height: _height - (_padding * 2),
                      decoration: BoxDecoration(
                        color: widget.sliderColor,
                        borderRadius: BorderRadius.circular(
                            (_height - (_padding * 2)) / 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: widget.iconColor,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
