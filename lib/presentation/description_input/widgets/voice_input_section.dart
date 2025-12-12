import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VoiceInputSection extends StatefulWidget {
  final Function(String) onTranscription;

  const VoiceInputSection({
    super.key,
    required this.onTranscription,
  });

  @override
  State<VoiceInputSection> createState() => _VoiceInputSectionState();
}

class _VoiceInputSectionState extends State<VoiceInputSection>
    with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isProcessing = false;
  String? _recordingPath;
  late AnimationController _waveformController;
  late Animation<double> _waveformAnimation;

  @override
  void initState() {
    super.initState();
    _waveformController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _waveformAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _waveformController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _waveformController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<bool> _requestMicrophonePermission() async {
    if (kIsWeb) return true;

    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> _startRecording() async {
    try {
      if (!await _requestMicrophonePermission()) {
        _showPermissionDeniedMessage();
        return;
      }

      if (await _audioRecorder.hasPermission()) {
        setState(() {
          _isRecording = true;
        });

        HapticFeedback.mediumImpact();

        if (kIsWeb) {
          await _audioRecorder.start(
            const RecordConfig(encoder: AudioEncoder.wav),
            path: 'recording.wav',
          );
        } else {
          final dir = await getTemporaryDirectory();
          _recordingPath =
              '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
          await _audioRecorder.start(
            const RecordConfig(),
            path: _recordingPath!,
          );
        }
      }
    } catch (e) {
      setState(() {
        _isRecording = false;
      });
      _showErrorMessage('Erreur lors du démarrage de l\'enregistrement');
    }
  }

  Future<void> _stopRecording() async {
    try {
      setState(() {
        _isProcessing = true;
      });

      final path = await _audioRecorder.stop();

      setState(() {
        _isRecording = false;
      });

      HapticFeedback.lightImpact();

      if (path != null) {
        await _processRecording(path);
      }
    } catch (e) {
      _showErrorMessage('Erreur lors de l\'arrêt de l\'enregistrement');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _processRecording(String path) async {
    // Simulate transcription process
    await Future.delayed(const Duration(seconds: 2));

    // Mock transcription result
    final transcription =
        'J\'ai observé un incident de sécurité dans la zone de chargement des bagages. Un chariot élévateur circulait à une vitesse excessive près des travailleurs au sol.';

    widget.onTranscription(transcription);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transcription ajoutée avec succès'),
          backgroundColor: AppTheme.successLight,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showPermissionDeniedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Permission microphone requise pour l\'enregistrement vocal'),
        backgroundColor: AppTheme.warningLight,
        action: SnackBarAction(
          label: 'Paramètres',
          textColor: Colors.white,
          onPressed: () {
            openAppSettings();
          },
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorLight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isRecording
              ? AppTheme.errorLight
              : theme.colorScheme.outline.withValues(alpha: 0.3),
          width: _isRecording ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'mic',
                color: theme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Saisie vocale',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Appuyez et maintenez pour enregistrer votre description vocale',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 2.h),
          Center(
            child: GestureDetector(
              onTapDown: (_) => _startRecording(),
              onTapUp: (_) => _stopRecording(),
              onTapCancel: () => _stopRecording(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: _isRecording
                      ? AppTheme.errorLight
                      : AppTheme.secondaryLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_isRecording
                              ? AppTheme.errorLight
                              : AppTheme.secondaryLight)
                          .withValues(alpha: 0.3),
                      blurRadius: _isRecording ? 20 : 10,
                      spreadRadius: _isRecording ? 5 : 0,
                    ),
                  ],
                ),
                child: _isProcessing
                    ? Center(
                        child: SizedBox(
                          width: 8.w,
                          height: 8.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_isRecording)
                            AnimatedBuilder(
                              animation: _waveformAnimation,
                              builder: (context, child) {
                                return Container(
                                  width: 20.w * _waveformAnimation.value,
                                  height: 20.w * _waveformAnimation.value,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.5),
                                      width: 2,
                                    ),
                                  ),
                                );
                              },
                            ),
                          CustomIconWidget(
                            iconName: _isRecording ? 'stop' : 'mic',
                            color: Colors.white,
                            size: 32,
                          ),
                        ],
                      ),
              ),
            ),
          ),
          if (_isRecording) ...[
            SizedBox(height: 2.h),
            Center(
              child: Text(
                'Enregistrement en cours...',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.errorLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
