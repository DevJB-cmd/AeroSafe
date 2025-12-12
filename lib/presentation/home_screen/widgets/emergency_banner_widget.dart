import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Emergency alert banner for critical incidents
/// Displays at top of screen with pulsating animation
class EmergencyBannerWidget extends StatefulWidget {
  final String message;
  final VoidCallback onTap;
  final String currentLanguage;

  const EmergencyBannerWidget({
    super.key,
    required this.message,
    required this.onTap,
    this.currentLanguage = 'fr',
  });

  @override
  State<EmergencyBannerWidget> createState() => _EmergencyBannerWidgetState();
}

class _EmergencyBannerWidgetState extends State<EmergencyBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getActionText() {
    if (widget.currentLanguage == 'fr') {
      return 'Voir les détails';
    } else if (widget.currentLanguage == 'es') {
      return 'Ver detalles';
    } else {
      return 'View details';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4757).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFF4757),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Pulsating background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFFF4757).withValues(
                        alpha: _pulseAnimation.value * 0.2,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'warning',
                    color: const Color(0xFFFF4757),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getActionText(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFFF4757),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    color: const Color(0xFFFF4757),
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
