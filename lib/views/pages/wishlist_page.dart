import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/providers/user_provider.dart';
import 'package:bazar/views/pages/book_details_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> wishlistItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      if (userProvider.user == null) {
        setState(() {
          wishlistItems = [];
          isLoading = false;
        });
        return;
      }

      final userId = userProvider.user!.id;

      final List<Map<String, dynamic>> data = await supabase
          .from('wishlists')
          .select('''
            id,
            book_id,
            created_at,
            books (
              id,
              title,
              price,
              description,
              image_url,
              vendor_image,
              review,
              category
            )
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      setState(() {
        wishlistItems = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching wishlist: $e');
      setState(() {
        wishlistItems = [];
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading wishlist: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _removeFromWishlist(String wishlistId, String bookTitle) async {
    try {
      await supabase.from('wishlists').delete().eq('id', wishlistId);
      
      setState(() {
        wishlistItems.removeWhere((item) => item['id'] == wishlistId);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed "$bookTitle" from wishlist'),
            backgroundColor: AppColors.greyscale600,
          ),
        );
      }
    } catch (e) {
      print('Error removing from wishlist: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error removing item: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _clearAllWishlist() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user == null) return;

    try {
      await supabase
          .from('wishlists')
          .delete()
          .eq('user_id', userProvider.user!.id);
      
      setState(() {
        wishlistItems = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wishlist cleared'),
            backgroundColor: AppColors.greyscale600,
          ),
        );
      }
    } catch (e) {
      print('Error clearing wishlist: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error clearing wishlist: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppColors.greyscale300,
          ),
          SizedBox(height: 20),
          Text(
            "Your wishlist is empty",
            style: TextStyle(
              color: AppColors.greyscale500,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add books you love to see them here",
            style: TextStyle(
              color: AppColors.greyscale400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.login,
            size: 80,
            color: AppColors.greyscale300,
          ),
          SizedBox(height: 20),
          Text(
            "Please log in to view your wishlist",
            style: TextStyle(
              color: AppColors.greyscale500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item) {
    final book = item['books'] as Map<String, dynamic>;
    final wishlistId = item['id'] as String;
    
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.greyscale100, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                bookImage: book['image_url']?.toString() ?? 'assets/images/book1.png',
                title: book['title']?.toString() ?? 'Unknown Title',
                vendorImage: book['vendor_image']?.toString() ?? 'assets/images/vendor1.gif',
                description: book['description']?.toString() ?? 'No description available',
                bookReview: (book['review'] as num?)?.toInt() ?? 0,
                bookId: book['id']?.toString(),
                price: book['price']?.toString() ?? '0.00',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book['image_url']?.toString() ?? 'assets/images/book1.png',
                  height: 80,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.greyscale100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.book,
                        color: AppColors.greyscale400,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title']?.toString() ?? 'Unknown Title',
                      style: TextStyle(
                        color: AppColors.greyscale900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "\${book['price']?.toString() ?? '0.00'}",
                      style: TextStyle(
                        color: AppColors.primary500,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (starIndex) => Icon(
                            Icons.star,
                            size: 16,
                            color: starIndex < ((book['review'] as num?)?.toInt() ?? 0)
                                ? AppColors.yellow
                                : AppColors.greyscale300,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "(${(book['review'] as num?)?.toInt() ?? 0}.0)",
                          style: TextStyle(
                            color: AppColors.greyscale500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    if (book['category'] != null) ...[
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          book['category'].toString(),
                          style: TextStyle(
                            color: AppColors.primary500,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _removeFromWishlist(
                  wishlistId,
                  book['title']?.toString() ?? 'Unknown Title',
                ),
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.red,
                  size: 24,
                ),
                tooltip: 'Remove from wishlist',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Your Wishlist", style: KtextStyles.heading),
        actions: [
          if (wishlistItems.isNotEmpty && !isLoading)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Clear Wishlist"),
                    content: Text("Are you sure you want to remove all items from your wishlist?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _clearAllWishlist();
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Clear All",
                style: TextStyle(
                  color: AppColors.primary500,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchWishlist,
        color: AppColors.primary500,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.primary500),
              )
            : userProvider.user == null
                ? _buildLoginPrompt()
                : wishlistItems.isEmpty
                    ? _buildEmptyState()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${wishlistItems.length} ${wishlistItems.length == 1 ? 'item' : 'items'}",
                                  style: TextStyle(
                                    color: AppColors.greyscale500,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) => _buildWishlistItem(wishlistItems[index]),
                              separatorBuilder: (context, index) => SizedBox(height: 12),
                              itemCount: wishlistItems.length,
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}