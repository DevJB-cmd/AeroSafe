import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_export.dart';
import './widgets/action_card_widget.dart';
import './widgets/airplane_background_widget.dart';
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
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadPreferences();

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

  Future<void> _handleRefresh() async {
    HapticFeedback.mediumImpact();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final anonymousTitle = _currentLanguage == 'en'
        ? 'Anonymous Reporting'
        : _currentLanguage == 'es'
            ? 'Informe Anónimo'
            : 'Signalement Anonyme';
    final anonymousDesc = _currentLanguage == 'en'
        ? 'Report an incident confidentially'
        : _currentLanguage == 'es'
            ? 'Informar un incidente confidencialmente'
            : 'Signaler un incident en toute confidentialité';
    final adminTitle = _currentLanguage == 'en'
        ? 'Admin Access'
        : _currentLanguage == 'es'
            ? 'Acceso de Administrador'
            : 'Accès Administrateur';
    final adminDesc = _currentLanguage == 'en'
        ? 'Dashboard and incident management'
        : _currentLanguage == 'es'
            ? 'Panel de control y gestión de incidentes'
            : 'Tableau de bord et gestion des incidents';
    final aboutTitle = _currentLanguage == 'en'
        ? 'About'
        : _currentLanguage == 'es'
            ? 'Acerca de'
            : 'À Propos';
    final aboutDesc = _currentLanguage == 'en'
        ? 'Information about AEROSAFE platform'
        : _currentLanguage == 'es'
            ? 'Información sobre la plataforma AEROSAFE'
            : 'Informations sur la plateforme AEROSAFE';

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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // AEROSAFE logo: text only
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
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
                            const SizedBox(height: 16),
                            // Logo centered at the bottom
                            Center(
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/aerosafe_logo.png',
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.06),
                                      ),
                                      child: Center(
                                        child: CustomIconWidget(
                                          iconName: 'flight',
                                          size: 28,
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
