import 'package:app_todo_application/MainScreen/main_Screen.dart';
import 'package:app_todo_application/MainScreen/main_wrapper.dart';
import 'package:app_todo_application/ShowSuccesDialog/show_verification_dialog.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
            SizedBox(height: 86),
            Text(
              "Verify account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 48),
            Container(
              width: 359,
              height: 468,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFFD9D9D9).withValues(alpha: 0.4),
                    Color(0xFFD9D9D9).withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 42, right: 42),
                child: Column(
                  children: [
                    SizedBox(height: 21),
                    Text(
                      "DO IT",
                      style: TextStyle(
                        fontFamily: 'Daruma',
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "By verifying your account, you data will be secured and be default you are accepting our terms and policies",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 65),
                    //nhập mã xác thực
                    SizedBox(
                      height: 56,
                      width: 274,
                      child: Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Verification code",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 23),
                    SizedBox(
                      height: 56,
                      width: 274,
                      child: SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ShowVerificationDialog();
                              },
                            );
                            Future.delayed(Duration(seconds: 3), () {
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainWrapper(),
                                  ),
                                  (route) => false,
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0EA5E9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // 6. Bo tròn góc
                            ),
                          ),
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
