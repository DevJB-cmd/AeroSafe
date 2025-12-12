import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Settings modal overlay for language, theme, and about
/// Implements glassmorphism with backdrop blur
class SettingsModalWidget extends StatefulWidget {
  final String currentLanguage;
  final ThemeMode currentTheme;
  final Function(String) onLanguageChanged;
  final Function(ThemeMode) onThemeChanged;

  const SettingsModalWidget({
    super.key,
    required this.currentLanguage,
    required this.currentTheme,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  State<SettingsModalWidget> createState() => _SettingsModalWidgetState();
}

class _SettingsModalWidgetState extends State<SettingsModalWidget> {
  String _getTitle() {
    if (widget.currentLanguage == 'fr') {
      return 'Paramètres';
    } else if (widget.currentLanguage == 'es') {
      return 'Configuración';
    } else {
      return 'Settings';
    }
  }

  String _getLanguageLabel() {
    if (widget.currentLanguage == 'fr') {
      return 'Langue';
    } else if (widget.currentLanguage == 'es') {
      return 'Idioma';
    } else {
      return 'Language';
    }
  }

  String _getThemeLabel() {
    if (widget.currentLanguage == 'fr') {
      return 'Thème';
    } else if (widget.currentLanguage == 'es') {
      return 'Tema';
    } else {
      return 'Theme';
    }
  }

  String _getAboutLabel() {
    if (widget.currentLanguage == 'fr') {
      return 'À propos';
    } else if (widget.currentLanguage == 'es') {
      return 'Acerca de';
    } else {
      return 'About';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    _getTitle(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: colorScheme.onSurface,
                      size: 24,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Language selection
            _buildSection(
              context,
              _getLanguageLabel(),
              [
                _buildLanguageOption(context, 'Français', 'fr'),
                _buildLanguageOption(context, 'English', 'en'),
                _buildLanguageOption(context, 'Español', 'es'),
              ],
            ),
            const SizedBox(height: 16),
            // Theme selection
            _buildSection(
              context,
              _getThemeLabel(),
              [
                _buildThemeOption(context, 'Light', ThemeMode.light),
                _buildThemeOption(context, 'Dark', ThemeMode.dark),
                _buildThemeOption(context, 'System', ThemeMode.system),
              ],
            ),
            const SizedBox(height: 16),
            // About section
            _buildAboutSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String label, String code) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = widget.currentLanguage == code;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onLanguageChanged(code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check',
                color: const Color(0xFF00C6FF),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String label, ThemeMode mode) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = widget.currentTheme == mode;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onThemeChanged(mode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check',
                color: const Color(0xFF00C6FF),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _getAboutLabel(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'AEROSAFE v1.0.0',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'ANAC Togo - Aviation Safety Reporting',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
