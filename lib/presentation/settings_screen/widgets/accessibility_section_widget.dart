import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Accessibility settings section with high contrast and reduced motion options
class AccessibilitySectionWidget extends StatelessWidget {
  final bool highContrastEnabled;
  final bool reducedMotionEnabled;
  final Function(bool) onHighContrastChanged;
  final Function(bool) onReducedMotionChanged;

  const AccessibilitySectionWidget({
    super.key,
    required this.highContrastEnabled,
    required this.reducedMotionEnabled,
    required this.onHighContrastChanged,
    required this.onReducedMotionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> accessibilityOptions = [
      {
        'title': 'High Contrast Mode',
        'description': 'Enhanced visibility for better readability',
        'icon': 'contrast',
        'value': highContrastEnabled,
        'onChange': onHighContrastChanged,
      },
      {
        'title': 'Reduced Motion',
        'description': 'Minimize animations and transitions',
        'icon': 'motion_photos_off',
        'value': reducedMotionEnabled,
        'onChange': onReducedMotionChanged,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Accessibility',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          ...accessibilityOptions.map((option) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: option['icon'] as String,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option['title'] as String,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          option['description'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: option['value'] as bool,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      (option['onChange'] as Function(bool))(value);
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
