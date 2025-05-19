import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            _buildMenuItem(
                icon: Icons.dashboard_rounded,
                text: "Admin Dashboard",
                onClicked: () {
                    context.push('/admin-dashboard');

                })
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem({
  required IconData icon,
  required String text,
  required VoidCallback onClicked,
}) {
  final txtcolor = Colors.white;
  return ListTile(
    leading: Icon(icon, color: txtcolor),
    hoverColor: Colors.white.withOpacity(0.1),
    title: AppTextstyle(
      text: text,
      style: appStyle(size: 15, fontWeight: FontWeight.w500, color: txtcolor),
    ),
    onTap: onClicked,
  );
}
