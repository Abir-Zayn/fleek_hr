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

  void _handleCheckInOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(checkInTime == null ? 'Check In' : 'Check Out'),
        content: Text(
            'Are you sure you want to ${checkInTime == null ? 'check in' : 'check out'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (checkInTime == null) {
                  checkInTime = DateTime.now();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checked In')),
                  );
                } else {
                  checkOutTime = DateTime.now();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checked Out')),
                  );
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _handleCheckInOut,
            child: Text(checkInTime == null ? 'Check In' : 'Check Out'),
          ),
          const SizedBox(height: 20),
          if (checkInTime != null)
            Text(
              'Check In Time: ${DateFormat('hh:mm a').format(checkInTime!)}',
              style: const TextStyle(fontSize: 16),
            ),
          if (checkOutTime != null)
            Text(
              'Check Out Time: ${DateFormat('hh:mm a').format(checkOutTime!)}',
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
