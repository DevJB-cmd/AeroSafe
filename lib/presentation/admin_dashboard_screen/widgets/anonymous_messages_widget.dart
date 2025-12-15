import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget to display all anonymous messages received by ANAC admin
class AnonymousMessagesWidget extends StatefulWidget {
  const AnonymousMessagesWidget({super.key});

  @override
  State<AnonymousMessagesWidget> createState() =>
      _AnonymousMessagesWidgetState();
}

class _AnonymousMessagesWidgetState extends State<AnonymousMessagesWidget> {
  late AnonymousMessageService _messageService;

  @override
  void initState() {
    super.initState();
    _messageService = AnonymousMessageService();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final messages = _messageService.allMessages
        .where((msg) => !msg.isReporter)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'mail',
                      size: 6.w,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Messages Anonymes Reçus',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${messages.length}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '${_messageService.unreceivedMessages.length} non lus',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 0),

          // Messages list
          if (messages.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Center(
                child: Column(
                  children: [
                    CustomIconWidget(
                      iconName: 'inbox',
                      size: 12.w,
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Aucun message reçu',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messages.length,
              separatorBuilder: (context, index) => Divider(height: 0),
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUnread = !message.isReceived;

                return Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isUnread
                          ? theme.colorScheme.primary.withValues(alpha: 0.05)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isUnread
                            ? theme.colorScheme.primary.withValues(alpha: 0.2)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message header
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        message.agentId ?? 'Anonymous',
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                      SizedBox(width: 1.w),
                                      if (isUnread)
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    message.timestamp,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (message.isReceived)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.8.h),
                                decoration: BoxDecoration(
                                  color: AppTheme.successColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'check_circle',
                                      size: 4.w,
                                      color: AppTheme.successColor,
                                    ),
                                    SizedBox(width: 0.5.w),
                                    Text(
                                      'Reçu',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: AppTheme.successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Message content
                        Text(
                          message.message,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _messageService
                                      .markMessageAsReceived(message.id);
                                  setState(() {});
                                },
                                icon: CustomIconWidget(
                                  iconName: 'done_all',
                                  size: 4.w,
                                  color: theme.colorScheme.onPrimary,
                                ),
                                label: Text(message.isReceived
                                    ? 'Marqué comme reçu'
                                    : 'Marquer comme reçu'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: message.isReceived
                                      ? AppTheme.successColor.withValues(
                                          alpha: 0.2)
                                      : theme.colorScheme.primary,
                                  foregroundColor: message.isReceived
                                      ? AppTheme.successColor
                                      : theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 1.w),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Répondre au message
                              },
                              icon: CustomIconWidget(
                                iconName: 'reply',
                                size: 4.w,
                                color: theme.colorScheme.onSecondary,
                              ),
                              label: const Text('Répondre'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.secondary,
                                foregroundColor: theme.colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
