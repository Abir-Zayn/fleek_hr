import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class Requestcard extends StatefulWidget {
  final IconData icon;
  final String text;
  final String? description;
  final Color iconColor;
  final VoidCallback? onTap;

  const Requestcard({
    super.key,
    required this.icon,
    required this.text,
    this.description,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  State<Requestcard> createState() => _RequestcardState();
}

class _RequestcardState extends State<Requestcard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    // Initialize animation for interactive feedback
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              // Animate button press
              setState(() => _isPressed = true);
              _animationController.forward();
            },
            onTapUp: (_) {
              // Reset animation and trigger callback
              setState(() => _isPressed = false);
              _animationController.reverse();
              widget.onTap?.call();
            },
            onTapCancel: () {
              // Reset animation on cancel
              setState(() => _isPressed = false);
              _animationController.reverse();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isPressed
                      ? widget.iconColor.withOpacity(0.3)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.iconColor.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Main card content - everything centered
                  Padding(
                    padding: const EdgeInsets.all(
                        12), // Reduced padding to prevent overflow
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Ensure everything is centered
                      children: [
                        // Enhanced icon container with gradient
                        Container(
                          padding:
                              const EdgeInsets.all(12), // Reduced icon padding
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.iconColor.withOpacity(0.1),
                                widget.iconColor.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.iconColor.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.iconColor,
                            size: 28, // Slightly reduced icon size
                          ),
                        ),
                        const SizedBox(height: 12), // Reduced spacing

                        // Enhanced title with better typography
                        AppTextstyle(
                          text: widget.text,
                          style: appStyle(
                            size: 15, // Slightly reduced font size
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),

                        // Enhanced description with improved styling
                        if (widget.description != null) ...[
                          const SizedBox(height: 6), // Reduced spacing
                          Flexible(
                            // Use Flexible to prevent overflow
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2), // Reduced padding
                              child: Text(
                                widget.description!,
                                style: TextStyle(
                                  fontSize: 11, // Reduced font size
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2, // Reduced line height
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Subtle hover effect indicator
                  Positioned(
                    bottom: 8, // Adjusted position for reduced padding
                    right: 8, // Adjusted position for reduced padding
                    child: AnimatedOpacity(
                      opacity: _isPressed ? 1.0 : 0.3,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 10, // Slightly smaller arrow
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
