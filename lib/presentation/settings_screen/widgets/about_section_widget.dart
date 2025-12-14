import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';

/// About section with ANAC certification and documentation links
class AboutSectionWidget extends StatelessWidget {
  final VoidCallback onPrivacyPolicyTap;
  final VoidCallback onTermsOfServiceTap;
  final VoidCallback onCryptographyExplanationTap;

  const AboutSectionWidget({
    super.key,
    required this.onPrivacyPolicyTap,
    required this.onTermsOfServiceTap,
    required this.onCryptographyExplanationTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> aboutOptions = [
      {
        'title': 'ANAC Togo Certification',
        'description': 'Official aviation authority endorsement',
        'icon': 'verified',
        'color': AppTheme.successColor,
        'onTap': null,
      },
      {
        'title': 'Privacy Policy',
        'description': 'How we protect your anonymity',
        'icon': 'privacy_tip',
        'color': theme.colorScheme.secondary,
        'onTap': onPrivacyPolicyTap,
      },
      {
        'title': 'Terms of Service',
        'description': 'Platform usage guidelines',
        'icon': 'description',
        'color': theme.colorScheme.primary,
        'onTap': onTermsOfServiceTap,
      },
      {
        'title': 'Cryptography Explanation',
        'description': 'Understanding our security protocols',
        'icon': 'security',
        'color': AppTheme.warningColor,
        'onTap': onCryptographyExplanationTap,
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
              'About',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          ...aboutOptions.map((option) {
            final hasAction = option['onTap'] != null;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: hasAction
                    ? () {
                        HapticFeedback.lightImpact();
                        (option['onTap'] as VoidCallback)();
                      }
                    : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          color:
                              (option['color'] as Color).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: option['icon'] as String,
                            color: option['color'] as Color,
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
                      if (hasAction)
                        CustomIconWidget(
                          iconName: 'chevron_right',
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
