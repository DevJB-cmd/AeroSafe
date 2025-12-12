import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PhotoAttachmentSection extends StatefulWidget {
  final List<String> attachedPhotos;
  final Function(List<String>) onPhotosChanged;

  const PhotoAttachmentSection({
    super.key,
    required this.attachedPhotos,
    required this.onPhotosChanged,
  });

  @override
  State<PhotoAttachmentSection> createState() => _PhotoAttachmentSectionState();
}

class _PhotoAttachmentSectionState extends State<PhotoAttachmentSection> {
  final ImagePicker _imagePicker = ImagePicker();
  static const int maxPhotos = 5;

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;

    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> _requestStoragePermission() async {
    if (kIsWeb) return true;

    final status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> _capturePhoto() async {
    if (widget.attachedPhotos.length >= maxPhotos) {
      _showMaxPhotosMessage();
      return;
    }

    try {
      if (!await _requestCameraPermission()) {
        _showPermissionDeniedMessage('caméra');
        return;
      }

      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        final updatedPhotos = List<String>.from(widget.attachedPhotos)
          ..add(photo.path);
        widget.onPhotosChanged(updatedPhotos);
        HapticFeedback.lightImpact();
      }
    } catch (e) {
      _showErrorMessage('Erreur lors de la capture de la photo');
    }
  }

  Future<void> _selectFromGallery() async {
    if (widget.attachedPhotos.length >= maxPhotos) {
      _showMaxPhotosMessage();
      return;
    }

    try {
      if (!await _requestStoragePermission()) {
        _showPermissionDeniedMessage('galerie');
        return;
      }

      final List<XFile> photos = await _imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photos.isNotEmpty) {
        final remainingSlots = maxPhotos - widget.attachedPhotos.length;
        final photosToAdd =
            photos.take(remainingSlots).map((p) => p.path).toList();

        final updatedPhotos = List<String>.from(widget.attachedPhotos)
          ..addAll(photosToAdd);
        widget.onPhotosChanged(updatedPhotos);
        HapticFeedback.lightImpact();

        if (photos.length > remainingSlots) {
          _showMaxPhotosMessage();
        }
      }
    } catch (e) {
      _showErrorMessage('Erreur lors de la sélection des photos');
    }
  }

  void _removePhoto(int index) {
    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer la photo'),
        content: Text('Voulez-vous vraiment supprimer cette photo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              final updatedPhotos = List<String>.from(widget.attachedPhotos)
                ..removeAt(index);
              widget.onPhotosChanged(updatedPhotos);
              Navigator.pop(context);
            },
            child: Text(
              'Supprimer',
              style: TextStyle(color: AppTheme.errorLight),
            ),
          ),
        ],
      ),
    );
  }

  void _showMaxPhotosMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Maximum $maxPhotos photos autorisées'),
        backgroundColor: AppTheme.warningLight,
      ),
    );
  }

  void _showPermissionDeniedMessage(String permission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permission $permission requise'),
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
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'photo_camera',
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Photos (${widget.attachedPhotos.length}/$maxPhotos)',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (widget.attachedPhotos.length < maxPhotos)
                Text(
                  'Optionnel',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Ajoutez des photos pour documenter l\'incident',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 2.h),
          if (widget.attachedPhotos.isEmpty)
            _buildEmptyState(theme)
          else
            _buildPhotoGrid(theme),
          if (widget.attachedPhotos.length < maxPhotos) ...[
            SizedBox(height: 2.h),
            _buildActionButtons(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'add_photo_alternate',
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              size: 48,
            ),
            SizedBox(height: 1.h),
            Text(
              'Aucune photo ajoutée',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoGrid(ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
        childAspectRatio: 1,
      ),
      itemCount: widget.attachedPhotos.length,
      itemBuilder: (context, index) {
        return _buildPhotoThumbnail(theme, index);
      },
    );
  }

  Widget _buildPhotoThumbnail(ThemeData theme, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: kIsWeb
                ? CustomImageWidget(
                    imageUrl: widget.attachedPhotos[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    semanticLabel: 'Photo d\'incident ${index + 1}',
                  )
                : Image.network(
                    widget.attachedPhotos[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: CustomIconWidget(
                          iconName: 'broken_image',
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 32,
                        ),
                      );
                    },
                  ),
          ),
        ),
        Positioned(
          top: 1.w,
          right: 1.w,
          child: GestureDetector(
            onTap: () => _removePhoto(index),
            child: Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: AppTheme.errorLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CustomIconWidget(
                iconName: 'close',
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _capturePhoto,
            icon: CustomIconWidget(
              iconName: 'camera_alt',
              color: theme.colorScheme.primary,
              size: 20,
            ),
            label: Text('Capturer'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _selectFromGallery,
            icon: CustomIconWidget(
              iconName: 'photo_library',
              color: theme.colorScheme.primary,
              size: 20,
            ),
            label: Text('Galerie'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
      ],
    );
  }
}
