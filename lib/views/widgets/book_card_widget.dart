import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/views/pages/book_details_page.dart';
import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({
    super.key,
    required this.book,
    required this.imagewidth,
    this.bookId,
  });

  final List<dynamic> book;
  final double imagewidth;
  final String? bookId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(
            bookImage: book[0]?.toString() ?? 'assets/images/book1.png',
            title: book[1]?.toString() ?? 'Unknown Title',
            vendorImage: book[3]?.toString() ?? 'assets/images/vendor1.gif',
            description: book[4]?.toString() ?? 'No description available',
            bookReview: (book[5] as num?)?.toInt() ?? 0,
            bookId: bookId,
            price: book[2]?.toString() ?? '0.00',
          ),
        ),
      ),
      child: Container(
        width: imagewidth,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyscale200.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  book[0]?.toString() ?? 'assets/images/book1.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: AppColors.greyscale100,
                      child: Icon(
                        Icons.book,
                        color: AppColors.greyscale400,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      book[1]?.toString() ?? 'Unknown Title',
                      style: TextStyle(
                        color: AppColors.greyscale900,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${book[2]?.toString() ?? '0.00'}",
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
