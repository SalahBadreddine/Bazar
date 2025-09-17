import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/reset_password_email_page.dart';
import 'package:bazar/views/pages/reset_password_phone_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isEmail = true;
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
                Text("Forgot Password", style: KtextStyles.heading3),
                SizedBox(height: 10),
                Text(
                  "Select which contact details should we use to reset your password",
                  style: KtextStyles.bodyregular16,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          isEmail = true;
                        }),
                        child: Container(
                          height: 151,
                          decoration: BoxDecoration(
                            color: AppColors.greyscale50,
                            borderRadius: BorderRadius.circular(8),
                            border: isEmail
                                ? Border.all(
                                    color: AppColors.primary500,
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/email_icon.png",
                                  height: 48,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: KtextStyles.bodymedium14,
                                    ),
                                    Text(
                                      "Send to your email",
                                      style: TextStyle(
                                        color: AppColors.greyscale500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          isEmail = false;
                        }),
                        child: Container(
                          height: 151,
                          decoration: BoxDecoration(
                            color: AppColors.greyscale50,
                            borderRadius: BorderRadius.circular(8),
                            border: !isEmail
                                ? Border.all(
                                    color: AppColors.primary500,
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/phone_icon.png",
                                  height: 40,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number",
                                      style: KtextStyles.bodymedium14,
                                    ),
                                    Text(
                                      "Send to your phone",
                                      style: TextStyle(
                                        color: AppColors.greyscale500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                PurpleButtonWidget(text: "Continue", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => isEmail ? const ResetPasswordEmailPage() : const ResetPasswordPhonePage(),))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
