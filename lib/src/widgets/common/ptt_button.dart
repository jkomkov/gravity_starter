import 'package:flutter/material.dart';
import '../../constants/app_constants.dart'; // Make sure constants are imported

// Enum to manage button states
enum PttState { idle, pressed, pulsating }

class PttButton extends StatefulWidget {
  const PttButton({super.key});

  @override
  State<PttButton> createState() => _PttButtonState();
}

class _PttButtonState extends State<PttButton> with TickerProviderStateMixin {
  PttState _currentState = PttState.idle;
  // Animation controllers
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _breatheController;
  late Animation<double> _breatheAnimation;
  // Timer for pulsating state duration
  Future<void>? _pulsatingTimeout;


  @override
  void initState() {
    super.initState();
    // Pulse animation (for pulsating state)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Breathe animation (for pressed state)
    _breatheController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _breatheAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut));

    // Start controllers stopped
    // _pulseController.stop(); // Not needed if not initially repeating
    // _breatheController.stop();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  // --- State Transition Logic ---
  void _handlePressStart() {
     _pulsatingTimeout?.ignore(); // Cancel any pending timeout to end pulsating
     _pulseController.stop(); // Stop pulsing animation
     _pulseAnimation.removeStatusListener(_onPulseComplete); // Clean listener just in case

    if (!mounted) return;
    // TODO: Start actual voice recognition service
    print("PTT Pressed");
    setState(() => _currentState = PttState.pressed);
    _breatheController.repeat(reverse: true); // Start breathing animation
  }

  void _handlePressEnd() {
     if (!mounted) return;
     _breatheController.stop(); // Stop breathing animation

    // TODO: Stop voice recognition, start processing simulation
    print("PTT Released, Pulsating...");
    setState(() => _currentState = PttState.pulsating);
    _pulseController.forward(); // Start pulse animation (forward then reverse)
    _pulseController.addStatusListener(_onPulseComplete); // Listen for completion


    // Simulate pulsating ends after a while
    _pulsatingTimeout = Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _currentState == PttState.pulsating) {
         print("Pulsating Finished");
        _pulseController.stop();
        _pulseAnimation.removeStatusListener(_onPulseComplete);
        setState(() => _currentState = PttState.idle);
      }
    });
  }

   // Make pulse animation repeat
  void _onPulseComplete(AnimationStatus status) {
      if (status == AnimationStatus.completed && _currentState == PttState.pulsating) {
         _pulseController.reverse();
      } else if (status == AnimationStatus.dismissed && _currentState == PttState.pulsating) {
         _pulseController.forward();
      }
  }

  // Determine gradient based on state
  Gradient _getGradient() {
    switch (_currentState) {
      case PttState.idle:
        return kPrimaryGradient; // Purple/Pink from constants
      case PttState.pressed:
        return kPressedGradient; // Pink/Red from constants
      case PttState.pulsating:
        return kPulseGradient; // Teal/Green from constants
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use GestureDetector for press/release handling
    return GestureDetector(
      onTapDown: (_) => _handlePressStart(),
      onTapUp: (_) => _handlePressEnd(),
      onTapCancel: _handlePressEnd, // End if tap is cancelled (e.g., drag off)
      child: AnimatedBuilder(
        // Listen to both animations to trigger rebuilds
        animation: Listenable.merge([_pulseAnimation, _breatheAnimation]),
        builder: (context, child) {
          double scale = 1.0;
          // Apply scale animation based on state
          if (_currentState == PttState.pulsating) {
             scale = _pulseAnimation.value;
          } else if (_currentState == PttState.pressed) {
             scale = 0.95; // Simple shrink when pressed
          }

          // Apply visual changes via Transform.scale and Container decoration
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: _getGradient(), // Dynamic gradient
                shape: BoxShape.circle,
                boxShadow: [ // Add subtle shadow
                  BoxShadow(
                    color: _getGradient().colors.last.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: (_currentState == PttState.pulsating ? scale - 1.0 : 0.0) * 15, // Pulse shadow slightly
                  ),
                ],
              ),
              child: Center(
                child: Transform.scale(
                   // Apply breathing scale only when pressed
                   scale: _currentState == PttState.pressed ? _breatheAnimation.value : 1.0,
                  child: const Icon(Icons.mic_none, color: Colors.white, size: 28),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}