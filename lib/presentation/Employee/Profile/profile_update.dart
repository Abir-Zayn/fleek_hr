import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        toolbarHeight: 60,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Profile Photo Section
                sectionHeader(context, "Profile Photo"),
                const SizedBox(height: 15),

                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?auto=format&fit=crop&q=80&w=2070",
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
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

                const SizedBox(height: 30),

                // Profile Information Section
                sectionHeader(context, "Profile Information"),
                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Muhammad Yunus',
                  icon: CupertinoIcons.person,
                ),

                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'example@mail.com',
                  icon: CupertinoIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: '+1 234 567 890',
                  icon: CupertinoIcons.phone,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 20),
                profileDivider(dividerColor),
                const SizedBox(height: 20),

                // Password Section
                sectionHeader(context, "Change Password"),
                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _currentPasswordController,
                  labelText: 'Current Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _newPasswordController,
                  labelText: 'New Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock_shield,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                profileTextField(
                  context: context,
                  controller: _confirmPasswordController,
                  labelText: 'Confirm New Password',
                  hintText: '••••••••',
                  icon: CupertinoIcons.lock_shield_fill,
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                profileDivider(dividerColor),
                const SizedBox(height: 20),

                // Delete Account Section
                sectionHeader(
                  context,
                  "Delete Account",
                  textColor: Colors.red.shade700,
                ),
                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Once your account is deleted, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade700,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Appbtn(
                        text: "Save Changes",
                        color: primaryColor,
                        textColor: Colors.white,
                        height: 50,
                        radius: 12,
                        fontSize: 16,
                        onPressed: () {
                          // Save changes logic
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Appbtn(
                        text: "Delete Account",
                        color: Colors.white,
                        textColor: Colors.red.shade700,
                        height: 50,
                        radius: 12,
                        fontSize: 16,
                        onPressed: () {
                          _showDeleteConfirmation(context);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable section header widget
  Widget sectionHeader(BuildContext context, String title,
      {Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor ?? Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }

  // Reusable text field widget
  Widget profileTextField({
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
        borderRadius: BorderRadius.circular(12),
        // color: Theme.of(context).cardColor,
      ),
      child: Apptextfield(
        controller: controller,
        labelText: labelText,
        hintText: hintText,
        keyboardType: keyboardType,
        borderRadius: 12.0,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Reusable divider widget
  Widget profileDivider(Color color) {
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
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Are you sure you want to delete your account? This action cannot be undone.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Please type 'DELETE' to confirm:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(12),
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
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Delete account logic
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontSize: 16,
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
