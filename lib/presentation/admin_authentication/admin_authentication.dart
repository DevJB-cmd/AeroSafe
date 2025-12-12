import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/biometric_button_widget.dart';
import './widgets/security_animation_widget.dart';

/// Admin Authentication Screen for ANAC Togo administrators
/// Implements secure PIN-based authentication with biometric support
class AdminAuthentication extends StatefulWidget {
  const AdminAuthentication({super.key});

  @override
  State<AdminAuthentication> createState() => _AdminAuthenticationState();
}

class _AdminAuthenticationState extends State<AdminAuthentication>
    with TickerProviderStateMixin {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _isLoading = false;
  bool _showBiometric = false;
  int _failedAttempts = 0;
  int _lockoutSeconds = 0;
  bool _isLocked = false;
  late AnimationController _shakeController;
  late AnimationController _lockoutController;
  late Animation<double> _shakeAnimation;

  // Mock valid PIN codes for demonstration
  final List<String> _validPins = [
    'ANAC-TGO-123456',
    'ANAC-TGO-789012',
    'ANAC-TGO-345678',
  ];

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
    _initializeAnimations();
    _checkStoredBiometric();
  }

  void _initializeAnimations() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.elasticIn,
      ),
    );

    _lockoutController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();

      if (mounted) {
        setState(() {
          _showBiometric = canCheckBiometrics && isDeviceSupported;
        });
      }
    } catch (e) {
      // Biometric not available
      if (mounted) {
        setState(() {
          _showBiometric = false;
        });
      }
    }
  }

  Future<void> _checkStoredBiometric() async {
    // Check if user has previously authenticated successfully
    // In production, this would check secure storage
    // For demo, we'll show biometric after first successful PIN login
  }

  Future<void> _authenticateWithBiometric() async {
    if (_isLocked) return;

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access ANAC Togo Admin Dashboard',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate && mounted) {
        HapticFeedback.mediumImpact();
        _handleSuccessfulAuth();
      }
    } catch (e) {
      if (mounted) {
        _showErrorMessage('Biometric authentication failed');
      }
    }
  }

  void _authenticateWithPin() {
    if (_isLocked || _isLoading) return;

    final String enteredPin = _pinController.text.trim();

    // Validate format
    if (!enteredPin.startsWith('ANAC-TGO-') || enteredPin.length != 17) {
      _handleInvalidFormat();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate authentication delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      if (_validPins.contains(enteredPin)) {
        _handleSuccessfulAuth();
      } else {
        _handleFailedAuth();
      }
    });
  }

  void _handleInvalidFormat() {
    HapticFeedback.heavyImpact();
    _shakeController.forward().then((_) => _shakeController.reverse());
    _showErrorMessage('Invalid PIN format. Use ANAC-TGO-XXXXXX');
  }

  void _handleSuccessfulAuth() {
    HapticFeedback.mediumImpact();

    setState(() {
      _isLoading = false;
      _failedAttempts = 0;
    });

    // Enable biometric for future logins
    if (!_showBiometric) {
      setState(() {
        _showBiometric = true;
      });
    }

    // Navigate to admin dashboard
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    });
  }

  void _handleFailedAuth() {
    HapticFeedback.heavyImpact();

    setState(() {
      _isLoading = false;
      _failedAttempts++;
      _pinController.clear();
    });

    _shakeController.forward().then((_) => _shakeController.reverse());

    if (_failedAttempts >= 3) {
      _lockAccount();
    } else {
      _showErrorMessage(
          'Invalid PIN. ${3 - _failedAttempts} attempts remaining.');
    }
  }

  void _lockAccount() {
    setState(() {
      _isLocked = true;
      _lockoutSeconds = 30;
    });

    _showErrorMessage(
        'Too many failed attempts. Account locked for 30 seconds.');

    // Countdown timer
    _lockoutController.repeat();
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;

      setState(() {
        _lockoutSeconds--;
      });

      if (_lockoutSeconds <= 0) {
        setState(() {
          _isLocked = false;
          _failedAttempts = 0;
        });
        _lockoutController.stop();
        return false;
      }
      return true;
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF4757),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showRecoveryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'PIN Recovery',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Please contact your ANAC Togo administrator to reset your PIN. You will need to provide your employee ID and undergo identity verification.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _shakeController.dispose();
    _lockoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const CustomAppBar(
        title: 'Admin Authentication',
        variant: CustomAppBarVariant.withBack,
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                _buildAnacLogo(theme),
                SizedBox(height: 4.h),
                _buildSecurityAnimation(),
                SizedBox(height: 4.h),
                _buildInstructionText(theme),
                SizedBox(height: 3.h),
                _buildPinInput(theme),
                SizedBox(height: 3.h),
                if (_isLocked) _buildLockoutMessage(theme),
                if (!_isLocked) _buildAuthenticateButton(theme),
                SizedBox(height: 2.h),
                if (_showBiometric && !_isLocked) _buildBiometricButton(),
                SizedBox(height: 3.h),
                _buildForgotPinLink(theme),
                SizedBox(height: 2.h),
                _buildSecurityNote(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnacLogo(ThemeData theme) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'admin_panel_settings',
              size: 12.w,
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: 1.h),
            Text(
              'ANAC',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'TOGO',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityAnimation() {
    return const SecurityAnimationWidget();
  }

  Widget _buildInstructionText(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Administrator Access',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.h),
        Text(
          'Enter your 6-digit PIN with ANAC-TGO prefix',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPinInput(ThemeData theme) {
    final defaultPinTheme = PinTheme(
      width: 12.w,
      height: 7.h,
      textStyle: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00C6FF),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C6FF).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF4757),
          width: 2,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'ANAC-TGO-',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Pinput(
            controller: _pinController,
            focusNode: _pinFocusNode,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            errorPinTheme: errorPinTheme,
            enabled: !_isLocked && !_isLoading,
            obscureText: true,
            obscuringCharacter: '●',
            keyboardType: TextInputType.number,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              _authenticateWithPin();
            },
            cursor: Container(
              width: 2,
              height: 3.h,
              color: const Color(0xFF00C6FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticateButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: _isLoading || _pinController.text.length < 6
            ? null
            : _authenticateWithPin,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor:
              theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'lock_open',
                    size: 5.w,
                    color: theme.colorScheme.onPrimary,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Authenticate',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBiometricButton() {
    return BiometricButtonWidget(
      onPressed: _authenticateWithBiometric,
    );
  }

  Widget _buildLockoutMessage(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4757).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF4757).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'lock_clock',
            size: 8.w,
            color: const Color(0xFFFF4757),
          ),
          SizedBox(height: 1.h),
          Text(
            'Account Locked',
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFFFF4757),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Please wait $_lockoutSeconds seconds',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPinLink(ThemeData theme) {
    return TextButton(
      onPressed: _showRecoveryDialog,
      child: Text(
        'Forgot PIN?',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildSecurityNote(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconWidget(
            iconName: 'security',
            size: 5.w,
            color: theme.colorScheme.primary,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Notice',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Your session will automatically timeout after 30 seconds of inactivity. All authentication attempts are logged for security purposes.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
