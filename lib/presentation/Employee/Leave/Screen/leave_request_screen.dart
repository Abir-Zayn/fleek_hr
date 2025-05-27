part of 'leave_request_imports.dart';

class LeaveRequestScreen extends StatelessWidget {
  const LeaveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Fleek Bangladesh",
      ),
      body: const Center(
        child: Text(
          'Leave Request Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}