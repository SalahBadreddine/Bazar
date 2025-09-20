import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/views/pages/book_details_page.dart';
import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({super.key, required this.book, required this.imagewidth});

  final List<dynamic> book;
  final double imagewidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(
            bookImage: book[0],
            title: book[1],
            vendorImage: book[3],
            description: book[4],
            bookReview: book[5],
          ),
        ),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.asset(
              book[0],
              height: 150,
              width: imagewidth,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            book[1],
            style: TextStyle(
              color: AppColors.greyscale900,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Text(
            "\$${book[2]}",
            style: TextStyle(
              color: AppColors.primary500,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
