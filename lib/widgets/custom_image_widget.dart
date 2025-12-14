import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_export.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://') || startsWith('file: //')) {
      return ImageType.file;
    } else if (endsWith('.png') ||
        endsWith('.jpg') ||
        endsWith('.jpeg')) {
      return ImageType.png;
    } else {
      return ImageType.unknown;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

// ignore_for_file: must_be_immutable
class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/no-image.jpg',
    this.errorWidget,
    this.semanticLabel,
  });

  /// Image source (asset, network, file, svg)
  final String? imageUrl;

  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeHolder;
  final Color? color;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final BorderRadius? radius;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;

  /// Widget affiché en cas d’erreur de chargement
  final Widget? errorWidget;

  /// Accessibilité
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  Widget _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius!,
        child: _buildImageWithBorder(),
      );
    }
    return _buildImageWithBorder();
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    }
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (imageUrl != null) {
      switch (imageUrl!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imageUrl!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
              semanticsLabel: semanticLabel,
            ),
          );

        case ImageType.file:
          return Image.file(
            File(imageUrl!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            semanticLabel: semanticLabel,
          );

        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imageUrl!,
            color: color,
            placeholder: (_, __) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (_, __, ___) =>
                errorWidget ??
                Image.asset(
                  placeHolder,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.cover,
                  semanticLabel: semanticLabel,
                ),
          );

        case ImageType.png:
        case ImageType.unknown:
        default:
          return Image.asset(
            imageUrl!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            semanticLabel: semanticLabel,
          );
      }
    }
    return const SizedBox();
  }
}
