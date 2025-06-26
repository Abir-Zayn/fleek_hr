import 'package:fleekhr/presentation/Employee/Profile/Widget/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  final String email;
  final String phone;
  final String department;

  const ContactInfoSection({
    super.key,
    required this.email,
    required this.phone,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              "Contact Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color ??
                    Colors.black,
              ),
            ),
          ),
          InfoCard(
            icon: CupertinoIcons.mail,
            title: "Email",
            value: email,
          ),
          const SizedBox(height: 12),
          InfoCard(
            icon: CupertinoIcons.phone,
            title: "Phone",
            value: phone,
          ),
          const SizedBox(height: 12),
          InfoCard(
            icon: CupertinoIcons.building_2_fill,
            title: "Department",
            value: department,
          ),
        ],
      ),
    );
  }
}