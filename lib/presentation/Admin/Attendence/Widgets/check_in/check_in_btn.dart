import 'package:flutter/material.dart';

class CheckInBtn extends StatelessWidget {
  final bool isCheckedIn;
  final VoidCallback? onPressed;
  const CheckInBtn({super.key, required this.isCheckedIn, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(40),
          backgroundColor: isCheckedIn ? Colors.grey : Colors.green,
        ),
        onPressed: onPressed,
        child: const Icon(Icons.login, size: 40, color: Colors.white),
      ),
    );
  }
}
