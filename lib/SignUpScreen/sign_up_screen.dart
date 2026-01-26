import 'package:app_todo_application/ShowSuccesDialog/show_succes_dialog_box.dart';
import 'package:app_todo_application/SignInScreen/sign_in_screen.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 22),
            Image.asset("assets/icon/Checkmark.png", width: 83, height: 83),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(left: 26),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome Back to ",
                          style: AppStyles.bodyStyle.copyWith(fontSize: 25),
                        ),
                        TextSpan(text: "DO IT", style: AppStyles.logoStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26),
              child: Row(
                children: [
                  Text(
                    "create an account and Join us now!",
                    style: AppStyles.bodyStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 33),
            //nhập tên
            Container(
              margin: EdgeInsets.only(left: 26, right: 27),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            //nhập email
            Container(
              margin: EdgeInsets.only(left: 26, right: 27),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.mail, color: Colors.black),
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            //Nhập password
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 26, right: 27),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 47),
            Container(
              margin: EdgeInsets.only(left: 28, right: 32),
              child: SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ShowSuccesDialogBox();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0EA5E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 6. Bo tròn góc
                    ),
                  ),
                  child: Text(
                    "sign up",
                    style: AppStyles.bodyStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: AppStyles.bodyStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "sign in",
                          style: AppStyles.bodyStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF63D9F3),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 37),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In with: ",
                    style: AppStyles.bodyStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: Image.asset("assets/icon/ios.png"),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: Image.asset("assets/icon/icon_gg.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
