import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

///A cutsom AppBar widget that can be used throughout the app.
///
/// *Features:
///  -- back button
///  -- title
///  -- custom shape with rounded corners

class FleekAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final VoidCallback? onBackButtonPressed;
  final Widget? actionButton;
  final VoidCallback? onActionButtonPressed;

  const FleekAppBar({
    super.key,
    required this.backgroundColor,
    required this.title,
    this.onBackButtonPressed,
    this.actionButton,
    this.onActionButtonPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56.0,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
      ),
      backgroundColor: backgroundColor,
      title: AppTextstyle(
        text: title,
        style: appStyle(
          size: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      actions: actionButton != null
          ? [
              IconButton(
                icon: actionButton!,
                onPressed: onActionButtonPressed,
              ),
            ]
          : null,
    );
  }
}
