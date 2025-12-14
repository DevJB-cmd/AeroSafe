import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/chat_input_widget.dart';
import './widgets/connection_status_widget.dart';
import './widgets/encryption_indicator_widget.dart';
import './widgets/message_bubble_widget.dart';
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
  bool _isEncrypted = true;
  bool _isTyping = false;
  int _participantCount = 2;

  // Mock chat messages with aviation-themed content
  final List<Map<String, dynamic>> _messages = [
    {
      "id": 1,
      "message":
          "Hello, I submitted an incident report earlier today regarding runway debris. Can you provide an update on the investigation status?",
      "timestamp": "12/12/2025 14:23 GMT+0",
      "isReporter": true,
      "agentId": null,
    },
    {
      "id": 2,
      "message":
          "Thank you for your report. I'm ANAC Agent reviewing your case. We have received your documentation and photos. The runway inspection team has been dispatched to verify the debris location you indicated.",
      "timestamp": "12/12/2025 14:25 GMT+0",
      "isReporter": false,
      "agentId": "ANAC-TG-2847",
    },
    {
      "id": 3,
      "message":
          "That's reassuring to hear. The debris was approximately 200 meters from the threshold of Runway 09. I noticed it during my pre-flight inspection around 13:45 local time.",
      "timestamp": "12/12/2025 14:27 GMT+0",
      "isReporter": true,
      "agentId": null,
    },
    {
      "id": 4,
      "message":
          "Your precise location details are very helpful. The inspection team has confirmed the debris and initiated removal procedures. We're also reviewing CCTV footage to determine the source. Your anonymity remains protected throughout this process.",
      "timestamp": "12/12/2025 14:30 GMT+0",
      "isReporter": false,
      "agentId": "ANAC-TG-2847",
    },
    {
      "id": 5,
      "message":
          "Excellent. Will there be any follow-up actions required from my side? I want to ensure this doesn't happen again.",
      "timestamp": "12/12/2025 14:32 GMT+0",
      "isReporter": true,
      "agentId": null,
    },
    {
      "id": 6,
      "message":
          "No further action needed from you at this time. We will implement additional runway inspection protocols based on your report. You can track the incident status using your anonymous token. Thank you for contributing to aviation safety in Togo.",
      "timestamp": "12/12/2025 14:35 GMT+0",
      "isReporter": false,
      "agentId": "ANAC-TG-2847",
    },
  ];

  @override
  void initState() {
    super.initState();
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

    setState(() {
      _messages.add({
        "id": _messages.length + 1,
        "message": message,
        "timestamp": "12/12/2025 ${TimeOfDay.now().format(context)} GMT+0",
        "isReporter": true,
        "agentId": null,
      });
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
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return const TypingIndicatorWidget(
                        participantName: 'ANAC Agent',
                      );
                    }

                    final message = _messages[index];
                    return MessageBubbleWidget(
                      message: message["message"] as String,
                      timestamp: message["timestamp"] as String,
                      isReporter: message["isReporter"] as bool,
                      agentId: message["agentId"] as String?,
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