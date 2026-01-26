import 'package:app_todo_application/SignInScreen/sign_in_screen.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key});

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Settings",
                          style: AppStyles.headingStyle.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              SizedBox(height: 104),
              //thẻ profile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 28),
                    SizedBox(width: 15),
                    Text("Profile", style: AppStyles.bodyStyle),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF63D9F3),
                      size: 18,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              //thẻ conver
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 15),
                    Text("Conversations", style: AppStyles.bodyStyle),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF63D9F3),
                      size: 18,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.white, size: 28),
                    SizedBox(width: 15),
                    Text("Projects", style: AppStyles.bodyStyle),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF63D9F3),
                      size: 18,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.find_in_page, color: Colors.white, size: 28),
                    SizedBox(width: 15),
                    Text("Terms and Policies", style: AppStyles.bodyStyle),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF63D9F3),
                      size: 18,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.logout, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: AppStyles.bodyStyle.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
