import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/providers/user_provider.dart';
import 'package:bazar/views/pages/account_page.dart';
import 'package:bazar/views/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<List<dynamic>> settings = [
    [Icons.person, "My Account", const AccountPage()],
    [Icons.location_on, "Address", const AccountPage()],
    [Icons.fire_extinguisher, "Offers", const AccountPage()],
  ];
   @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Your Profile", style: KtextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.greyscale200, width: 1),
                  top: BorderSide(color: AppColors.greyscale200, width: 1),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/avatar.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.username ?? "Guest",
                      style: TextStyle(
                        color: AppColors.greyscale900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "(+213) 612345678",
                      style: TextStyle(
                        color: AppColors.greyscale500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                trailing: TextButton(
                  onPressed:() => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => SignInPage(),)),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => settings.elementAt(index)[2],
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary50,
                    ),
                    child: Icon(
                      settings.elementAt(index)[0],
                      color: AppColors.primary500,
                    ),
                  ),
                  title: Text(
                    settings.elementAt(index)[1],
                    style: TextStyle(
                      color: AppColors.greyscale900,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.greyscale500,
                    size: 16,
                  ),
                ),
                itemCount: settings.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
