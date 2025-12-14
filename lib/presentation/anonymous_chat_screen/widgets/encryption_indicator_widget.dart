import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Encryption status indicator widget
class EncryptionIndicatorWidget extends StatelessWidget {
  final bool isEncrypted;

  const EncryptionIndicatorWidget({
    super.key,
    required this.isEncrypted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: isEncrypted
            ? colorScheme.secondary.withValues(alpha: 0.1)
            : colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isEncrypted
              ? colorScheme.secondary.withValues(alpha: 0.3)
              : colorScheme.error.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: isEncrypted ? 'lock' : 'lock_open',
            color: isEncrypted ? colorScheme.secondary : colorScheme.error,
            size: 14,
          ),
          SizedBox(width: 1.5.w),
          Text(
            isEncrypted ? 'End-to-End Encrypted' : 'Not Encrypted',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: isEncrypted ? colorScheme.secondary : colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
