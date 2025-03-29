import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // For navigation

// Import project files
import '../constants/app_constants.dart';
import '../data/mock_data.dart'; // Use mock data directly
import '../models/shopping_frame.dart';
import '../routing/app_router.dart';
import '../widgets/common/header_app_bar.dart';
import '../widgets/common/ptt_button.dart';
import '../widgets/products/feed_title_navigation.dart';
import '../widgets/products/product_tile.dart';

class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  // Controllers for PageView and GridView scroll tracking
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();

  // State variables
  int _currentPageIndex = 0; // Track the currently visible frame/page
  double _scrollProgress = 0.0; // Track scroll progress (0.0 to 1.0) for progress bar

  // Mock data - in real app, this would come from a provider/state management
  final List<ShoppingFrame> _frames = mockShoppingFrames;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _scrollController.addListener(_scrollListener);

    // Listen to page changes to update the current index state
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPageIndex) {
        setState(() {
          _currentPageIndex = newPage;
           // Reset scroll position and progress when page changes via swipe
           if (_scrollController.hasClients) {
             _scrollController.jumpTo(0);
           }
           _scrollProgress = 0.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Listener to update scroll progress for the progress bar
  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      // Prevent updates if maxScroll is 0 (e.g., not enough content to scroll)
      if (maxScroll > 0) {
        setState(() {
          _scrollProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
        });
      } else if (_scrollProgress != 0.0) {
        // Reset progress if content becomes non-scrollable
        setState(() {
          _scrollProgress = 0.0;
        });
      }
    }
  }

  // Method to programmatically change the page (called by navigation buttons)
  void _navigateToFrame(int index) {
    if (index >= 0 && index < _frames.length) {
       // Update state first (important for FeedTitleNavigation update)
       setState(() {
         _currentPageIndex = index;
         // Reset scroll position and progress when page changes via button
          if (_scrollController.hasClients) {
           _scrollController.jumpTo(0);
         }
         _scrollProgress = 0.0;
       });
       // Then animate the page controller
      _pageController.animateToPage(
        index,
        duration: kMediumDuration, // Use constant
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress bar width (5% to 100%)
    final double progressWidthFactor = (0.05 + (_scrollProgress * 0.95)).clamp(0.05, 1.0);

    // Get the title of the currently visible frame
    final currentFrameTitle = _frames.isNotEmpty ? _frames[_currentPageIndex].title : "Loading...";

    return Scaffold(
      // Use the custom HeaderAppBar
      appBar: const HeaderAppBar(
        cartItemCount: 2, // Hardcoded count for UI shell visual
        onMenuPressed: null, // Define action later
      ),
      body: Column(
        children: [
          // --- Top Section (Progress & Feed Navigation) ---
          Padding(
            padding: const EdgeInsets.only(
              left: kAppPadding,
              right: kAppPadding,
              top: kAppGap / 2, // Less top padding
              bottom: kAppGap,
            ),
            child: Column(
              children: [
                // Simplified "Shopping For / View Toggle" Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Simplified text - replace with widgets if needed
                    const Text("Shopping for: Me", style: TextStyle(fontSize: 11, color: kMutedTextColor)),
                    IconButton(
                      icon: const Icon(Icons.grid_view_outlined, size: 18, color: kMutedTextColor),
                      tooltip: 'Toggle View',
                      onPressed: () { /* TODO: Implement view toggle */ },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  ],
                ),
                const SizedBox(height: kAppGap / 2),

                // Progress Bar Container
                Container(
                  height: 3,
                  clipBehavior: Clip.hardEdge, // Ensure inner container respects radius
                  decoration: BoxDecoration(
                    color: kBorderColor.withOpacity(0.5), // Slightly lighter background
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressWidthFactor, // Controlled by scroll progress
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: kPrimaryGradient, // Use constant
                        // Add subtle glow? Optional.
                         boxShadow: [
                           BoxShadow(
                             color: kSecondaryColor.withOpacity(0.5),
                             blurRadius: 4,
                             spreadRadius: 0,
                           ),
                         ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kAppGap),

                // Feed Title & Navigation Buttons
                FeedTitleNavigation(
                  title: currentFrameTitle,
                  currentIndex: _currentPageIndex,
                  itemCount: _frames.length,
                  onPrevious: _currentPageIndex > 0 ? () => _navigateToFrame(_currentPageIndex - 1) : null,
                  onNext: _currentPageIndex < _frames.length - 1 ? () => _navigateToFrame(_currentPageIndex + 1) : null,
                ),
              ],
            ),
          ),
          const Divider(height: 1), // Separator line

          // --- Main Content Area (Swipeable Product Grids) ---
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _frames.length,
              // onPageChanged handled by controller listener
              itemBuilder: (context, frameIndex) {
                final frame = _frames[frameIndex];
                // Build the grid for the current frame
                return GridView.builder(
                  key: PageStorageKey('grid_$frameIndex'), // Keep scroll position per page *if* using separate controllers
                  controller: _scrollController, // Use the single shared controller
                  padding: const EdgeInsets.only(
                    left: kAppPadding,
                    right: kAppPadding,
                    top: kAppGap,
                    bottom: 90, // Extra padding below grid for PTT button overlap
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Always 2 columns for now
                    crossAxisSpacing: kAppGap,
                    mainAxisSpacing: kAppGap,
                    childAspectRatio: 0.55, // Adjust this ratio based on desired tile Height/Width
                  ),
                  itemCount: frame.products.length,
                  itemBuilder: (context, productIndex) {
                    final product = frame.products[productIndex];
                    return ProductTile(
                      product: product,
                      itemNumber: productIndex + 1,
                      onTap: () {
                        // Navigate to Product Detail Screen using GoRouter
                        context.goNamed(
                          AppRoute.product.name,
                          pathParameters: {'id': product.id}, // Pass product ID
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Push-to-Talk Button
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 10.0), // Lift slightly above bottom bar
        child: PttButton(key: ValueKey('ptt_grid')), // Unique key
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position bottom right
    );
  }
}