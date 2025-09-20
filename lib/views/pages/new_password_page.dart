import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/sign_in_page.dart';
import 'package:bazar/views/pages/success_page.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/purple_button_widget.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.greyscale900, size: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("New Password", style: KtextStyles.heading3),
                SizedBox(height: 10),
                Text(
                  "Create your new password, so you can login to your account",
                  style: KtextStyles.bodyregular16,
                ),
                SizedBox(height: 30),
                Column(
                  spacing: 10,
                  children: [
                    TextFieldAuthenticationWidget(controller: passwordController, title: "New Password", hintText: "Your password", isPassword: true),
                    TextFieldAuthenticationWidget(controller: confirmpasswordController, title: "Confirm Password", hintText: "Your password", isPassword: true),
                  ],
                ),
                SizedBox(height: 50),
                PurpleButtonWidget(text: "Send", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => SuccessPage(title: "Password Changed!", subtitle: "Password changed successfully, you can login again with a new password", buttonText: "Login", onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const SignInPage(),)),)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}