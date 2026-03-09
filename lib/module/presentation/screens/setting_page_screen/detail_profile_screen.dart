import 'package:app_todo_application/module/presentation/screens/setting_page_screen/text_edit_widget.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (user != null) {
      nameController.text = user!.displayName ?? "";
      emailController.text = user!.email ?? "";
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 20,
                    ),
                    Text(
                      "Edit Setting",
                      style: AppStyles.bodyStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/image/user.png"),
                      backgroundColor: Colors.white,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Cột Name
                    TextEditWidget(
                      label: "Name",
                      controller: nameController,
                      obscure: false,
                    ),
                    // cột Email
                    TextEditWidget(
                      label: "Email",
                      controller: emailController,
                      obscure: false,
                    ),
                    // cột password
                    TextEditWidget(
                      label: "password",
                      controller: passwordController,
                      obscure: true,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
