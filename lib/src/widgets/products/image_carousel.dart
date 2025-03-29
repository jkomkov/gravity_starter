import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart'; // For fallback image URL

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final PageController controller; // Allow external control for indicators

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Use fallback if the list is somehow empty
    final displayUrls = imageUrls.isNotEmpty ? imageUrls : [kFallbackImageUrl];

    return Container(
      color: kSurfaceColor, // Background behind images
      child: PageView.builder(
        controller: controller,
        itemCount: displayUrls.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: displayUrls[index],
            fit: BoxFit.cover, // Cover the carousel area
            placeholder: (context, url) => const Center(
                child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 2))),
            errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.broken_image_outlined,
                    color: kMutedTextColor, size: 40)),
          );
        },
      ),
    );
  }
}