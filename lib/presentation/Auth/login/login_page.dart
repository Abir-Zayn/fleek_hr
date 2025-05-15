part of 'login_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header image
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 24.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    Appvectors.splashImage,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Heading text
              AppTextstyle(
                text: "Empower your workforce",
                style: appStyle(
                  size: 24.sp,
                  color: Theme.of(context).textTheme.headlineLarge?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle text
              AppTextstyle(
                text:
                    "Streamline onboarding, attendance, payroll, and more in one smart platform.",
                style: appStyle(
                  size: 15.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),

              // Login form
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
                hintText: "Password",
                leadingIcon: Icon(
                  CupertinoIcons.lock,
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              SizedBox(height: 40.h),

              // Login button
              Appbtn(
                text: "LOG IN",
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 56.h,
                radius: 12.r,
                fontSize: 16.sp,
                textColor: Colors.white,
                onPressed: () {
                  context.go('/entry');
                },
              ),

              SizedBox(height: 16.h),

              // Forgot password
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Sign up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextstyle(
                    text: "Don't have an Account?",
                    style: appStyle(
                      size: 16.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color ??
                          Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/reg');
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, 36.h),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                    ),
                    child: AppTextstyle(
                      text: "Sign Up",
                      style: appStyle(
                        size: 16.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color ??
                            Colors.black54,
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
