import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_picture_component.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/role_badge.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          ProfilePicture(imageUrl: imageUrl),
          const SizedBox(height: 15),
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 5),
          RoleBadge(role: role),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
