import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/models/user_model.dart';
import 'package:bazar/providers/user_provider.dart';
import 'package:bazar/views/pages/forgot_password_page.dart';
import 'package:bazar/views/pages/main_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/widgets/text_field_authentication_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back 👋", style: KtextStyles.heading3),
            SizedBox(height: 10),
            Text("Sign to your account", style: KtextStyles.bodyregular16),
            SizedBox(height: 20),
            // Text field widget
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                TextFieldAuthenticationWidget(
                  controller: emailController,
                  title: "Email",
                  hintText: "Your email",
                  isPassword: false,
                ),
                TextFieldAuthenticationWidget(
                  controller: passwordController,
                  title: "Password",
                  hintText: "Your password",
                  isPassword: true,
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => const ForgotPasswordPage(),)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: AppColors.primary500,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: PurpleButtonWidget(text: "Log in", onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => const MainPage(),)) // () async {
              //   final email = emailController.text.trim();
              //   final password = passwordController.text.trim();
              //   final supabase = Supabase.instance.client;
                
              //   if (email.isEmpty || password.isEmpty) {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("Email and password are required")),
              //     );
              //     return;
              //   }

              //   try {
              //     // 1. Authenticate
              //     final res = await supabase.auth.signInWithPassword(
              //       email: email,
              //       password: password,
              //     );

              //     final userId = res.user?.id;
              //     if (userId == null) {
              //       throw Exception("User not found");
              //     }

              //     // 2. Fetch profile
              //     final profile = await supabase
              //         .from('user_profiles')
              //         .select()
              //         .eq('id', userId)
              //         .single();

              //     // 3. Save to Provider
              //     final authUser = res.user!.toJson();
              //     final userModel = UserModel.fromMap(authUser, profile);
              //     Provider.of<UserProvider>(context, listen: false).setUser(userModel);

              //     // 4. Navigate to main page
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => const MainPage()),
              //     );
              //   } catch (e) {
              //     print(e);
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("Login failed: $e")),
              //     );
              //   }
              // }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
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
                    "Sign Up",
                    style: TextStyle(
                      color: AppColors.primary500,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: AppColors.greyscale200),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or with",
                      style: TextStyle(
                        color: AppColors.greyscale500,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(height: 1, color: AppColors.greyscale200),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              spacing: 10,
              children: [
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(40),
                        side: BorderSide(
                          color: AppColors.greyscale200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google_logo.png",
                          height: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: AppColors.greyscale900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(40),
                        side: BorderSide(
                          color: AppColors.greyscale200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/apple_logo.png", height: 16),
                        SizedBox(width: 10),
                        Text(
                          "Sign in with Apple",
                          style: TextStyle(
                            color: AppColors.greyscale900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
