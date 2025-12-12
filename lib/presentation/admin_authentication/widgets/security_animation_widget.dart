import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Security animation widget
/// Displays pulsating encryption visualization during authentication
class SecurityAnimationWidget extends StatefulWidget {
  const SecurityAnimationWidget({super.key});

  @override
  State<SecurityAnimationWidget> createState() =>
      _SecurityAnimationWidgetState();
}

class _SecurityAnimationWidgetState extends State<SecurityAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 15.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsating ring
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 25.w,
                      height: 25.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00C6FF)
                              .withValues(alpha: _opacityAnimation.value),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Middle ring
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_scaleAnimation.value - 1.0) * 0.5,
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00C6FF)
                              .withValues(alpha: _opacityAnimation.value * 0.7),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Center shield icon
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 8.w,
              color: const Color(0xFF00C6FF),
            ),
          ),
        ],
      ),
    );
  }
}
