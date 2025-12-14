import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';

/// Notification preferences section with granular controls
class NotificationsSectionWidget extends StatelessWidget {
  final bool incidentAlertsEnabled;
  final bool chatMessagesEnabled;
  final bool systemUpdatesEnabled;
  final Function(bool) onIncidentAlertsChanged;
  final Function(bool) onChatMessagesChanged;
  final Function(bool) onSystemUpdatesChanged;

  const NotificationsSectionWidget({
    super.key,
    required this.incidentAlertsEnabled,
    required this.chatMessagesEnabled,
    required this.systemUpdatesEnabled,
    required this.onIncidentAlertsChanged,
    required this.onChatMessagesChanged,
    required this.onSystemUpdatesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> notificationOptions = [
      {
        'title': 'Incident Alerts',
        'description': 'Critical safety incidents and emergency notifications',
        'icon': 'warning',
        'value': incidentAlertsEnabled,
        'onChange': onIncidentAlertsChanged,
        'color': AppTheme.warningColor,
      },
      {
        'title': 'Chat Messages',
        'description': 'New messages from ANAC agents',
        'icon': 'chat_bubble',
        'value': chatMessagesEnabled,
        'onChange': onChatMessagesChanged,
        'color': theme.colorScheme.secondary,
      },
      {
        'title': 'System Updates',
        'description': 'Platform updates and maintenance notifications',
        'icon': 'system_update',
        'value': systemUpdatesEnabled,
        'onChange': onSystemUpdatesChanged,
        'color': theme.colorScheme.primary,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Notifications',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          ...notificationOptions.map((option) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (option['color'] as Color).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: option['icon'] as String,
                        color: option['color'] as Color,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option['title'] as String,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          option['description'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: option['value'] as bool,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      (option['onChange'] as Function(bool))(value);
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
