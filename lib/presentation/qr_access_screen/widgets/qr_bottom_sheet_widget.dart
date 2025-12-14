import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// QR Bottom Sheet Widget
/// Swipeable bottom sheet with demo toggle and manual entry options
class QrBottomSheetWidget extends StatefulWidget {
  final VoidCallback onManualEntry;
  final VoidCallback onDemoToggle;
  final bool isDemoMode;

  const QrBottomSheetWidget({
    super.key,
    required this.onManualEntry,
    required this.onDemoToggle,
    required this.isDemoMode,
  });

  @override
  State<QrBottomSheetWidget> createState() => _QrBottomSheetWidgetState();
}

class _QrBottomSheetWidgetState extends State<QrBottomSheetWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -5) {
          setState(() => _isExpanded = true);
        } else if (details.primaryDelta! > 5) {
          setState(() => _isExpanded = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: _isExpanded ? 35.h : 12.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3300C6FF),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Drag handle
            GestureDetector(
              onTap: _toggleExpanded,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Quick Actions',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),

                    // Demo mode toggle
                    _buildActionTile(
                      theme,
                      icon: widget.isDemoMode ? 'toggle_on' : 'toggle_off',
                      title: 'Demo Mode',
                      subtitle: widget.isDemoMode
                          ? 'Training mode active'
                          : 'Enable for training',
                      onTap: widget.onDemoToggle,
                      trailing: Switch(
                        value: widget.isDemoMode,
                        onChanged: (_) => widget.onDemoToggle(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Manual entry option
                    _buildActionTile(
                      theme,
                      icon: 'edit_location',
                      title: 'Manual Location Entry',
                      subtitle: 'Enter location code manually',
                      onTap: widget.onManualEntry,
                    ),

                    const SizedBox(height: 12),

                    // Help section
                    _buildActionTile(
                      theme,
                      icon: 'help_outline',
                      title: 'Need Help?',
                      subtitle: 'View QR scanning guide',
                      onTap: () => _showHelpDialog(context, theme),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build action tile
  Widget _buildActionTile(
    ThemeData theme, {
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: icon,
                  color: theme.colorScheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                trailing
              else
                CustomIconWidget(
                  iconName: 'chevron_right',
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show help dialog
  void _showHelpDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'help_outline',
              color: theme.colorScheme.secondary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'QR Scanning Guide',
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHelpItem(
                theme,
                '1. Position QR Code',
                'Center the QR code within the scanning frame on your screen.',
              ),
              const SizedBox(height: 12),
              _buildHelpItem(
                theme,
                '2. Ensure Good Lighting',
                'Make sure the area is well-lit. Use the torch button if needed.',
              ),
              const SizedBox(height: 12),
              _buildHelpItem(
                theme,
                '3. Hold Steady',
                'Keep your device steady for automatic detection.',
              ),
              const SizedBox(height: 12),
              _buildHelpItem(
                theme,
                '4. Demo Mode',
                'Enable demo mode for training with sample QR codes.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Got It',
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  /// Build help item
  Widget _buildHelpItem(ThemeData theme, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
