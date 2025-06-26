import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileOptionsSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _buildOptionTile(
                context,
                icon: Icons.edit,
                title: 'Edit Profile',
                color: Colors.blue,
                onTap: () {
                  Navigator.pop(context);
                  context.push('/profileupdate');
                },
              ),
              _buildOptionTile(
                context,
                icon: Icons.logout,
                title: 'Log out',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  context.go('/login');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
