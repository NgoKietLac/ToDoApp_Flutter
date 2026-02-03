import 'package:app_todo_application/MainScreen/main_Screen.dart';
import 'package:app_todo_application/MainScreen/main_wrapper.dart';
import 'package:app_todo_application/ShowSuccesDialog/show_verification_dialog.dart';
import 'package:app_todo_application/cubit/auth_cubit.dart';
import 'package:app_todo_application/cubit/auth_state.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => ShowVerificationDialog(),
          );
          Future.delayed(Duration(seconds: 3), () {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainWrapper()),
                (route) => false,
              );
            }
          });
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, state) {
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 86),
                    Text(
                      "Verify account",
                      style: AppStyles.headingStyle.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 48),
                    Container(
                      width: 359,
                      height: 468,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
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
                              style: AppStyles.logoStyle.copyWith(fontSize: 30),
                            ),
                            SizedBox(height: 50),
                            Text(
                              "By verifying your account, you data will be secured and be default you are accepting our terms and policies",
                              style: AppStyles.bodyStyle.copyWith(fontSize: 16),
                            ),
                            SizedBox(height: 65),
                            //nhập mã xác thực
                            SizedBox(
                              height: 56,
                              width: 274,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: otpController,
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
                                  onPressed: state is AuthLoading
                                      ? null
                                      : () {
                                          final codeotp = otpController.text
                                              .trim();
                                          final email = context
                                              .read<AuthCubit>()
                                              .pendingEmail;
                                          if (codeotp.isNotEmpty &&
                                              email != null) {
                                            context.read<AuthCubit>().verifyOTP(
                                              email,
                                              codeotp,
                                            );
                                          }
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
                                    style: AppStyles.bodyStyle.copyWith(
                                      fontSize: 18,
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
            ),
          ),
        );
      },
    );
  }
}
