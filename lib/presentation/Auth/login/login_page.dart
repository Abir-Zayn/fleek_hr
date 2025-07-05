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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
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
        } else if (state is LoginError) {
          // Close loading dialog if open
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failure.message,
                style: const TextStyle(fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginSuccess) {
          // Close loading dialog if open
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          // Show success message and navigate
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(fontSize: 14),
              ),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to home
          context.go('/admin-home');
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // Logo and header
                Center(
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        Appvectors.appLogo,
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Welcome text with styled container
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 4,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: 10),
                          AppTextstyle(
                            text: "Welcome Back !",
                            style: appStyle(
                              size: 30,
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color ??
                                  Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      AppTextstyle(
                        text: "Sign in to continue to FleekHR",
                        style: appStyle(
                          size: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // Email field with improved styling
                AppTextstyle(
                  text: "Email",
                  style: appStyle(
                    size: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
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
                    size: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Apptextfield(
                  hintText: "Enter your password",
                  leadingIcon: Icon(
                    CupertinoIcons.lock,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  obscureText: true,
                  isPassword: true, // Enable password toggle
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),

                SizedBox(height: 16),

                // Remember me and Forgot password row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: rememberMe,
                            activeColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        AppTextstyle(
                          text: "Remember me",
                          style: appStyle(
                            size: 14,
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
                        minimumSize: Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: appStyle(
                          size: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Login button with shadow
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Appbtn(
                    text: "SIGN IN",
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    height: 56,
                    radius: 12,
                    fontSize: 16,
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<LoginCubit>().login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    },
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
