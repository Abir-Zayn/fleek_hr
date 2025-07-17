import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Widget child;

  const PageBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6200EE).withOpacity(0.15),
            Colors.white60,
          ],
        ),
      ),
      child: child,
    );
  }
}
