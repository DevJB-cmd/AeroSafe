import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Real-time incident feed with terminal-style interface
class IncidentFeedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> incidents;
  final Function(Map<String, dynamic>) onIncidentTap;
  final Function(Map<String, dynamic>) onIncidentLongPress;

  const IncidentFeedWidget({
    super.key,
    required this.incidents,
    required this.onIncidentTap,
    required this.onIncidentLongPress,
  });

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return AppTheme.errorLight;
      case 'high':
        return AppTheme.warningColor;
      case 'medium':
        return const Color(0xFF00C6FF);
      case 'low':
        return AppTheme.successColor;
      default:
        return AppTheme.neutralColor;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'in-flight':
        return 'flight';
      case 'runway':
        return 'local_airport';
      case 'baggage/equipment':
        return 'luggage';
      case 'behavior':
        return 'person_alert';
      case 'material':
        return 'build';
      case 'other':
        return 'more_horiz';
      default:
        return 'report_problem';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'feed',
                    color: colorScheme.secondary,
                    size: 6.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Live Incident Feed',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 2.w,
                      height: 2.w,
                      decoration: BoxDecoration(
                        color: AppTheme.successColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'LIVE',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          incidents.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Column(
                      children: [
                        CustomIconWidget(
                          iconName: 'inbox',
                          color: colorScheme.onSurfaceVariant,
                          size: 12.w,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No incidents reported',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: incidents.length > 5 ? 5 : incidents.length,
                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                  itemBuilder: (context, index) {
                    final incident = incidents[index];
                    final priority = incident['priority'] as String? ?? 'low';
                    final category = incident['category'] as String? ?? 'other';
                    final description =
                        incident['description'] as String? ?? '';

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onIncidentTap(incident);
                        },
                        onLongPress: () {
                          HapticFeedback.mediumImpact();
                          onIncidentLongPress(incident);
                        },
                        borderRadius: BorderRadius.circular(2.w),
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(2.w),
                            border: Border.all(
                              color: _getPriorityColor(priority)
                                  .withValues(alpha: 0.3),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(priority)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(1.w),
                                    ),
                                    child: CustomIconWidget(
                                      iconName: _getCategoryIcon(category),
                                      color: _getPriorityColor(priority),
                                      size: 5.w,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2.w,
                                                vertical: 0.5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    _getPriorityColor(priority)
                                                        .withValues(alpha: 0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1.w),
                                              ),
                                              child: Text(
                                                priority.toUpperCase(),
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: _getPriorityColor(
                                                      priority),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 8.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            Text(
                                              category,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: colorScheme.onSurface,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                      ],
                                    ),
                                  ),
                                  CustomIconWidget(
                                    iconName: 'chevron_right',
                                    color: colorScheme.onSurfaceVariant,
                                    size: 5.w,
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                description,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          if (incidents.length > 5) ...[
            SizedBox(height: 2.h),
            Center(
              child: TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Navigate to full incident list
                },
                child: Text(
                  'View All ${incidents.length} Incidents',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
