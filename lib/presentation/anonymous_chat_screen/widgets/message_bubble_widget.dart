import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Message bubble widget for chat interface
/// Differentiates between reporter and ANAC agent messages
class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final String timestamp;
  final bool isReporter;
  final String? agentId;
  final VoidCallback? onLongPress;

  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isReporter,
    this.agentId,
    this.onLongPress,
  });

  void _showMessageOptions(BuildContext context) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'content_copy',
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
                title: Text(
                  'Copy Text',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: message));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Message copied to clipboard',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'flag',
                  color: AppTheme.warningColor,
                  size: 24,
                ),
                title: Text(
                  'Report Issue',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Issue reported to administrators',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'help_outline',
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                title: Text(
                  'Request Clarification',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Clarification request sent',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: isReporter ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(context),
        child: Container(
          constraints: BoxConstraints(maxWidth: 75.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            gradient: isReporter
                ? LinearGradient(
                    colors: [
                      colorScheme.secondary.withValues(alpha: 0.8),
                      colorScheme.secondary.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color:
                isReporter ? null : colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isReporter ? 16 : 4),
              topRight: Radius.circular(isReporter ? 4 : 16),
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            border: Border.all(
              color: isReporter
                  ? colorScheme.secondary.withValues(alpha: 0.3)
                  : colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    (isReporter ? colorScheme.secondary : colorScheme.primary)
                        .withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isReporter && agentId != null) ...[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        agentId!,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
              ],
              Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: isReporter
                      ? colorScheme.onSecondary
                      : colorScheme.onSurface,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'access_time',
                    color: (isReporter
                            ? colorScheme.onSecondary
                            : colorScheme.onSurface)
                        .withValues(alpha: 0.6),
                    size: 12,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    timestamp,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: (isReporter
                              ? colorScheme.onSecondary
                              : colorScheme.onSurface)
                          .withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
