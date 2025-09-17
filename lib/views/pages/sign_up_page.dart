import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/email_verification_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                Text("Sign Up", style: KtextStyles.heading3),
                SizedBox(height: 10),
                Text(
                  "Create account and choose favorite menu",
                  style: KtextStyles.bodyregular16,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    TextFieldAuthenticationWidget(
                      title: "Name",
                      hintText: "Your name",
                      isPassword: false,
                    ),
                    TextFieldAuthenticationWidget(
                      title: "Email",
                      hintText: "Your email",
                      isPassword: false,
                    ),
                    TextFieldAuthenticationWidget(
                      title: "Password",
                      hintText: "Your password",
                      isPassword: true,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: PurpleButtonWidget(text: "Register", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => const EmailVerificationPage(resetPassword: false,),))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: TextStyle(
                        color: AppColors.greyscale500,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.primary500,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                text: "By clicking Register, you agree to our \n",
                style: TextStyle(
                  color: AppColors.greyscale500,
                  fontWeight: FontWeight.w700
                ),
                children: [
                  TextSpan(
                    text: "Terms and Data Policy.",
                    style: TextStyle(
                      color: AppColors.primary500
                    )
                  )
                ]
              )),
            )
          ],
        ),
      ),
    );
  }
}
