import 'package:flutter/material.dart';

/// A reusable fade and slide-in animation widget.
///
/// Combines [FadeTransition] and [SlideTransition] for smooth,
/// professional entrance animations. Perfect for:
/// - Article headers
/// - Timeline nodes
/// - Images
/// - Diagram blocks
/// - Takeaway cards
///
/// Example:
/// ```dart
/// FadeSlideIn(
///   delay: Duration(milliseconds: 100),
///   child: MyWidget(),
/// )
/// ```
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.slideBegin = const Offset(-0.05, 0),
    this.slideEnd = Offset.zero,
  });

  /// Widget to animate in
  final Widget child;

  /// Delay before animation starts
  final Duration delay;

  /// Total animation duration
  final Duration duration;

  /// Starting position for slide (x, y offset)
  final Offset slideBegin;

  /// Ending position for slide (usually zero)
  final Offset slideEnd;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: widget.slideBegin,
      end: widget.slideEnd,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
