import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import './widgets/about_section_widget.dart';
import './widgets/accessibility_section_widget.dart';
import './widgets/language_section_widget.dart';
import './widgets/notifications_section_widget.dart';
import './widgets/security_section_widget.dart';
import './widgets/theme_section_widget.dart';

/// Settings Screen for AEROSAFE platform configuration
/// Provides comprehensive settings with aviation-themed professional interface
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings state
  String _selectedLanguage = 'fr';
  String _selectedTheme = 'dark';
  bool _biometricEnabled = true;
  bool _incidentAlertsEnabled = true;
  bool _chatMessagesEnabled = true;
  bool _systemUpdatesEnabled = false;
  bool _highContrastEnabled = false;
  bool _reducedMotionEnabled = false;
  bool _hasUnsavedChanges = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && _hasUnsavedChanges) {
          final shouldPop = await _showExitConfirmationDialog();
          if (shouldPop == true && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: 'Settings',
          automaticallyImplyLeading: true,
          actions: [
            if (_hasUnsavedChanges)
              IconButton(
                icon: CustomIconWidget(
                  iconName: 'save',
                  color: theme.colorScheme.secondary,
                  size: 24,
                ),
                onPressed: _saveSettings,
                tooltip: 'Save Changes',
              ),
            IconButton(
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                size: 24,
              ),
              onPressed: _showResetDialog,
              tooltip: 'Reset to Defaults',
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with AEROSAFE branding
                _buildHeader(theme),
                const SizedBox(height: 16),

                // Language & Region Section
                LanguageSectionWidget(
                  selectedLanguage: _selectedLanguage,
                  onLanguageChanged: (language) {
                    setState(() {
                      _selectedLanguage = language;
                      _hasUnsavedChanges = true;
                    });
                    _showChangeConfirmation(
                        'Language updated to ${_getLanguageName(language)}');
                  },
                ),

                // Appearance Section
                ThemeSectionWidget(
                  selectedTheme: _selectedTheme,
                  onThemeChanged: (theme) {
                    setState(() {
                      _selectedTheme = theme;
                      _hasUnsavedChanges = true;
                    });
                    _showChangeConfirmation(
                        'Theme updated to ${_getThemeName(theme)}');
                  },
                ),

                // Security Section
                SecuritySectionWidget(
                  biometricEnabled: _biometricEnabled,
                  onBiometricChanged: (enabled) {
                    setState(() {
                      _biometricEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                    _showChangeConfirmation(
                      enabled
                          ? 'Biometric authentication enabled'
                          : 'Biometric authentication disabled',
                    );
                  },
                  onChangePIN: _showChangePINDialog,
                ),

                // Notifications Section
                NotificationsSectionWidget(
                  incidentAlertsEnabled: _incidentAlertsEnabled,
                  chatMessagesEnabled: _chatMessagesEnabled,
                  systemUpdatesEnabled: _systemUpdatesEnabled,
                  onIncidentAlertsChanged: (enabled) {
                    setState(() {
                      _incidentAlertsEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                  },
                  onChatMessagesChanged: (enabled) {
                    setState(() {
                      _chatMessagesEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                  },
                  onSystemUpdatesChanged: (enabled) {
                    setState(() {
                      _systemUpdatesEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                  },
                ),

                // Accessibility Section
                AccessibilitySectionWidget(
                  highContrastEnabled: _highContrastEnabled,
                  reducedMotionEnabled: _reducedMotionEnabled,
                  onHighContrastChanged: (enabled) {
                    setState(() {
                      _highContrastEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                  },
                  onReducedMotionChanged: (enabled) {
                    setState(() {
                      _reducedMotionEnabled = enabled;
                      _hasUnsavedChanges = true;
                    });
                  },
                ),

                // About Section
                AboutSectionWidget(
                  onPrivacyPolicyTap: _showPrivacyPolicy,
                  onTermsOfServiceTap: _showTermsOfService,
                  onCryptographyExplanationTap: _showCryptographyExplanation,
                ),

                const SizedBox(height: 24),

                // Version Information
                _buildVersionInfo(theme),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.secondary,
                width: 2,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'flight_takeoff',
                color: theme.colorScheme.secondary,
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AEROSAFE',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Aviation Safety Reporting Platform',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo(ThemeData theme) {
    return Center(
      child: Column(
        children: [
          Text(
            'Version 1.0.0 (Build 2025.12.12)',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'verified',
                color: AppTheme.successColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'ANAC Togo Certified',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      default:
        return code;
    }
  }

  String _getThemeName(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'system':
        return 'System';
      default:
        return theme;
    }
  }

  void _showChangeConfirmation(String message) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  void _saveSettings() {
    HapticFeedback.mediumImpact();
    setState(() {
      _hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Settings saved successfully'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  Future<bool?> _showExitConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Unsaved Changes',
            style: theme.textTheme.titleLarge,
          ),
          content: Text(
            'You have unsaved changes. Do you want to save them before leaving?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                _saveSettings();
                Navigator.of(context).pop(true);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Reset to Defaults',
            style: theme.textTheme.titleLarge,
          ),
          content: Text(
            'This will reset all settings to their default values. This action cannot be undone.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorLight,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        _selectedLanguage = 'fr';
        _selectedTheme = 'dark';
        _biometricEnabled = true;
        _incidentAlertsEnabled = true;
        _chatMessagesEnabled = true;
        _systemUpdatesEnabled = false;
        _highContrastEnabled = false;
        _reducedMotionEnabled = false;
        _hasUnsavedChanges = false;
      });
      _showChangeConfirmation('Settings reset to defaults');
    }
  }

  Future<void> _showChangePINDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Change PIN Code',
            style: theme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter your current PIN to proceed with changing your admin access code.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Current PIN',
                  hintText: 'Enter 6-digit PIN',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showChangeConfirmation('PIN change feature coming soon');
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Privacy Policy',
            style: theme.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Text(
              'AEROSAFE is committed to protecting your anonymity. All incident reports are encrypted end-to-end using AES-256 encryption. No personally identifiable information is collected or stored. Your reports are identified only by cryptographic tokens that cannot be traced back to you.\n\nFor full privacy policy details, visit our website or contact ANAC Togo.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfService() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Terms of Service',
            style: theme.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Text(
              'By using AEROSAFE, you agree to:\n\n• Report incidents truthfully and accurately\n• Use the platform for aviation safety purposes only\n• Respect the confidentiality of other users\n• Comply with ANAC Togo regulations\n• Not misuse the anonymous reporting system\n\nViolations may result in access restrictions and legal action.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showCryptographyExplanation() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Cryptography Explanation',
            style: theme.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AEROSAFE uses military-grade encryption to protect your identity:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '• AES-256 Encryption: Your reports are encrypted with the same standard used by governments and military organizations.\n\n• Cryptographic Tokens: Each report generates a unique token that cannot be reverse-engineered to reveal your identity.\n\n• Zero-Knowledge Architecture: ANAC agents can read reports but cannot identify who submitted them.\n\n• Secure Communication: All chat messages are encrypted end-to-end.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
