
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_page_action_card.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_page_option_sheet.dart';
import 'package:flutter/cupertino.dart';

class ProfileActionsSection extends StatelessWidget {
  const ProfileActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ActionCard(
            icon: CupertinoIcons.money_dollar,
            title: "View Salary Details",
            onTap: () {
              // Navigate to salary details
            },
          ),
          const SizedBox(height: 12),
          ActionCard(
            icon: CupertinoIcons.pencil,
            title: "Edit Profile",
            onTap: () {
              ProfileOptionsSheet.show(context);
            },
          ),
        ],
      ),
    );
  }
}