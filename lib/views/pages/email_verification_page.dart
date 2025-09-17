import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/new_password_page.dart';
import 'package:bazar/views/pages/phone_number_input_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key, required this.resetPassword});

  final bool resetPassword;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
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
            Text("Verification Email", style: KtextStyles.heading3),
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Please enter the code we just sent to email ",
                style: TextStyle(
                  color: AppColors.greyscale500,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: "youremail@gmail.com",
                    style: TextStyle(color: AppColors.greyscale900),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 52,
                  fieldWidth: 52,
                  activeColor: Colors.transparent,
                  inactiveColor: Colors.transparent,
                  selectedColor: Colors.transparent,
                  activeFillColor: AppColors.greyscale50,
                  inactiveFillColor: AppColors.greyscale50,
                  selectedFillColor: AppColors.greyscale50,
                ),
                enableActiveFill: true,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you didn't receive a code?",
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
                    "Resend",
                    style: TextStyle(
                      color: AppColors.primary500,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            PurpleButtonWidget(
              text: "Continue",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.resetPassword ? const NewPasswordPage() : const PhoneNumberInputPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
