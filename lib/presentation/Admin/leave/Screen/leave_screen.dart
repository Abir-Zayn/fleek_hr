part of 'leave_screen_imports.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //customize appBar
      appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Leave Management"),
    );
  }
}
