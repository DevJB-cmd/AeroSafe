import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Chat input widget with send button and attachment option
class ChatInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachment;
  final bool isEncrypted;

  const ChatInputWidget({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachment,
    required this.isEncrypted,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    if (_hasText) {
      HapticFeedback.lightImpact();
      widget.onSend();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3300C6FF),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                widget.onAttachment();
              },
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'attach_file',
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Container(
                constraints: BoxConstraints(minHeight: 12.w, maxHeight: 30.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: widget.controller,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.5.h,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            GestureDetector(
              onTap: _handleSend,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  gradient: _hasText
                      ? LinearGradient(
                          colors: [
                            colorScheme.secondary,
                            colorScheme.secondary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: _hasText
                      ? null
                      : colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _hasText
                        ? colorScheme.secondary.withValues(alpha: 0.3)
                        : colorScheme.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: _hasText
                      ? [
                          BoxShadow(
                            color: colorScheme.secondary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'send',
                    color: _hasText
                        ? colorScheme.onSecondary
                        : colorScheme.primary.withValues(alpha: 0.5),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
