import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/vendors_page.dart';
import 'package:bazar/views/widgets/book_card_widget.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(initialPage: 0);
  final supabase = Supabase.instance.client;
  
  List<dynamic> topbooks = [];
  bool isLoadingBooks = true;
  
  List<String> bestvendors = [
    "assets/images/vendor1.gif",
    "assets/images/vendor2.png",
    "assets/images/vendor3.png",
    "assets/images/vendor4.png",
    "assets/images/vendor5.png",
  ];
  
  List<List<String>> authors = [
    ["assets/images/author1.png", "John Freeman", "Writer"],
    ["assets/images/author2.png", "Tess Gunty", "Novelist"],
    ["assets/images/author3.png", "Richard Perston", "Writer"],
  ];

  @override
  void initState() {
    super.initState();
    _fetchTopBooks();
  }

  Future<void> _fetchTopBooks() async {
    setState(() {
      isLoadingBooks = true;
    });

    try {
      // Fetch books with high reviews for "Top of Week"
      final data = await supabase
          .from('books')
          .select()
          .gte('review', 4) // Get books with 4+ star reviews
          .limit(6);

      // Convert database format to match existing book card widget expectations
      final convertedBooks = data.map((book) => {
        'id': book['id'],
        'title': book['title'],
        'price': book['price'].toString(),
        'description': book['description'],
        'image_url': book['image_url'],
        'vendor_image': book['vendor_image'],
        'review': book['review'],
        'category': book['category'],
      }).toList();

      setState(() {
        topbooks = convertedBooks;
        isLoadingBooks = false;
      });
    } catch (e) {
      print('Error fetching top books: $e');
      // Fallback to hardcoded data if database fails
      setState(() {
        topbooks = [
          {
            'id': null,
            'image_url': "assets/images/book1.png",
            'title': "The Kite Runner",
            'price': "14.99",
            'vendor_image': "assets/images/vendor3.png",
            'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.",
            'review': 4,
          },
          {
            'id': null,
            'image_url': "assets/images/book2.jpg",
            'title': "The Subtle Art",
            'price': "20.99",
            'vendor_image': "assets/images/vendor2.png",
            'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.",
            'review': 3,
          },
          {
            'id': null,
            'image_url': "assets/images/book3.jpg",
            'title': "The Art Of War",
            'price': "10.99",
            'vendor_image': "assets/images/vendor4.png",
            'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.",
            'review': 5,
          },
        ];
        isLoadingBooks = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.search_outlined,
          color: AppColors.greyscale900,
          size: 30,
        ),
        title: Text("Home", style: KtextStyles.heading),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          Icon(
            Icons.notifications_outlined,
            color: AppColors.greyscale900,
            size: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Column(
                spacing: 10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Special Offer",
                                style: TextStyle(
                                  color: AppColors.greyscale900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Discount 25%",
                                style: TextStyle(
                                  color: AppColors.greyscale900,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(
                                width: 150,
                                padding: EdgeInsets.only(top: 20),
                                child: PurpleButtonWidget(
                                  text: "Order Now",
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          "assets/images/offers1.jpg",
                          width: 99,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: AppColors.primary500,
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: AppColors.greyscale200,
                      spacing: 6,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Of Week
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top of Week",
                        style: TextStyle(
                          color: AppColors.greyscale900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoadingBooks
                      ? Container(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.primary500),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 10,
                            children: List.generate(
                              topbooks.length,
                              (index) {
                                final book = topbooks[index];
                                return BookCardWidget(
                                  book: [
                                    book['image_url'],
                                    book['title'],
                                    book['price'],
                                    book['vendor_image'],
                                    book['description'],
                                    book['review'],
                                  ],
                                  imagewidth: 127,
                                  bookId: book['id'],
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
              // Best Vendors
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best Vendors",
                        style: TextStyle(
                          color: AppColors.greyscale900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VendorsPage(),
                          ),
                        ),
                        child: Text(
                          "See all",
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: List.generate(
                        bestvendors.length,
                        (index) => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.greyscale50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(bestvendors.elementAt(index)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Authors
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Authors",
                        style: TextStyle(
                          color: AppColors.greyscale900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 30,
                      children: List.generate(
                        authors.length,
                        (index) => Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 102,
                              height: 102,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    authors.elementAt(index)[0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              authors.elementAt(index)[1],
                              style: TextStyle(
                                color: AppColors.greyscale900,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              authors.elementAt(index)[2],
                              style: TextStyle(
                                color: AppColors.greyscale500,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}