/// Service for managing anonymous messages between reporters and ANAC agents
class AnonymousMessage {
  final String id;
  final String message;
  final String timestamp;
  final bool isReporter; // true if from reporter, false if from agent
  final String? agentId;
  bool isReceived; // true if admin has received/acknowledged the message

  AnonymousMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isReporter,
    this.agentId,
    this.isReceived = false,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp,
      'isReporter': isReporter,
      'agentId': agentId,
      'isReceived': isReceived,
    };
  }

  // Create from JSON
  factory AnonymousMessage.fromJson(Map<String, dynamic> json) {
    return AnonymousMessage(
      id: json['id'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
      isReporter: json['isReporter'] as bool,
      agentId: json['agentId'] as String?,
      isReceived: json['isReceived'] as bool? ?? false,
    );
  }
}

/// Singleton service to manage all anonymous messages
class AnonymousMessageService {
  static final AnonymousMessageService _instance =
      AnonymousMessageService._internal();

  factory AnonymousMessageService() {
    return _instance;
  }

  AnonymousMessageService._internal();

  // Global list of all messages
  final List<AnonymousMessage> _messages = [];

  // Getters
  List<AnonymousMessage> get allMessages => List.unmodifiable(_messages);

  List<AnonymousMessage> get unreceivedMessages =>
      _messages.where((msg) => !msg.isReceived && !msg.isReporter).toList();

  List<AnonymousMessage> get receivedMessages =>
      _messages.where((msg) => msg.isReceived && !msg.isReporter).toList();

  // Add a new message
  void addMessage(AnonymousMessage message) {
    _messages.add(message);
  }

  // Mark message as received by admin
  void markMessageAsReceived(String messageId) {
    final index =
        _messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      _messages[index].isReceived = true;
    }
  }

  // Get messages for a specific chat session (reporter + agent)
  List<AnonymousMessage> getSessionMessages(String sessionId) {
    // In a real app, this would filter by session ID
    return _messages;
  }

  // Clear all messages (for testing)
  void clearAll() {
    _messages.clear();
  }
}
