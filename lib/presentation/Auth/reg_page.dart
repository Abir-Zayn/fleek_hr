import 'package:fleekhr/common/utils/src_link/appvectors.dart';
import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //load the image from assets
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    Appvectors.appLogo,
                    width: 200,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                AppTextstyle(
                  text:
                      "Everyday is a new beginning, start your New Chapter with fresh goal!",
                  style: appStyle(
                      size: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
                SizedBox(height: 20),
                Apptextfield(
                  hintText: "Email",
                  leadingIcon: Icon(CupertinoIcons.envelope_open),
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                Apptextfield(
                  hintText: "Name",
                  leadingIcon: Icon(CupertinoIcons.person),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 15),
                Apptextfield(
                  hintText: "Employee ID",
                  leadingIcon: Icon(CupertinoIcons.lock_fill),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 15),
                Apptextfield(
                  hintText: "Password",
                  leadingIcon: Icon(CupertinoIcons.lock_fill),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),

                SizedBox(height: 45),
                Appbtn(
                  text: "SIGN UP",
                  color: Colors.blue.shade900,
                  width: 350,
                  height: 50,
                  radius: 10,
                  fontSize: 18,
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigate to the login page
                    context.go('/entry');
                  },
                ),
                SizedBox(height: 10),
                //Divider
                Divider(
                  color: Colors.black,
                  endIndent: 10,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Appbtn(
                  icon: FontAwesomeIcons.google,
                  iconColor: Colors.green,
                  text: "Continue with Google",
                  color: Colors.grey.shade50,
                  iconSize: 20,
                  width: 350,
                  height: 40,
                  radius: 10,
                  fontSize: 18,
                  textColor: Colors.grey,
                  onPressed: () {
                    // Navigate to the login page
                    context.go('/login');
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextstyle(
                      text: "Already have an Account? ",
                      style: appStyle(
                        size: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: AppTextstyle(
                        text: "Log In",
                        style: appStyle(
                          size: 18.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600,
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
