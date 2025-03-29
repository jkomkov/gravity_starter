import 'package:flutter/material.dart';
// *** FIX: Import the constants file ***
import '../../constants/app_constants.dart';

// General purpose Like Button (e.g., for detail screen actions)
// Manages its own state locally for the UI shell.
class LikeButton extends StatefulWidget {
  final String productId; // Needed to associate like with product eventually
  final double size;
  final bool initiallyLiked;

  const LikeButton({
    required this.productId,
    this.size = 24.0,
    this.initiallyLiked = false,
    super.key,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initiallyLiked;
    // In real app: fetch actual liked state from provider based on widget.productId
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    // In real app: Update the state via provider/service
    print('LikeButton: Product ${widget.productId} liked: $_isLiked');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.size,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: widget.size, minHeight: widget.size),
      splashRadius: widget.size,
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        // Use the imported constant now
        color: _isLiked ? kLikedColor : Colors.white,
      ),
      onPressed: _toggleLike,
      tooltip: _isLiked ? 'Unlike' : 'Like',
    );
  }
}


// Like Button specifically styled for the Product Tile overlay
// Manages its own state locally for the UI shell.
class TileLikeButton extends StatefulWidget {
  final String productId;
  final bool initiallyLiked;

  const TileLikeButton({
    required this.productId,
    this.initiallyLiked = false,
    super.key,
  });

  @override
  State<TileLikeButton> createState() => _TileLikeButtonState();
}

class _TileLikeButtonState extends State<TileLikeButton> {
  late bool _isLiked;

   @override
  void initState() {
    super.initState();
    _isLiked = widget.initiallyLiked;
     // In real app: fetch actual liked state from provider based on widget.productId
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
     // In real app: Update the state via provider/service
    print('TileLikeButton: Product ${widget.productId} liked: $_isLiked');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: RawMaterialButton(
        onPressed: _toggleLike,
        // Use the imported constant now
        fillColor: _isLiked ? kLikedColor : Colors.black.withOpacity(0.4), // Change background on like
        shape: const CircleBorder(),
        elevation: 1.0,
        constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
        child: Icon(
           _isLiked ? Icons.favorite : Icons.favorite_border,
           color: Colors.white,
           size: 18,
        ),
      ),
    );
  }
}