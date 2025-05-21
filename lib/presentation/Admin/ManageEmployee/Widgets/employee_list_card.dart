import 'package:flutter/material.dart';

/// A card widget that displays employee information
///
/// Displays:
/// - Avatar
/// - Name and email
/// - Status badge
/// - Details (role, shift, duty hours, last login)
///
/// Tapping the card can navigate to employee details
class EmployeeCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String shift;
  final String lastLogin;
  final String status;
  final String dutyHours;
  final String avatarUrl;
  final VoidCallback? onTap;

  const EmployeeCard({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.shift,
    required this.lastLogin,
    required this.status,
    required this.dutyHours,
    required this.avatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = status.toLowerCase() == 'active';
    final bool exterminate = status.toLowerCase() == 'exterminated';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]!,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green[50]
                        : exterminate
                            ? Colors.red[50]
                            : Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      //if is active, use green color, else if exterminate, use red color, else use orange color
                      color: isActive
                          ? Colors.green[700]
                          : exterminate
                              ? Colors.red[700]
                              : Colors.orange[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(Icons.work, role),
                _buildInfoItem(Icons.access_time, shift),
                _buildInfoItem(Icons.timer, dutyHours),
                _buildInfoItem(Icons.login, 'Last: $lastLogin'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
