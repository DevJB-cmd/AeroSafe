import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import './widgets/anonymity_reminder_section.dart';
import './widgets/emotional_state_selector.dart';
import './widgets/photo_attachment_section.dart';
import './widgets/timestamp_section.dart';
import './widgets/voice_input_section.dart';

class DescriptionInput extends StatefulWidget {
  const DescriptionInput({super.key});

  @override
  State<DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  List<String> _attachedPhotos = [];
  String _selectedEmotion = '';
  DateTime _selectedTimestamp = DateTime.now();
  bool _isSubmitting = false;
  bool _hasUnsavedChanges = false;

  static const int maxCharacters = 1000;
  static const int minCharacters = 50;

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
    _autoSaveDraft();
  }

  @override
  void dispose() {
    _descriptionController.removeListener(_onDescriptionChanged);
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onDescriptionChanged() {
    setState(() {
      _hasUnsavedChanges = true;
    });
  }

  void _autoSaveDraft() {
    // Auto-save functionality to prevent data loss
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && _hasUnsavedChanges) {
        _saveDraft();
        _autoSaveDraft();
      }
    });
  }

  void _saveDraft() {
    // Save draft locally
    _hasUnsavedChanges = false;
  }

  void _onVoiceTranscription(String text) {
    setState(() {
      final currentText = _descriptionController.text;
      _descriptionController.text =
          currentText.isEmpty ? text : '$currentText $text';
      _descriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: _descriptionController.text.length),
      );
    });
  }

  void _onPhotosChanged(List<String> photos) {
    setState(() {
      _attachedPhotos = photos;
    });
  }

  void _onEmotionSelected(String emotion) {
    setState(() {
      _selectedEmotion = emotion;
    });
    HapticFeedback.lightImpact();
  }

  void _onTimestampChanged(DateTime timestamp) {
    setState(() {
      _selectedTimestamp = timestamp;
    });
  }

  bool _canSubmit() {
    return _descriptionController.text.trim().length >= minCharacters &&
        _selectedEmotion.isNotEmpty;
  }

  Future<void> _submitReport() async {
    if (!_canSubmit()) return;

    setState(() {
      _isSubmitting = true;
    });

    HapticFeedback.mediumImpact();

    try {
      // Simulate encryption and submission process
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Generate cryptographic token
        final token = _generateCryptographicToken();

        // Navigate to confirmation screen with token
        Navigator.pushReplacementNamed(
          context,
          '/incident-confirmation',
          arguments: {
            'token': token,
            'timestamp': _selectedTimestamp,
            'emotion': _selectedEmotion,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la soumission. Veuillez réessayer.'),
            backgroundColor: AppTheme.errorLight,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String _generateCryptographicToken() {
    // Generate a cryptographic token for anonymous follow-up
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 1000000).toString().padLeft(6, '0');
    return 'ANAC-TGO-$random';
  }

  int _getRemainingCharacters() {
    return maxCharacters - _descriptionController.text.length;
  }

  Color _getCharacterCountColor(ThemeData theme) {
    final remaining = _getRemainingCharacters();
    if (remaining < 50) {
      return AppTheme.errorLight;
    } else if (remaining < 200) {
      return AppTheme.warningLight;
    }
    return theme.colorScheme.onSurfaceVariant;
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Modifications non enregistrées'),
          content:
              Text('Voulez-vous quitter sans enregistrer vos modifications?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Quitter'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

 @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return PopScope(
    canPop: !_hasUnsavedChanges,
    onPopInvokedWithResult: (didPop, result) {
      if (didPop) return;

      _onWillPop().then((shouldPop) {
        if (shouldPop && mounted) {
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      });
    },
    child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Décrire l\'incident',
        variant: CustomAppBarVariant.withBack,
        subtitle: 'Étape 3/3',
        actions: [
          Container(
            margin: EdgeInsets.only(right: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.successLight.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successLight,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'shield',
                  color: AppTheme.successLight,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Anonyme',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.successLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        body: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              _buildProgressIndicator(theme),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description text area
                      _buildDescriptionSection(theme),
                      SizedBox(height: 3.h),

                      // Voice input section
                      VoiceInputSection(
                        onTranscription: _onVoiceTranscription,
                      ),
                      SizedBox(height: 3.h),

                      // Photo attachment section
                      PhotoAttachmentSection(
                        attachedPhotos: _attachedPhotos,
                        onPhotosChanged: _onPhotosChanged,
                      ),
                      SizedBox(height: 3.h),

                      // Emotional state selector
                      EmotionalStateSelector(
                        selectedEmotion: _selectedEmotion,
                        onEmotionSelected: _onEmotionSelected,
                      ),
                      SizedBox(height: 3.h),

                      // Timestamp section
                      TimestampSection(
                        selectedTimestamp: _selectedTimestamp,
                        onTimestampChanged: _onTimestampChanged,
                      ),
                      SizedBox(height: 3.h),

                      // Anonymity reminder
                      AnonymityReminderSection(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomSubmitButton(theme),
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 1.0,
              backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.2),
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppTheme.secondaryLight),
              minHeight: 4,
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            '3/3',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description de l\'incident',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Décrivez ce qui s\'est passé en détail. Plus vous fournissez d\'informations, mieux nous pourrons traiter l\'incident.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _descriptionFocusNode.hasFocus
                  ? AppTheme.secondaryLight
                  : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: _descriptionFocusNode.hasFocus ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                maxLines: 8,
                maxLength: maxCharacters,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Tapez votre description ici...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(4.w),
                  counterText: '',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Minimum $minCharacters caractères',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color:
                            _descriptionController.text.length >= minCharacters
                                ? AppTheme.successLight
                                : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${_getRemainingCharacters()} restants',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _getCharacterCountColor(theme),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSubmitButton(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _canSubmit() && !_isSubmitting ? _submitReport : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _canSubmit() && !_isSubmitting
                ? AppTheme.secondaryLight
                : theme.colorScheme.outline.withValues(alpha: 0.3),
            foregroundColor: _canSubmit() && !_isSubmitting
                ? AppTheme.onSecondaryLight
                : theme.colorScheme.onSurfaceVariant,
            minimumSize: Size(double.infinity, 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: _canSubmit() && !_isSubmitting ? 2 : 0,
          ),
          child: _isSubmitting
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.onSecondaryLight,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'send',
                      color: _canSubmit() && !_isSubmitting
                          ? AppTheme.onSecondaryLight
                          : theme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Soumettre le rapport',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
