import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  static const String lorem =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.";
  List<String> categories = [
    "All",
    "Books",
    "Poems",
    "Special for you",
    "Stationary",
  ];
  int _selectedCategory = 0;
  List<List<dynamic>> books = [
    [
      "assets/images/book1.png",
      "The Kite Runner",
      "14.99",
      "assets/images/vendor3.png",
      lorem,
      4
    ],
    ["assets/images/book2.jpg", "The Subtle Art", "20.99", "assets/images/vendor2.png", lorem, 3],
    ["assets/images/book3.jpg", "The Art Of War", "10.99",  "assets/images/vendor4.png",
      lorem,
      5],
  ];

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
        title: Text("Category", style: KtextStyles.heading),
        actions: [
          Icon(Icons.search_outlined, color: AppColors.greyscale900, size: 30),
        ],
        actionsPadding: EdgeInsets.only(right: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 25,
                children: List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() {
                      _selectedCategory = index;
                    }),
                    child: Text(
                      categories.elementAt(index),
                      style: _selectedCategory == index
                          ? TextStyle(
                              color: AppColors.greyscale900,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.greyscale900,
                            )
                          : TextStyle(
                              color: AppColors.greyscale500,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) => BookCardWidget(book: books.elementAt(index), imagewidth: 127,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
