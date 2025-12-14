import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Dashboard header widget with agent ID, notifications, and logout
class DashboardHeaderWidget extends StatelessWidget {
  final String agentId;
  final int notificationCount;
  final VoidCallback onNotificationTap;
  final VoidCallback onLogoutTap;

  const DashboardHeaderWidget({
    super.key,
    required this.agentId,
    required this.notificationCount,
    required this.onNotificationTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // ANAC Logo and Agent ID
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                      color: colorScheme.secondary,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'ANAC',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'AEROSAFE',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        agentId,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 10.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Notification Bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onNotificationTap();
                  },
                  borderRadius: BorderRadius.circular(2.w),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    child: CustomIconWidget(
                      iconName: 'notifications_outlined',
                      color: colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 1.w,
                  top: 1.w,
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.errorLight,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.errorLight.withValues(alpha: 0.3),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(
                      minWidth: 4.w,
                      minHeight: 4.w,
                    ),
                    child: Center(
                      child: Text(
                        notificationCount > 99
                            ? '99+'
                            : notificationCount.toString(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onError,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 2.w),
          // Logout Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onLogoutTap();
              },
              borderRadius: BorderRadius.circular(2.w),
              child: Container(
                padding: EdgeInsets.all(2.w),
                child: CustomIconWidget(
                  iconName: 'logout',
                  color: AppTheme.errorLight,
                  size: 6.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
