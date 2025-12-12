import 'package:flutter/material.dart';

/// Welcome message widget with time-based greeting
/// Supports multiple languages (French, English, Spanish)
class WelcomeMessageWidget extends StatelessWidget {
  final String currentLanguage;

  const WelcomeMessageWidget({
    super.key,
    this.currentLanguage = 'fr',
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (currentLanguage == 'fr') {
      if (hour < 12) return 'Bonjour';
      if (hour < 18) return 'Bon après-midi';
      return 'Bonsoir';
    } else if (currentLanguage == 'es') {
      if (hour < 12) return 'Buenos días';
      if (hour < 18) return 'Buenas tardes';
      return 'Buenas noches';
    } else {
      if (hour < 12) return 'Good morning';
      if (hour < 18) return 'Good afternoon';
      return 'Good evening';
    }
  }

  String _getWelcomeText() {
    if (currentLanguage == 'fr') {
      return 'Bienvenue sur AEROSAFE';
    } else if (currentLanguage == 'es') {
      return 'Bienvenido a AEROSAFE';
    } else {
      return 'Welcome to AEROSAFE';
    }
  }

  String _getSubtitle() {
    if (currentLanguage == 'fr') {
      return 'Votre plateforme de signalement sécurisé';
    } else if (currentLanguage == 'es') {
      return 'Su plataforma de informes seguros';
    } else {
      return 'Your secure reporting platform';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getGreeting(),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getWelcomeText(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getSubtitle(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
