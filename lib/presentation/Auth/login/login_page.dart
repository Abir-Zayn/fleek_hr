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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                // Logo
                Image.asset(
                  Appvectors.appLogo,
                  height: 90,
                  width: 90,
                  fit: BoxFit.contain,
                ),

                // Welcome Message
                AppTextstyle(
                  text: "Welcome Back 👋",
                  style: appStyle(
                    size: 26,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                AppTextstyle(
                  text: "Sign in to continue using FleekHR",
                  style: appStyle(
                    size: 15,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 30),

                // Form Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextstyle(
                        text: "Email",
                        style: appStyle(
                          size: 14,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Apptextfield(
                        hintText: "Enter your email",
                        leadingIcon: Icon(
                          CupertinoIcons.mail,
                          color: Theme.of(context).primaryColor,
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),

                      const SizedBox(height: 10),

                      AppTextstyle(
                        text: "Password",
                        style: appStyle(
                          size: 14,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Apptextfield(
                        hintText: "Enter your password",
                        leadingIcon: Icon(
                          CupertinoIcons.lock,
                          color: Theme.of(context).primaryColor,
                        ),
                        obscureText: true,
                        isPassword: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      const SizedBox(height: 20),

                      // Remember me + Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
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
                            onPressed: () {},
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

                      const SizedBox(height: 20),

                      // Login button
                      Appbtn(
                        text: "SIGN IN",
                        bgColor: Theme.of(context).primaryColor,
                        width: double.infinity,
                        height: 50,
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
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
