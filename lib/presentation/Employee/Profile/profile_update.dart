import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:fleekhr/presentation/Employee/Profile/cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _skills1Controller = TextEditingController();
  final TextEditingController _skills2Controller = TextEditingController();
  final TextEditingController _skills3Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-populate fields with current user data
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      _nameController.text = profileState.user.name;
      _emailController.text = profileState.user.email;
      _phoneController.text = profileState.user.phone;
      _skills1Controller.text = profileState.user.skills1;
      _skills2Controller.text = profileState.user.skills2;
      _skills3Controller.text = profileState.user.skills3;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _skills1Controller.dispose();
    _skills2Controller.dispose();
    _skills3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final dividerColor = Theme.of(context).dividerColor;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
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
                            "https://images.unsplash.com/photo-1683029096295-7680306aa37d?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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

                  const SizedBox(height: 15),

                  profileTextField(
                    context: context,
                    controller: _skills1Controller,
                    labelText: 'Primary Skill',
                    hintText: 'e.g., Flutter Development',
                    icon: CupertinoIcons.bolt_fill,
                  ),

                  const SizedBox(height: 15),

                  profileTextField(
                    context: context,
                    controller: _skills2Controller,
                    labelText: 'Secondary Skill',
                    hintText: 'e.g., UI/UX Design',
                    icon: CupertinoIcons.bolt_fill,
                  ),

                  const SizedBox(height: 15),

                  profileTextField(
                    context: context,
                    controller: _skills3Controller,
                    labelText: 'Tertiary Skill',
                    hintText: 'e.g., Project Management',
                    icon: CupertinoIcons.bolt_fill,
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

                  const SizedBox(height: 30),

                  // Save Changes Button
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final isLoading = state is ProfileLoading;

                      return Appbtn(
                        text: isLoading ? "Saving..." : "Save Changes",
                        color: primaryColor,
                        textColor: Colors.white,
                        height: 50,
                        radius: 12,
                        fontSize: 16,
                        onPressed: isLoading ? null : _saveChanges,
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final currentState = context.read<ProfileCubit>().state;
    if (currentState is ProfileLoaded) {
      final updatedUser = currentState.user.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        skills1: _skills1Controller.text.trim(),
        skills2: _skills2Controller.text.trim(),
        skills3: _skills3Controller.text.trim(),
      );

      context.read<ProfileCubit>().updateUserProfile(updatedUser);
    }
  }

  Widget sectionHeader(BuildContext context, String title, {Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor ?? Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }

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

  Widget profileDivider(Color color) {
    return Divider(
      color: color.withOpacity(0.5),
      thickness: 1.0,
    );
  }
}
