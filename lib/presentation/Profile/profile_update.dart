import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use theme colors instead of hardcoded values
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final dividerColor = Theme.of(context).dividerColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // Profile Photo Section
                _buildSectionHeader(context, "Profile Photo"),
                SizedBox(height: 15.h),

                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: const NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?auto=format&fit=crop&q=80&w=2070",
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              // Image picker logic
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Profile Information Section
                _buildSectionHeader(context, "Profile Information"),
                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Muhammad Yunus',
                  icon: CupertinoIcons.person,
                ),

                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'example@mail.com',
                  icon: CupertinoIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: '+1 234 567 890',
                  icon: CupertinoIcons.phone,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 20.h),
                _buildDivider(dividerColor),
                SizedBox(height: 20.h),

                // Password Section
                _buildSectionHeader(context, "Change Password"),
                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _currentPasswordController,
                  labelText: 'Current Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock,
                  obscureText: true,
                ),

                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _newPasswordController,
                  labelText: 'New Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock_shield,
                  obscureText: true,
                ),

                SizedBox(height: 15.h),

                _buildTextField(
                  context: context,
                  controller: _confirmPasswordController,
                  labelText: 'Confirm New Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock_shield_fill,
                  obscureText: true,
                ),

                SizedBox(height: 20.h),
                _buildDivider(dividerColor),
                SizedBox(height: 20.h),

                // Delete Account Section
                _buildSectionHeader(
                  context,
                  "Delete Account",
                  textColor: Colors.red.shade700,
                ),
                SizedBox(height: 15.h),

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Once your account is deleted, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red.shade700,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Appbtn(
                        text: "Save Changes",
                        color: primaryColor,
                        textColor: Colors.white,
                        height: 50.h,
                        radius: 12.r,
                        fontSize: 16.sp,
                        onPressed: () {
                          // Save changes logic
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Appbtn(
                        text: "Delete Account",
                        color: Colors.white,
                        textColor: Colors.red.shade700,
                        height: 50.h,
                        radius: 12.r,
                        fontSize: 16.sp,
                        onPressed: () {
                          _showDeleteConfirmation(context);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable section header widget
  Widget _buildSectionHeader(BuildContext context, String title,
      {Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textColor ?? Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }

  // Reusable text field widget
  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        // color: Theme.of(context).cardColor,
      ),
      child: Apptextfield(
        controller: controller,
        labelText: labelText,
        hintText: hintText,
        keyboardType: keyboardType,
        borderRadius: 12.0,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Reusable divider widget
  Widget _buildDivider(Color color) {
    return Divider(
      color: color.withOpacity(0.5),
      thickness: 1.0,
    );
  }

  // Delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to delete your account? This action cannot be undone.",
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Please type 'DELETE' to confirm:",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.all(12.w),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Delete account logic
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
