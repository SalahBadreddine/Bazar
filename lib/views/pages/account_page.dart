import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/providers/user_provider.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController.text = user?.username ?? "";
    emailController.text = user?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.greyscale900, size: 30),
        ),
        title: Text("My Account", style: KtextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/avatar.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Change Picture",
                      style: TextStyle(
                        color: AppColors.primary500,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 20,
              children: [
                TextFieldAuthenticationWidget(
                  controller: nameController,
                  title: "Full Name",
                  hintText: "Your full name",
                  isPassword: false,
                ),
                TextFieldAuthenticationWidget(
                  controller: emailController,
                  title: "Email",
                  hintText: "Your email",
                  isPassword: false,
                ),
                TextFieldAuthenticationWidget(
                  controller: phoneController,
                  title: "Phone Number",
                  hintText: "Your phone number",
                  isPassword: false,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: AppColors.primary500,
                  ),
                ),
                TextFieldAuthenticationWidget(
                  controller: passwordController,
                  title: "Password",
                  hintText: "Your password",
                  isPassword: true,
                ),
              ],
            ),
            PurpleButtonWidget(text: "Save Changes", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
