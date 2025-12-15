import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/chat_input_widget.dart';
import './widgets/connection_status_widget.dart';
import './widgets/encryption_indicator_widget.dart';
import './widgets/enhanced_message_bubble_widget.dart';
import './widgets/typing_indicator_widget.dart';

/// Anonymous Chat Screen for secure encrypted communication
/// between incident reporters and ANAC agents
class AnonymousChatScreen extends StatefulWidget {
  const AnonymousChatScreen({super.key});

  @override
  State<AnonymousChatScreen> createState() => _AnonymousChatScreenState();
}

class _AnonymousChatScreenState extends State<AnonymousChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isConnected = true;
  final bool _isEncrypted = true;
  bool _isTyping = false;
  final int _participantCount = 2;
  late AnonymousMessageService _messageService;

  @override
  void initState() {
    super.initState();
    _messageService = AnonymousMessageService();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
      _simulateTyping();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _simulateTyping() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isTyping = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _isTyping = false);
          }
        });
      }
    });
  }

  void _handleSendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    final newMessage = AnonymousMessage(
      id: (_messageService.allMessages.length + 1).toString(),
      message: message,
      timestamp:
          '12/12/2025 ${TimeOfDay.now().format(context)} GMT+0',
      isReporter: true,
      agentId: null,
      isReceived: false,
    );
    
    _messageService.addMessage(newMessage);
    
    setState(() {
      _messageController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    _simulateTyping();
  }

  void _handleAttachment() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'photo_camera',
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
                title: Text(
                  'Take Photo',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Photo attachment feature',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'photo_library',
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gallery selection feature',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'attach_file',
                  color: AppTheme.neutralColor,
                  size: 24,
                ),
                title: Text(
                  'Attach Document',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Document attachment feature',
                        style: GoogleFonts.inter(fontSize: 12.sp),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRetryConnection() {
    HapticFeedback.lightImpact();
    setState(() => _isConnected = false);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isConnected = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Connection restored',
              style: GoogleFonts.inter(fontSize: 12.sp),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chat history refreshed',
            style: GoogleFonts.inter(fontSize: 12.sp),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Anonymous Chat',
        subtitle: '$_participantCount participants',
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: EncryptionIndicatorWidget(isEncrypted: _isEncrypted),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConnectionStatusWidget(
                  isConnected: _isConnected,
                  onRetry: _handleRetryConnection,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.primary.withValues(alpha: 0.02),
                  ],
                ),
              ),
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: colorScheme.secondary,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  itemCount: _messageService.allMessages.length +
                      (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messageService.allMessages.length &&
                        _isTyping) {
                      return const TypingIndicatorWidget(
                        participantName: 'ANAC Agent',
                      );
                    }

                    final message = _messageService.allMessages[index];
                    return EnhancedMessageBubbleWidget(
                      message: message.message,
                      timestamp: message.timestamp,
                      isReporter: message.isReporter,
                      agentId: message.agentId,
                      messageId: message.id,
                      isReceived: message.isReceived,
                      onMarkReceived: () {
                        _messageService.markMessageAsReceived(message.id);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          ChatInputWidget(
            controller: _messageController,
            onSend: _handleSendMessage,
            onAttachment: _handleAttachment,
            isEncrypted: _isEncrypted,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2,
        onTap: (index) {
          HapticFeedback.lightImpact();
          final routes = [
            '/admin-dashboard-screen',
            '/qr-access-screen',
            '/anonymous-chat-screen',
            '/settings-screen',
          ];
          if (index != 2) {
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }
}