import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// QR Scanner Overlay Widget
/// Displays pulsating scan frame with corner guides and radar-style animation
class QrScannerOverlayWidget extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final bool isDemoMode;

  const QrScannerOverlayWidget({
    super.key,
    required this.pulseAnimation,
    required this.isDemoMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Stack(
        children: [
          // Cutout for scan area
          Center(
            child: AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: pulseAnimation.value,
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.secondary,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.secondary
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Corner guides
                        _buildCornerGuide(
                          theme,
                          Alignment.topLeft,
                          0,
                          0,
                        ),
                        _buildCornerGuide(
                          theme,
                          Alignment.topRight,
                          0,
                          0,
                        ),
                        _buildCornerGuide(
                          theme,
                          Alignment.bottomLeft,
                          0,
                          0,
                        ),
                        _buildCornerGuide(
                          theme,
                          Alignment.bottomRight,
                          0,
                          0,
                        ),

                        // Scanning line animation
                        _buildScanningLine(theme),

                        // Demo mode indicator
                        if (isDemoMode)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary
                                    .withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'DEMO MODE',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Radar circles
          Center(
            child: AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(80.w, 80.w),
                  painter: RadarPainter(
                    progress: pulseAnimation.value,
                    color: theme.colorScheme.secondary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build corner guide indicator
  Widget _buildCornerGuide(
    ThemeData theme,
    Alignment alignment,
    double top,
    double left,
  ) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            top: alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight
                ? BorderSide(color: theme.colorScheme.secondary, width: 4)
                : BorderSide.none,
            left: alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft
                ? BorderSide(color: theme.colorScheme.secondary, width: 4)
                : BorderSide.none,
            right: alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight
                ? BorderSide(color: theme.colorScheme.secondary, width: 4)
                : BorderSide.none,
            bottom: alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight
                ? BorderSide(color: theme.colorScheme.secondary, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// Build scanning line animation
  Widget _buildScanningLine(ThemeData theme) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        return Positioned(
          top: (pulseAnimation.value - 0.95) * 70.w / 0.1,
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.secondary,
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for radar-style concentric circles
class RadarPainter extends CustomPainter {
  final double progress;
  final Color color;

  RadarPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw 3 concentric circles
    for (int i = 1; i <= 3; i++) {
      final radius = maxRadius * (progress - 0.95) * 10 * i / 3;
      if (radius > 0 && radius <= maxRadius) {
        canvas.drawCircle(center, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
