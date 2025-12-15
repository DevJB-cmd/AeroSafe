import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Enhanced message bubble widget with message received button
class EnhancedMessageBubbleWidget extends StatefulWidget {
  final String message;
  final String timestamp;
  final bool isReporter;
  final String? agentId;
  final String messageId;
  final bool isReceived;
  final VoidCallback onMarkReceived;

  const EnhancedMessageBubbleWidget({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isReporter,
    this.agentId,
    required this.messageId,
    required this.isReceived,
    required this.onMarkReceived,
  });

  @override
  State<EnhancedMessageBubbleWidget> createState() =>
      _EnhancedMessageBubbleWidgetState();
}

class _EnhancedMessageBubbleWidgetState
    extends State<EnhancedMessageBubbleWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(widget.isReporter ? 0.2 : -0.2, 0),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: Row(
          mainAxisAlignment:
              widget.isReporter ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Message bubble
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: widget.isReporter
                      ? colorScheme.primary.withValues(alpha: 0.2)
                      : colorScheme.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(
                        widget.isReporter ? 16 : 4),
                    bottomRight: Radius.circular(
                        widget.isReporter ? 4 : 16),
                  ),
                  border: Border.all(
                    color: widget.isReporter
                        ? colorScheme.primary.withValues(alpha: 0.3)
                        : colorScheme.secondary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: widget.isReporter
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    // Agent ID if from agent
                    if (!widget.isReporter && widget.agentId != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 0.5.h),
                        child: Text(
                          'Agent ${widget.agentId!.split('-').last}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // Message text
                    Text(
                      widget.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    // Timestamp
                    Text(
                      widget.timestamp,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Message received button (only for agent messages to admin)
            if (!widget.isReporter)
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 0.5.h),
                child: GestureDetector(
                  onTap: widget.isReceived
                      ? null
                      : () {
                          HapticFeedback.lightImpact();
                          widget.onMarkReceived();
                        },
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isReceived
                          ? AppTheme.successColor.withValues(alpha: 0.2)
                          : colorScheme.surface,
                      border: Border.all(
                        color: widget.isReceived
                            ? AppTheme.successColor
                            : colorScheme.outline,
                        width: 2,
                      ),
                      boxShadow: widget.isReceived
                          ? [
                              BoxShadow(
                                color: AppTheme.successColor
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: widget.isReceived
                          ? CustomIconWidget(
                              iconName: 'check_circle',
                              size: 5.w,
                              color: AppTheme.successColor,
                            )
                          : CustomIconWidget(
                              iconName: 'radio_button_unchecked',
                              size: 5.w,
                              color: colorScheme.outline,
                            ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
