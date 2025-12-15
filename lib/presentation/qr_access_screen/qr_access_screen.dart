import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/qr_bottom_sheet_widget.dart';
import './widgets/qr_instruction_widget.dart';
import './widgets/qr_scanner_overlay_widget.dart';

/// QR Access Screen for instant incident reporting through QR code scanning
/// Implements professional aviation interface with camera-based scanning
class QrAccessScreen extends StatefulWidget {
  const QrAccessScreen({super.key});

  @override
  State<QrAccessScreen> createState() => _QrAccessScreenState();
}

class _QrAccessScreenState extends State<QrAccessScreen>
    with SingleTickerProviderStateMixin {
  // Mobile scanner controller
  MobileScannerController? _scannerController;

  // Animation controller for pulsating scan frame
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // State variables
  bool _isScanning = true;
  bool _isDemoMode = false;
  bool _isTorchOn = false;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
    _setupAnimations();
  }

  /// Initialize scanner and request permissions
  Future<void> _initializeScanner() async {
    // Request camera permission
    final status = await Permission.camera.request();
    setState(() {
      _hasPermission = status.isGranted;
    });

    if (_hasPermission) {
      _scannerController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: false,
      );
    }
  }

  /// Setup pulsating animation for scan frame
  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  /// Handle QR code detection
  void _handleQrCodeDetected(BarcodeCapture capture) {
    if (!_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() {
      _isScanning = false;
    });

    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Navigate to incident selection with location pre-filled
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/admin-dashboard-screen',
          arguments: {'qrCode': code, 'location': 'Terminal A - Gate 5'},
        );
      }
    });
  }

  /// Toggle torch/flashlight
  void _toggleTorch() {
    if (_scannerController == null) return;

    setState(() {
      _isTorchOn = !_isTorchOn;
    });

    _scannerController!.toggleTorch();
    HapticFeedback.lightImpact();
  }

  /// Toggle demo mode
  void _toggleDemoMode() {
    setState(() {
      _isDemoMode = !_isDemoMode;
    });

    HapticFeedback.lightImpact();

    if (_isDemoMode) {
      // Generate sample QR code for demo
      _showDemoQrCode();
    }
  }

  /// Show demo QR code dialog
  void _showDemoQrCode() {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Demo QR Code',
          style: theme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'DEMO-QR-CODE\nAEROSAFE-2025',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Scan this demo code for training purposes',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  /// Show manual entry dialog
  void _showManualEntry() {
    final theme = Theme.of(context);
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Manual Location Entry',
          style: theme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter location code manually if QR code is unavailable',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'e.g., TERMINAL-A-GATE-5',
                prefixIcon: CustomIconWidget(
                  iconName: 'location_on',
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/admin-dashboard-screen',
                  arguments: {
                    'qrCode': controller.text,
                    'location': controller.text,
                  },
                );
              }
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  /// Show settings redirect dialog for denied permissions
  void _showPermissionDialog() {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'camera_alt',
              color: theme.colorScheme.secondary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Camera Permission Required',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        content: Text(
          'AEROSAFE needs camera access to scan QR codes for incident reporting. Please enable camera permission in your device settings.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'QR Access',
        subtitle: 'Scan location QR code',
        automaticallyImplyLeading: true,
        centerTitle: false,
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: _isDemoMode ? 'toggle_on' : 'toggle_off',
              color: _isDemoMode
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              size: 28,
            ),
            onPressed: _toggleDemoMode,
            tooltip: 'Demo Mode',
          ),
        ],
      ),
      body: _hasPermission
          ? _buildScannerView(theme)
          : _buildPermissionDenied(theme),
    );
  }

  /// Build scanner view with camera preview
  Widget _buildScannerView(ThemeData theme) {
    return Stack(
      children: [
        // Camera preview
        MobileScanner(
          controller: _scannerController,
          onDetect: _handleQrCodeDetected,
        ),

        // Overlay with scan frame
        QrScannerOverlayWidget(
          pulseAnimation: _pulseAnimation,
          isDemoMode: _isDemoMode,
        ),

        // Torch toggle button
        Positioned(
          top: 24,
          right: 24,
          child: Material(
            color: theme.colorScheme.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: _toggleTorch,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: CustomIconWidget(
                  iconName: _isTorchOn ? 'flash_on' : 'flash_off',
                  color: _isTorchOn
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
            ),
          ),
        ),

        // Instruction text
        Positioned(
          bottom: 200,
          left: 0,
          right: 0,
          child: QrInstructionWidget(isDemoMode: _isDemoMode),
        ),

        // Bottom sheet trigger
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: QrBottomSheetWidget(
            onManualEntry: _showManualEntry,
            onDemoToggle: _toggleDemoMode,
            isDemoMode: _isDemoMode,
          ),
        ),
      ],
    );
  }

  /// Build permission denied view
  Widget _buildPermissionDenied(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'camera_alt',
              color: theme.colorScheme.secondary,
              size: 64,
            ),
            const SizedBox(height: 24),
            Text(
              'Camera Permission Required',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'AEROSAFE needs camera access to scan QR codes for incident reporting.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _showPermissionDialog,
              icon: CustomIconWidget(
                iconName: 'settings',
                color: theme.colorScheme.onPrimary,
                size: 20,
              ),
              label: const Text('Open Settings'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _showManualEntry,
              child: Text(
                'Enter Location Manually',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
