import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:bazar/views/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bazar/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({
    super.key,
    required this.bookImage,
    required this.title,
    required this.vendorImage,
    required this.description,
    required this.bookReview,
    this.bookId,
    this.price,
  });

  final String bookImage;
  final String title;
  final String vendorImage;
  final String description;
  final int bookReview;
  final String? bookId;
  final String? price;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  bool isInWishlist = false;
  bool isLoading = false;
  String? actualBookId;

  @override
  void initState() {
    super.initState();
    _initializeBookData();
  }

  Future<void> _initializeBookData() async {
    // If bookId is provided, use it; otherwise find by title
    if (widget.bookId != null && widget.bookId!.isNotEmpty) {
      actualBookId = widget.bookId;
    } else {
      await _findBookByTitle();
    }
    
    if (actualBookId != null) {
      await _checkIfInWishlist();
    }
  }

  Future<void> _findBookByTitle() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('books')
          .select('id')
          .eq('title', widget.title)
          .maybeSingle();
      
      if (response != null) {
        actualBookId = response['id'] as String;
      }
    } catch (e) {
      print('Error finding book by title: $e');
    }
  }

  Future<void> _checkIfInWishlist() async {
    final supabase = Supabase.instance.client;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    if (userProvider.user == null || actualBookId == null) return;

    try {
      final response = await supabase
          .from('wishlists')
          .select('id')
          .eq('user_id', userProvider.user!.id)
          .eq('book_id', actualBookId!)
          .maybeSingle();

      if (mounted) {
        setState(() {
          isInWishlist = response != null;
        });
      }
    } catch (e) {
      print('Error checking wishlist status: $e');
    }
  }

  Future<void> _toggleWishlist() async {
    final supabase = Supabase.instance.client;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You must be logged in to add to wishlist'),
            backgroundColor: AppColors.red,
          ),
        );
      }
      return;
    }

    if (actualBookId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book not found'),
            backgroundColor: AppColors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (isInWishlist) {
        // Remove from wishlist
        await supabase
            .from('wishlists')
            .delete()
            .eq('user_id', userProvider.user!.id)
            .eq('book_id', actualBookId!);

        setState(() {
          isInWishlist = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed from wishlist'),
              backgroundColor: AppColors.greyscale600,
            ),
          );
        }
      } else {
        // Add to wishlist
        await supabase.from('wishlists').insert({
          'user_id': userProvider.user!.id,
          'book_id': actualBookId!,
        });

        setState(() {
          isInWishlist = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added to wishlist'),
              backgroundColor: AppColors.primary500,
            ),
          );
        }
      }
    } catch (e) {
      print('Error toggling wishlist: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString().contains('duplicate') ? 'Already in wishlist' : 'Something went wrong'}'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
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
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.bookImage,
                  height: 313,
                  width: 237,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 313,
                      width: 237,
                      decoration: BoxDecoration(
                        color: AppColors.greyscale100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.book,
                        color: AppColors.greyscale400,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: AppColors.greyscale900,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.price != null)
                        Text(
                          "\$${widget.price}",
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: isLoading ? null : _toggleWishlist,
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.primary500,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? AppColors.red : AppColors.greyscale400,
                          size: 28,
                        ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Image.asset(
              widget.vendorImage,
              width: 79,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 79,
                  height: 30,
                  color: AppColors.greyscale100,
                  child: Center(
                    child: Text(
                      'Vendor',
                      style: TextStyle(
                        color: AppColors.greyscale400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
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
                        : AppColors.greyscale300,
                  ),
                ),
                Text(
                  "(${widget.bookReview}.0)",
                  style: TextStyle(color: AppColors.greyscale900, fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 5,
                  child: PurpleButtonWidget(
                    text: isInWishlist ? "Remove from Wishlist" : "Add to Wishlist",
                    onPressed: isLoading ? () {} : _toggleWishlist,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PurpleButtonWidget(
                    text: "View Wishlist",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WishlistPage()),
                      );
                    },
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