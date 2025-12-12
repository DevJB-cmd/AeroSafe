import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmotionalStateSelector extends StatelessWidget {
  final String selectedEmotion;
  final Function(String) onEmotionSelected;

  const EmotionalStateSelector({
    super.key,
    required this.selectedEmotion,
    required this.onEmotionSelected,
  });

  static const List<Map<String, dynamic>> emotions = [
    {
      'emoji': '😌',
      'label': 'Calme',
      'value': 'calm',
      'color': Color(0xFF00D95A),
    },
    {
      'emoji': '😟',
      'label': 'Inquiet',
      'value': 'worried',
      'color': Color(0xFFFFB347),
    },
    {
      'emoji': '😠',
      'label': 'Frustré',
      'value': 'frustrated',
      'color': Color(0xFFFF8C42),
    },
    {
      'emoji': '😡',
      'label': 'En colère',
      'value': 'angry',
      'color': Color(0xFFFF4757),
    },
    {
      'emoji': '😰',
      'label': 'Stressé',
      'value': 'stressed',
      'color': Color(0xFFE74C3C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'mood',
                color: theme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'État émotionnel',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.errorLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Requis',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.errorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Comment vous sentiez-vous pendant l\'incident?',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: emotions.map((emotion) {
              final isSelected = selectedEmotion == emotion['value'];
              return _buildEmotionButton(
                context,
                theme,
                emotion,
                isSelected,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionButton(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> emotion,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        onEmotionSelected(emotion['value'] as String);
        HapticFeedback.lightImpact();
      },
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Column(
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? (emotion['color'] as Color).withValues(alpha: 0.2)
                    : theme.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? (emotion['color'] as Color)
                      : theme.colorScheme.outline.withValues(alpha: 0.3),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (emotion['color'] as Color)
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  emotion['emoji'] as String,
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              emotion['label'] as String,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? (emotion['color'] as Color)
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
