import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:flutter/material.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  List<String> categories = [
    "All",
    "Books",
    "Poems",
    "Special for you",
    "Stationary",
  ];
  int _selectedCategory = 0;
  List<List<dynamic>> vendors = [
    ["assets/images/vendor9.png", "Peleton", 4],
    ["assets/images/vendor8.png", "Jstor", 4],
    ["assets/images/vendor7.png", "Peppa Pig", 4],
    ["assets/images/vendor6.png", "Wattpad", 3],
    ["assets/images/vendor5.png", "Hobby Off", 3],
    ["assets/images/vendor4.png", "Koodo", 2],
    ["assets/images/vendor3.png", "GooDay", 4],
    ["assets/images/vendor2.png", "Kuromi", 5],
    ["assets/images/vendor1.gif", "Warehouse", 2],
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
        title: Text("Vendors", style: KtextStyles.heading),
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
            Text(
              "Our Vendors",
              style: TextStyle(color: AppColors.greyscale500, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Vendors",
              style: TextStyle(
                color: AppColors.primary500,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
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
                itemCount: vendors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Container(
                      height: 101,
                      decoration: BoxDecoration(
                        color: AppColors.greyscale50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(vendors.elementAt(index)[0]),
                      ),
                    ),
                    Text(
                      vendors.elementAt(index)[1],
                      style: TextStyle(
                        color: AppColors.greyscale900,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star,
                          size: 20,
                          color: i < vendors.elementAt(index)[2]
                              ? AppColors.yellow
                              : AppColors.greyscale900,
                        ),
                      ),
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
