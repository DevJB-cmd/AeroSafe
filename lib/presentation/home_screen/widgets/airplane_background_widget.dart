import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Animated airplane background with particle effects
/// Creates subtle aerospace aesthetic for home screen
class AirplaneBackgroundWidget extends StatefulWidget {
  const AirplaneBackgroundWidget({super.key});

  @override
  State<AirplaneBackgroundWidget> createState() =>
      _AirplaneBackgroundWidgetState();
}

class _AirplaneBackgroundWidgetState extends State<AirplaneBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _AirplaneBackgroundPainter(
            progress: _animation.value,
            primaryColor: colorScheme.primary,
            accentColor: const Color(0xFF00C6FF),
          ),
          child: Container(),
        );
      },
    );
  }
}

class _AirplaneBackgroundPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color accentColor;

  _AirplaneBackgroundPainter({
    required this.progress,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw subtle radar lines
    final radarPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    // Animated radar circles
    for (int i = 0; i < 3; i++) {
      final radius = (size.width * 0.3 * (i + 1)) * progress;
      canvas.drawCircle(center, radius, radarPaint);
    }

    // Draw particle trails
    final particlePaint = Paint()
      ..color = accentColor.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 5; i++) {
      final angle = (progress * 2 * math.pi) + (i * math.pi / 2.5);
      final startX = center.dx + math.cos(angle) * size.width * 0.2;
      final startY = center.dy + math.sin(angle) * size.height * 0.2;
      final endX = center.dx + math.cos(angle) * size.width * 0.3;
      final endY = center.dy + math.sin(angle) * size.height * 0.3;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        particlePaint,
      );
    }

    // Draw grid pattern
    final gridPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.02)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AirplaneBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
