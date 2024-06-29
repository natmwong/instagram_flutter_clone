import "package:flutter/material.dart";

class LikeAnimation extends StatefulWidget {
  final Widget child; // The child widget that will be animated
  final bool isAnimating; // Determines whether the animation should be triggered or not
  final Duration duration; // How long the like animation should run
  final VoidCallback? onEnd; // Called to enter the like animation
  final bool smallLike; // Checks if like was clicked

  // Constructor
  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    // Define the scale animation
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Start the animation if the 'isAnimating' property has changed
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  // Method to start the animation
  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward(); // Forward animation
      await controller.reverse(); // Reverse animation
      await Future.delayed(
        const Duration(
          milliseconds: 200,
        ),
      );

      // Call the 'onEnd' callback if provided
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the animation controller
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
