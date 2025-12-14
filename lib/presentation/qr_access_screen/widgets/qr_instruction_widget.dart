import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// QR Instruction Widget
/// Displays instructional text with aviation iconography
class QrInstructionWidget extends StatelessWidget {
  final bool isDemoMode;

  const QrInstructionWidget({
    super.key,
    required this.isDemoMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3300C6FF),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'qr_code_scanner',
                color: theme.colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  isDemoMode
                      ? 'Demo Mode Active - Training QR Codes'
                      : 'Position QR Code Within Frame',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isDemoMode
                ? 'Use generated demo codes for training purposes. Real incident reporting requires actual location QR codes.'
                : 'Align the QR code with the scanning frame. The camera will automatically detect and process the code.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInstructionItem(
                theme,
                'center_focus_strong',
                'Center',
              ),
              SizedBox(width: 6.w),
              _buildInstructionItem(
                theme,
                'light_mode',
                'Good Light',
              ),
              SizedBox(width: 6.w),
              _buildInstructionItem(
                theme,
                'straighten',
                'Hold Steady',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build individual instruction item
  Widget _buildInstructionItem(
    ThemeData theme,
    String iconName,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: iconName,
            color: theme.colorScheme.secondary,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
