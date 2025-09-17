import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/phone_verification_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswordPhonePage extends StatefulWidget {
  const ResetPasswordPhonePage({super.key});

  @override
  State<ResetPasswordPhonePage> createState() => _ResetPasswordPhonePageState();
}

class _ResetPasswordPhonePageState extends State<ResetPasswordPhonePage> {
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
                Text("Reset Password", style: KtextStyles.heading3),
                SizedBox(height: 10),
                Text(
                  "Please enter your email, we will send verification code to your phone number",
                  style: KtextStyles.bodyregular16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFieldAuthenticationWidget(title: "Phone number", hintText: "(+213) 612345678", isPassword: false),
                ),
                PurpleButtonWidget(text: "Send", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => const PhoneVerificationPage(resetPassword: true,),))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}