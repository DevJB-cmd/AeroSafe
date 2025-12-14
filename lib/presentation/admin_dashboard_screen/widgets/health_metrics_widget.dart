import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Health metrics section with circular progress gauges
class HealthMetricsWidget extends StatelessWidget {
  final double incidentTrendPercentage;
  final double responseTimePercentage;
  final double resolutionRatePercentage;

  const HealthMetricsWidget({
    super.key,
    required this.incidentTrendPercentage,
    required this.responseTimePercentage,
    required this.resolutionRatePercentage,
  });

  Widget _buildMetricGauge({
    required BuildContext context,
    required String title,
    required double percentage,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        CircularPercentIndicator(
          radius: 15.w,
          lineWidth: 2.w,
          percent: percentage / 100,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 9.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          progressColor: color,
          backgroundColor: color.withValues(alpha: 0.2),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animationDuration: 1200,
        ),
        SizedBox(height: 1.h),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
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
            children: [
              CustomIconWidget(
                iconName: 'health_and_safety',
                color: colorScheme.secondary,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Safety Culture Metrics',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildMetricGauge(
                  context: context,
                  title: 'Incident\nTrends',
                  percentage: incidentTrendPercentage,
                  color: AppTheme.successColor,
                ),
              ),
              Expanded(
                child: _buildMetricGauge(
                  context: context,
                  title: 'Response\nTime',
                  percentage: responseTimePercentage,
                  color: colorScheme.secondary,
                ),
              ),
              Expanded(
                child: _buildMetricGauge(
                  context: context,
                  title: 'Resolution\nRate',
                  percentage: resolutionRatePercentage,
                  color: AppTheme.warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
