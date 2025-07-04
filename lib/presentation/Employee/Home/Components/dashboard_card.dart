import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';


class DashboardCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color color;
  const DashboardCard(
      {super.key,
      required this.title,
      required this.count,
      required this.icon,
      required this.onTap,
      required this.iconColor,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0.3,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: iconColor,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(height: 10),
              //heading
              AppTextstyle(
                text: title,
                style: appStyle(
                    size: 15,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              AppTextstyle(
                text: count,
                style: appStyle(
                    size: 13,
                    color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.7) ??
                        Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ??
                      Colors.black,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
