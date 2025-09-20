import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> categories = [
    "All",
    "Books",
    "Poems",
    "Special for you",
    "Stationary",
  ];
  int _selectedCategory = 0;
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks({String? category}) async {
    setState(() {
      isLoading = true;
    });

    try {
      late List<Map<String, dynamic>> data;
      
      if (category == null || category == "All") {
        data = await supabase.from('books').select().order('created_at', ascending: false);
      } else {
        data = await supabase.from('books').select().eq('category', category).order('created_at', ascending: false);
      }

      // Convert to format expected by BookCardWidget
      final convertedBooks = data.map<Map<String, dynamic>>((book) {
        return {
          'id': book['id'],
          'image_url': book['image_url'] ?? 'assets/images/book1.png',
          'title': book['title'] ?? 'Unknown Title',
          'price': book['price']?.toString() ?? '0.00',
          'vendor_image': book['vendor_image'] ?? 'assets/images/vendor1.gif',
          'description': book['description'] ?? 'No description available',
          'review': book['review'] ?? 0,
          'category': book['category'] ?? 'Unknown',
        };
      }).toList();

      setState(() {
        books = convertedBooks;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching books: $e');
      setState(() {
        books = [];
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading books: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.search_outlined, color: AppColors.greyscale900, size: 30),
        ),
        title: Text("Category", style: KtextStyles.heading),
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
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                      _fetchBooks(category: categories[index]);
                    },
                    child: Text(
                      categories[index],
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
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: AppColors.primary500)
                    )
                  : books.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.library_books_outlined,
                                size: 64,
                                color: AppColors.greyscale300,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No books found",
                                style: TextStyle(
                                  color: AppColors.greyscale500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Try selecting a different category",
                                style: TextStyle(
                                  color: AppColors.greyscale400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          itemCount: books.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 200,
                          ),
                          itemBuilder: (context, index) {
                            final book = books[index];
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
          ],
        ),
      ),
    );
  }
}