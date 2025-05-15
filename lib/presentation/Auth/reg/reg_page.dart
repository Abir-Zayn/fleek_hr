part of 'reg_imports.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo with back button
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      Appvectors.appLogo,
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Tagline
              AppTextstyle(
                text:
                    "Everyday is a new beginning, start your New Chapter with fresh goal!",
                style: appStyle(
                  size: 18.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),

              SizedBox(height: 32.h),

              // Form fields - with improved icons and proper settings
              Apptextfield(
                hintText: "Email",
                leadingIcon: Icon(
                  CupertinoIcons.mail,
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16.h),

              Apptextfield(
                hintText: "Name",
                leadingIcon: Icon(
                  CupertinoIcons.person,
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: false, // Changed to false for name
                keyboardType: TextInputType.name, // Correct keyboard type
              ),

              SizedBox(height: 16.h),

              Apptextfield(
                hintText: "Employee ID",
                leadingIcon: Icon(
                  CupertinoIcons.number_square,
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: false, // Changed to false for employee ID
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 16.h),

              Apptextfield(
                hintText: "Password",
                leadingIcon: Icon(
                  CupertinoIcons.lock,
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              SizedBox(height: 32.h),

              // Sign up button - using theme colors
              Appbtn(
                text: "SIGN UP",
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 56.h,
                radius: 12.r,
                fontSize: 17.sp,
                textColor: Colors.white,
                onPressed: () {
                  context.go('/entry');
                },
              ),

              SizedBox(height: 20.h),

              // Improved divider with text
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Google sign-in button with consistent styling
              Appbtn(
                icon: FontAwesomeIcons.google,
                iconColor: Colors.red,
                text: "Continue with Google",
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey.shade800,
                iconSize: 20.sp,
                width: double.infinity,
                height: 56.h,
                radius: 12.r,
                fontSize: 17.sp,
                textColor: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.black87,
                onPressed: () {
                  // Google sign-in functionality
                },
              ),

              SizedBox(height: 32.h),

              // Login row - better aligned and styled
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextstyle(
                    text: "Already have an Account?",
                    style: appStyle(
                      fontWeight: FontWeight.w500,
                      size: 16.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color ??
                          Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, 36.h),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                    ),
                    child: AppTextstyle(
                      text: "Log In",
                      style: appStyle(
                        size: 16.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
