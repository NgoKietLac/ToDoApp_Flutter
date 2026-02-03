import 'package:app_todo_application/AuthService/auth_service.dart';
import 'package:app_todo_application/MainScreen/main_wrapper.dart';
import 'package:app_todo_application/SignUpScreen/sign_up_screen.dart';
import 'package:app_todo_application/cubit/auth_cubit.dart';
import 'package:app_todo_application/cubit/auth_state.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:app_todo_application/verification/verification_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _authCubit = context.read<AuthCubit>();
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainWrapper()),
              );
            }
            // 2. Nếu lỗi -> Hiện thông báo
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
            return Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Image.asset(
                        "assets/icon/Checkmark.png",
                        width: 83,
                        height: 83,
                      ),
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
                                    style: AppStyles.headingStyle.copyWith(
                                      fontSize: 25,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "DO IT",
                                    style: AppStyles.logoStyle,
                                  ),
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
                              "Have an other productive day !",
                              style: AppStyles.bodyStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48),
                      //Nhập Email
                      Container(
                        margin: EdgeInsets.only(left: 26, right: 27),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "E-Mail",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 56),
                      //nhập password
                      Container(
                        margin: EdgeInsets.only(left: 26, right: 27),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      // nút quên mật khẩu
                      Container(
                        margin: EdgeInsets.only(right: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "forget password",
                                style: AppStyles.bodyStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: Color(
                                    0xFFFFFFFF,
                                  ).withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.only(left: 31, right: 32),
                        child: SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              if (email.isNotEmpty && password.isNotEmpty) {
                                _authCubit.login(email, password);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text("Vui lòng nhập đủ thông tin"),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0EA5E9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("sign in", style: AppStyles.bodyStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 19),
                      Container(
                        padding: EdgeInsets.all(1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don’t have an account? ",
                                    style: AppStyles.bodyStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "sign up",
                                    style: AppStyles.bodyStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(0xFF63D9F3),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen(),
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
                      SizedBox(height: 48),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In with: ",
                              style: AppStyles.bodyStyle.copyWith(fontSize: 14),
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
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
