import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import package

// Import project files
import '../constants/app_constants.dart';
import '../data/mock_data.dart'; // Use mock data directly
import '../models/product.dart';
import '../routing/app_router.dart';
// Widgets used in this screen
import '../widgets/common/fixed_bottom_button.dart'; // Added Import
import '../widgets/common/gradient_text.dart';
import '../widgets/common/like_button.dart';
import '../widgets/common/ptt_button.dart';          // Added Import
import '../widgets/products/image_carousel.dart';
import '../widgets/products/product_detail_sections.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({required this.productId, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _carouselController = PageController();
  int _carouselPageIndex = 0; // Track current page for indicator

  Product? _product; // Holds the product data once found

  @override
  void initState() {
    super.initState();
    _findProduct(); // Find product data when screen initializes
    _carouselController.addListener(() {
       // Update page index for indicator when scrolled
       final newPage = _carouselController.page?.round() ?? 0;
       if (newPage != _carouselPageIndex && mounted) { // Check if mounted
          setState(() { _carouselPageIndex = newPage; });
       }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  // Find the product from mock data (synchronous for UI shell)
  void _findProduct() {
    Product? foundProduct;
    // Iterate through all frames to find the product by ID
    for (final frame in mockShoppingFrames) {
      try {
        foundProduct = frame.products.firstWhere((p) => p.id == widget.productId);
        break; // Exit loop once found
      } catch (e) {
        // Product not found in this frame, continue searching
      }
    }
    // Update state only if product found/not found status changes and widget is still mounted
     if (mounted && foundProduct != _product) {
       setState(() {
          _product = foundProduct;
       });
    } else if (mounted && foundProduct == null) {
       // Handle case where ID is invalid even after checking all frames
       print("Error: Product with ID ${widget.productId} not found in mock data.");
       // Optionally navigate back or show an error message within the widget
    }
  }

  // Placeholder action for review tag taps
  void _showReviewSnippets(BuildContext context, String tag) {
     // In real app: showModalBottomSheet or similar overlay
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Show reviews for: "$tag"'), duration: const Duration(seconds: 1)),
      );
      // TODO: Implement review snippet display logic
  }

  // Placeholder action for Add to Bag
  void _addToBagAction(BuildContext context, Product product) {
     // In real app: ref.read(cartProvider.notifier).addItem(product);
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.brand} added to bag (UI Shell)'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction( // Action to quickly view the bag
             label: 'View Bag',
             textColor: kSecondaryColor, // Use constant
             onPressed: () => context.goNamed(AppRoute.cart.name),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
     // --- Pre-calculate MediaQuery dependent values ---
     // Fix for "Not a constant expression" error
     final screenQuery = MediaQuery.of(context);
     final bottomSafePadding = screenQuery.padding.bottom; // System padding (e.g., home bar)
     final totalBottomPaddingForButtonArea = kAppPadding + bottomSafePadding;
     final pttButtonBottomOffset = 100 + bottomSafePadding;
     // --------------------------------------------------

     // Handle case where product is still null (e.g., ID not found after initState)
     if (_product == null) {
       return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(child: Text('Product ID "${widget.productId}" not found.'))
       );
     }
     // Product is guaranteed non-null from here
     final product = _product!;

     // Define image list for carousel dynamically (using product image + placeholders)
     final List<String> imageUrls = [
       product.imageUrl, // Primary image
       // Add more images if available in your Product model, otherwise use placeholders
       "https://media.neimanmarcus.com/f_auto,q_auto:low,ar_4:5,c_fill,dpr_2.0,w_418/01/nm_4954936_100380_b", // Placeholder back view
       "https://media.neimanmarcus.com/f_auto,q_auto:low,ar_4:5,c_fill,dpr_2.0,w_418/01/nm_4954936_100380_m", // Placeholder model view
     ].where((url) => url.isNotEmpty).toList(); // Ensure no empty URLs


    // Calculate approximate height for expanded SliverAppBar based on screen height
    final double carouselHeight = screenQuery.size.height * 0.55; // Use 55% of screen height


    return Scaffold(
      // Using Stack to layer scrolling content and fixed buttons
      body: Stack(
        children: [
          // --- Scrolling Content ---
          CustomScrollView(
            slivers: [
              // --- Collapsing App Bar with Image Carousel ---
              SliverAppBar(
                leading: IconButton( // Custom styled Back Button
                  icon: Container(
                     width: 36, height: 36,
                     decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.3), // Semi-transparent background
                         shape: BoxShape.circle),
                     child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white)
                   ),
                  onPressed: () => context.pop(),
                  tooltip: 'Back',
                ),
                // Use GradientText for the title
                title: const GradientText('GRAVITY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2)),
                centerTitle: true,
                backgroundColor: kBackgroundColor, // Base background
                surfaceTintColor: kBackgroundColor, // Prevent M3 tinting on scroll
                pinned: true, // Keep AppBar visible when collapsed
                expandedHeight: carouselHeight, // Set dynamic height
                stretch: true, // Allow stretching image on overscroll
                // Content that collapses
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero( // Wrap carousel for transition animation
                     tag: 'product_image_${product.id}', // Use unique tag matching ProductTile
                     child: ImageCarousel(
                       imageUrls: imageUrls,
                       controller: _carouselController, // Link controller
                     ),
                   ),
                  stretchModes: const [StretchMode.zoomBackground], // Effect on overscroll
                ),
                // Actions in the AppBar
                actions: [
                  // Like Button
                  Container( // Wrap icon buttons in containers for background effect
                    margin: const EdgeInsets.only(right: 4),
                    width: 36, height: 36,
                     decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.3), // Match back button background
                         shape: BoxShape.circle),
                    child: LikeButton( // Use standard LikeButton here
                       productId: product.id,
                       size: 20, // Adjust icon size if needed
                       // Set initial state based on mock data or future provider
                       initiallyLiked: product.id == 'r2',
                    )
                  ),
                  // Cart Button with Badge
                   Padding(
                      padding: const EdgeInsets.only(right: kAppPadding - 8), // Adjust padding
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container( // Background container
                             width: 36, height: 36,
                             decoration: BoxDecoration(
                               color: Colors.black.withOpacity(0.3),
                               shape: BoxShape.circle),
                             child: IconButton( // Actual button
                               padding: EdgeInsets.zero,
                               icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.white),
                               tooltip: 'Shopping Bag',
                               onPressed: () => context.goNamed(AppRoute.cart.name),
                             ),
                          ),
                          // Dummy Badge - In real app, watch cart provider count
                          Positioned(
                            top: 6, right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: kSecondaryColor, shape: BoxShape.circle,
                                border: Border.all(color: kBackgroundColor, width: 1.5)
                              ),
                              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                              child: const Text('2', // Hardcoded count for UI Shell
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // --- Carousel Indicator (Below AppBar) ---
              SliverToBoxAdapter(
                child: Container(
                  color: kBackgroundColor, // Match background
                  padding: const EdgeInsets.symmetric(vertical: kAppGap * 0.75),
                  child: Center(
                    // Use SmoothPageIndicator package
                    child: SmoothPageIndicator(
                      controller: _carouselController, // Link controller
                      count: imageUrls.length, // Number of pages
                      effect: const WormEffect( // Example effect
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.white,
                        dotColor: kMutedTextColor, // Use constant
                        spacing: 10,
                      ),
                    ),
                  ),
                ),
              ),

              // --- Main Content Sections (using placeholder widgets) ---
              SliverPadding(
                // Add horizontal padding to the content area
                padding: const EdgeInsets.symmetric(horizontal: kAppPadding),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: kAppGap), // Space below indicator
                      ProductInfoSection(product: product),
                      const SizedBox(height: kAppGap * 1.5),
                      const RecommendedFitSection(),
                      const SizedBox(height: kAppGap * 1.5),
                      const TryOnButton(),
                      const SizedBox(height: kAppGap * 1.5),
                      const HighlightsSection(),
                      const SizedBox(height: kAppGap * 1.5),
                      ReviewsSection(
                        // Pass the placeholder callback for tag taps
                        onTagTap: (tag) => _showReviewSnippets(context, tag),
                      ),
                      // Add enough bottom padding inside the scroll view
                      // to ensure content can scroll fully above the fixed buttons + system padding
                      SizedBox(height: 130 + bottomSafePadding),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // --- Fixed Add to Bag Button Area (bottom layer) ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // Add padding respecting safe area (home bar etc)
              padding: EdgeInsets.only(
                  left: kAppPadding,
                  right: kAppPadding,
                  top: kAppPadding,
                  bottom: totalBottomPaddingForButtonArea // Use pre-calculated value
              ),
              // Add background decoration for visibility
              decoration: BoxDecoration(
                color: kBackgroundColor.withOpacity(0.95), // Semi-transparent
                 border: const Border(top: BorderSide(color: kBorderColor)),
                 boxShadow: [ BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)]
              ),
              child: FixedBottomButton(
                label: 'Add to Bag',
                onPressed: () => _addToBagAction(context, product), // Simulate add
                icon: Icons.add_shopping_cart_outlined,
              ),
            ),
          ),

           // --- PTT Button (above Add to Bag) ---
           Positioned(
              // Use pre-calculated offset from bottom
              bottom: pttButtonBottomOffset,
              right: kAppPadding,
              // Use unique ValueKey if state needs preservation across rebuilds
              child: PttButton(key: ValueKey('ptt_detail_${product.id}')),
           ),
        ],
      ),
    );
  }
}