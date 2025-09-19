import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({
    super.key,
    required this.bookImage,
    required this.title,
    required this.vendorImage,
    required this.description,
    required this.bookReview,
  });

  final String bookImage;
  final String title;
  final String vendorImage;
  final String description;
  final int bookReview;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
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
        title: Text("Book Details", style: KtextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset(
                  widget.bookImage,
                  height: 313,
                  width: 237,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: AppColors.greyscale900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset("assets/images/love.png"),
              ],
            ),
            Image.asset(widget.vendorImage, width: 79, fit: BoxFit.fitWidth),
            Text(
              widget.description,
              style: TextStyle(color: AppColors.greyscale500, fontSize: 14),
            ),
            SizedBox(height: 15),
            Text(
              "Reviews",
              style: TextStyle(
                color: AppColors.greyscale900,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Row(
              spacing: 5,
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 24,
                    color: index < widget.bookReview
                        ? AppColors.yellow
                        : AppColors.greyscale900,
                  ),
                ),
                Text(
                  "(${widget.bookReview}.0)",
                  style: TextStyle(color: AppColors.greyscale900, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 5,
                  child: PurpleButtonWidget(
                    text: "Add to Wishlist",
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PurpleButtonWidget(
                    text: "View Wishlist",
                    onPressed: () {},
                    isSwitched: true,
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
