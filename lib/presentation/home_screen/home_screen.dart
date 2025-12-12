import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/action_card_widget.dart';
import './widgets/airplane_background_widget.dart';
import './widgets/emergency_banner_widget.dart';
import './widgets/settings_modal_widget.dart';
import './widgets/welcome_message_widget.dart';

/// Home Screen - Intelligent choice interface for AEROSAFE
/// Enables aviation professionals to select primary navigation path
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _currentLanguage = 'fr';
  ThemeMode _currentTheme = ThemeMode.system;
  bool _hasEmergencyAlert = false;
  bool _isOnline = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _checkConnectivity();
    _checkEmergencyAlerts();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOut,
      ),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLanguage = prefs.getString('language') ?? 'fr';
      final themeString = prefs.getString('theme') ?? 'system';
      _currentTheme = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == 'ThemeMode.$themeString',
        orElse: () => ThemeMode.system,
      );
    });
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() => _currentLanguage = language);
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme.toString().split('.').last);
    setState(() => _currentTheme = theme);
  }

  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() => _isOnline = true);
  }

  void _checkEmergencyAlerts() {
    // Simulate emergency alert check
    setState(() => _hasEmergencyAlert = false);
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.mediumImpact();
    _checkConnectivity();
    _checkEmergencyAlerts();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _showSettings() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SettingsModalWidget(
        currentLanguage: _currentLanguage,
        currentTheme: _currentTheme,
        onLanguageChanged: _saveLanguage,
        onThemeChanged: _saveTheme,
      ),
    );
  }

  void _navigateToAnonymousReporting() {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/incident-selection');
  }

  void _navigateToAdminAccess() {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/admin-authentication');
  }

  void _navigateToAbout() {
    HapticFeedback.lightImpact();
    _showAboutDialog();
  }

  void _handleEmergencyAlert() {
    HapticFeedback.heavyImpact();
    // Navigate to emergency incident details
    Navigator.pushNamed(context, '/incident-selection');
  }

  void _showAboutDialog() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String title = 'À propos d\'AEROSAFE';
    String content =
        'AEROSAFE est la plateforme officielle de signalement de sécurité aérienne de l\'ANAC Togo. Elle permet aux professionnels de l\'aviation de signaler anonymement les incidents de sécurité.';
    String version = 'Version 1.0.0';
    String closeButton = 'Fermer';

    if (_currentLanguage == 'en') {
      title = 'About AEROSAFE';
      content =
          'AEROSAFE is the official aviation safety reporting platform of ANAC Togo. It allows aviation professionals to anonymously report safety incidents.';
      version = 'Version 1.0.0';
      closeButton = 'Close';
    } else if (_currentLanguage == 'es') {
      title = 'Acerca de AEROSAFE';
      content =
          'AEROSAFE es la plataforma oficial de informes de seguridad aérea de ANAC Togo. Permite a los profesionales de la aviación informar anónimamente sobre incidentes de seguridad.';
      version = 'Versión 1.0.0';
      closeButton = 'Cerrar';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              version,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Text(closeButton),
          ),
        ],
      ),
    );
  }

  String _getEmergencyMessage() {
    if (_currentLanguage == 'fr') {
      return 'Alerte critique: Incident nécessitant une attention immédiate';
    } else if (_currentLanguage == 'es') {
      return 'Alerta crítica: Incidente que requiere atención inmediata';
    } else {
      return 'Critical alert: Incident requiring immediate attention';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String anonymousTitle = 'Signalement Anonyme';
    String anonymousDesc = 'Signaler un incident en toute confidentialité';
    String adminTitle = 'Accès Administrateur';
    String adminDesc = 'Tableau de bord et gestion des incidents';
    String aboutTitle = 'À Propos';
    String aboutDesc = 'Informations sur la plateforme AEROSAFE';

    if (_currentLanguage == 'en') {
      anonymousTitle = 'Anonymous Reporting';
      anonymousDesc = 'Report an incident confidentially';
      adminTitle = 'Admin Access';
      adminDesc = 'Dashboard and incident management';
      aboutTitle = 'About';
      aboutDesc = 'Information about AEROSAFE platform';
    } else if (_currentLanguage == 'es') {
      anonymousTitle = 'Informe Anónimo';
      anonymousDesc = 'Informar un incidente confidencialmente';
      adminTitle = 'Acceso de Administrador';
      adminDesc = 'Panel de control y gestión de incidentes';
      aboutTitle = 'Acerca de';
      aboutDesc = 'Información sobre la plataforma AEROSAFE';
    }

    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const Positioned.fill(
            child: AirplaneBackgroundWidget(),
          ),
          // Main content
          SafeArea(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: const Color(0xFF00C6FF),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Header with logo and settings
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // AEROSAFE logo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'AEROSAFE',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onPrimary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Connectivity indicator
                            if (!_isOnline)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFB347)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: const Color(0xFFFFB347),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'cloud_off',
                                      color: const Color(0xFFFFB347),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Offline',
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: const Color(0xFFFFB347),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Settings button
                            IconButton(
                              icon: CustomIconWidget(
                                iconName: 'settings',
                                color: colorScheme.onSurface,
                                size: 24,
                              ),
                              onPressed: _showSettings,
                              tooltip: 'Settings',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Emergency banner
                  if (_hasEmergencyAlert)
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: EmergencyBannerWidget(
                          message: _getEmergencyMessage(),
                          onTap: _handleEmergencyAlert,
                          currentLanguage: _currentLanguage,
                        ),
                      ),
                    ),
                  // Welcome message
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: WelcomeMessageWidget(
                        currentLanguage: _currentLanguage,
                      ),
                    ),
                  ),
                  // Action cards
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          ActionCardWidget(
                            title: anonymousTitle,
                            description: anonymousDesc,
                            iconName: 'report',
                            accentColor: const Color(0xFF00C6FF),
                            onTap: _navigateToAnonymousReporting,
                          ),
                          ActionCardWidget(
                            title: adminTitle,
                            description: adminDesc,
                            iconName: 'admin_panel_settings',
                            accentColor: const Color(0xFF0056B3),
                            onTap: _navigateToAdminAccess,
                          ),
                          ActionCardWidget(
                            title: aboutTitle,
                            description: aboutDesc,
                            iconName: 'info',
                            accentColor: const Color(0xFFA0AEC0),
                            onTap: _navigateToAbout,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
