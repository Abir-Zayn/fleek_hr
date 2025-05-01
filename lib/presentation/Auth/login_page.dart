import 'package:fleekhr/common/utils/src_link/appvectors.dart';
import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    Appvectors.splashImage,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                AppTextstyle(
                  text: "Empower your workforce",
                  style: appStyle(
                      size: 25.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                AppTextstyle(
                  text:
                      "Streamline onboarding, attendance, payroll, and more in one smart platform.",
                  style: appStyle(
                      size: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Apptextfield(
                  hintText: "Email",
                  leadingIcon: Icon(CupertinoIcons.envelope_fill),
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                Apptextfield(
                  hintText: "Password",
                  leadingIcon: Icon(CupertinoIcons.lock_fill),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 40),
                Appbtn(
                  text: "LOG IN",
                  color: Colors.blue.shade900,
                  width: 350,
                  height: 50,
                  radius: 10,
                  fontSize: 18,
                  textColor: Colors.white,
                  onPressed: () {
                    context.go('/entry');
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: AppTextstyle(
                    text: "Forgot Password ? ",
                    style: appStyle(
                      size: 18.sp,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextstyle(
                      text: "Don't have an Account? ",
                      style: appStyle(
                        size: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/reg');
                      },
                      child: AppTextstyle(
                        text: "Sign Up",
                        style: appStyle(
                          size: 18.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
