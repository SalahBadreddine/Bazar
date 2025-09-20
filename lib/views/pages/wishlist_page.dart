import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> favouritebooks = [
      ["assets/images/book1.png", "The Kite Runner", 21.99],
      ["assets/images/book4.png", "In in amet ultrices sit.", 19.99],
      ["assets/images/book5.png", "Bibendum facilisis.", 27.12],
      ["assets/images/book6.png", "Nulla et diam cras.", 13.52],
      ["assets/images/book2.jpg", "Risus malesuada in.", 15.00],
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.greyscale900, size: 30),
        ),
        title: Text("Your Wishlist", style: KtextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.asset(
                favouritebooks.elementAt(index)[0],
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favouritebooks.elementAt(index)[1],
                  style: TextStyle(
                    color: AppColors.greyscale900,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\$${favouritebooks.elementAt(index)[2]}",
                  style: TextStyle(
                    color: AppColors.primary500,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            trailing: Image.asset("assets/images/love.png"),
          ),
          separatorBuilder: (context, index) =>
              Divider(color: AppColors.greyscale200, thickness: 1),
          itemCount: favouritebooks.length,
        ),
      ),
    );
  }
}
