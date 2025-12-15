import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Splash Screen for AEROSAFE application
/// Provides branded app launch experience while initializing services
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _radarAnimation;

  String _statusMessage = 'Initializing AEROSAFE...';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _radarAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.forward();
    _animationController.repeat();
  }

  Future<void> _initializeApp() async {
    try {
      // Step 1: Check authentication status
      await _updateProgress(0.2, 'Checking authentication...');
      await Future.delayed(const Duration(milliseconds: 500));
      final bool isAuthenticated = await _checkAuthStatus();

      // Step 2: Load language preferences
      await _updateProgress(0.4, 'Loading preferences...');
      await Future.delayed(const Duration(milliseconds: 500));
      await _loadLanguagePreferences();

      // Step 3: Prepare cached incident data
      await _updateProgress(0.6, 'Preparing incident data...');
      await Future.delayed(const Duration(milliseconds: 500));
      await _prepareCachedData();

      // Step 4: Initialize encryption services
      await _updateProgress(0.8, 'Initializing security...');
      await Future.delayed(const Duration(milliseconds: 500));
      await _initializeEncryption();

      // Step 5: Complete initialization
      await _updateProgress(1.0, 'Ready!');
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate based on authentication status
      await Future.delayed(const Duration(milliseconds: 300));
      _navigateToNextScreen(isAuthenticated);
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  Future<void> _updateProgress(double progress, String message) async {
    if (mounted) {
      setState(() {
        _progress = progress;
        _statusMessage = message;
      });
    }
  }

  Future<bool> _checkAuthStatus() async {
    // Simulate checking authentication status
    // In production, check secure storage for admin credentials
    return false;
  }

  Future<void> _loadLanguagePreferences() async {
    // Simulate loading language preferences
    // In production, load from shared preferences
  }

  Future<void> _prepareCachedData() async {
    // Simulate preparing cached incident data
    // In production, initialize local database
  }

  Future<void> _initializeEncryption() async {
    // Simulate initializing encryption services
    // In production, setup cryptographic services
  }

  void _navigateToNextScreen(bool isAuthenticated) {
    HapticFeedback.lightImpact();

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/admin-authentication');
    } else {
      Navigator.pushReplacementNamed(context, '/home-screen');
    }
  }

  void _handleInitializationError(dynamic error) {
    if (mounted) {
      setState(() {
        _statusMessage = 'Initialization failed';
      });

      // Show retry option after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          _showRetryDialog();
        }
      });
    }
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Connection Error',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Unable to initialize AEROSAFE. Please check your connection and try again.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeApp();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF0A1A3A),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0A1A3A),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0A1A3A),
      body: SafeArea(
        child: Stack(
          children: [
            // Animated radar line textures background
            _buildRadarBackground(),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // ANAC Togo logo with AEROSAFE branding
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildLogoSection(theme),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Loading indicator and status
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildLoadingSection(theme, size),
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarBackground() {
    return AnimatedBuilder(
      animation: _radarAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: RadarLinePainter(
            progress: _radarAnimation.value,
            color: const Color(0xFF00C6FF).withValues(alpha: 0.05),
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildLogoSection(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ANAC Togo / AEROSAFE Logo
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00C6FF).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/aerosafe_logo.png',
              fit: BoxFit.cover,
              width: 110,
              height: 110,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // AEROSAFE branding
        Text(
          'AEROSAFE',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 8),

        // Animated separator line
        Container(
          width: 100,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                const Color(0xFF00C6FF),
                Colors.transparent,
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle
        Text(
          'Aviation Safety Reporting',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'ANAC Togo',
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF00C6FF).withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSection(ThemeData theme, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Container(
            width: size.width * 0.6,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00C6FF),
                      Color(0xFF0056B3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00C6FF).withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Status message
          Text(
            _statusMessage,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Progress percentage
          Text(
            '${(_progress * 100).toInt()}%',
            style: theme.textTheme.labelSmall?.copyWith(
              color: const Color(0xFF00C6FF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for radar line textures
class RadarLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  RadarLinePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width > size.height ? size.width : size.height;

    // Draw concentric circles
    for (int i = 1; i <= 5; i++) {
      final radius = (maxRadius / 5) * i * progress;
      canvas.drawCircle(center, radius, paint);
    }

    // Draw radial lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.14159 / 180);
      final endX = center.dx + maxRadius * progress * cos(angle);
      final endY = center.dy + maxRadius * progress * sin(angle);
      canvas.drawLine(center, Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(RadarLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}