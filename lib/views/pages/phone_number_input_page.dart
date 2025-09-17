import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/phone_verification_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputPage extends StatefulWidget {
  const PhoneNumberInputPage({super.key});

  @override
  State<PhoneNumberInputPage> createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
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
          children: [
            Text("Phone Number", style: KtextStyles.heading3),
            SizedBox(height: 10),
            Text(
              "Please enter your phone number, so we can more easily deliver your order",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyscale500,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 30),
            TextFieldAuthenticationWidget(
              title: "Phone Number",
              hintText: "(+213) 612345678",
              isPassword: false,
              prefixIcon: Icon(Icons.phone_outlined, color: AppColors.primary500,),
            ),
            SizedBox(height: 60),
            PurpleButtonWidget(text: "Continue", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => const PhoneVerificationPage(resetPassword: false,),))),
          ],
        ),
      ),
    );
  }
}
