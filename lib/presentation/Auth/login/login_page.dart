part of 'login_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextEditingContrller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
  }

  @override
  void dispose() {
    // Dispose of controllers to free up resources
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),

              // Logo and header
              Center(
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      Appvectors.appLogo,
                      height: 150.h,
                      width: 150.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Welcome text with styled container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 24.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        AppTextstyle(
                          text: "Welcome Back !",
                          style: appStyle(
                            size: 30.sp,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    AppTextstyle(
                      text: "Sign in to continue to FleekHR",
                      style: appStyle(
                        size: 16.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Email field with improved styling
              AppTextstyle(
                text: "Email",
                style: appStyle(
                  size: 14.sp,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Apptextfield(
                hintText: "Enter your email",
                leadingIcon: Icon(
                  CupertinoIcons.mail,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),

              // Password field with improved styling
              AppTextstyle(
                text: "Password",
                style: appStyle(
                  size: 14.sp,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Apptextfield(
                hintText: "Enter your password",
                leadingIcon: Icon(
                  CupertinoIcons.lock,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),

              SizedBox(height: 16.h),

              // Remember me and Forgot password row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          value: rememberMe,
                          activeColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      AppTextstyle(
                        text: "Remember me",
                        style: appStyle(
                          size: 14.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Forgot password functionality
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50.w, 30.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: appStyle(
                        size: 14.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Login button with shadow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Appbtn(
                  text: "SIGN IN",
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: 56.h,
                  radius: 12.r,
                  fontSize: 16.sp,
                  textColor: Colors.white,
                  onPressed: () async {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    try {
                      var result = await sl<LoginUsecase>().call(
                        params: UserLogin(
                          email: emailController.text.trim(),
                          password: passwordController.text.toString().trim(),
                        ),
                      );

                      // Dismiss loading indicator
                      Navigator.pop(context);

                      result.fold((l) {
                        // Handle error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }, (r) {
                        // Handle success
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Login successful",
                              style: const TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.push(
                            '/admin-home'); // Navigate to home page on success
                      });
                    } catch (e) {
                      // Dismiss loading indicator
                      Navigator.pop(context);

                      // Show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "An unexpected error occurred",
                            style: const TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
