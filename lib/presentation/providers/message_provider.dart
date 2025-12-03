import 'package:flutter/foundation.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/clear_messages_usecase.dart';
import '../../domain/usecases/get_agent_response_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';

class MessageProvider with ChangeNotifier {
  final GetMessagesUseCase getMessagesUseCase;
  final AddMessageUseCase addMessageUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;
  final GetAgentResponseUseCase getAgentResponseUseCase;

  MessageProvider({
    required this.getMessagesUseCase,
    required this.addMessageUseCase,
    required this.clearMessagesUseCase,
    required this.getAgentResponseUseCase,
  });

  List<MessageEntity> _messages = [];
  bool _isLoading = false;
  bool _isTyping = false;
  String? _error;

  List<MessageEntity> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isTyping => _isTyping;
  String? get error => _error;

  Future<void> loadMessages() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _messages = await getMessagesUseCase();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      final userMessage = MessageEntity(
        text: text,
        timestamp: DateTime.now(),
        isFromUser: true,
      );

      await addMessageUseCase(userMessage);
      await loadMessages();

      _isTyping = true;
      notifyListeners();

      await getAgentResponseUseCase(text);
      await loadMessages();

      _isTyping = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isTyping = false;
      notifyListeners();
    }
  }

  Future<void> clearMessages() async {
    try {
      await clearMessagesUseCase();
      await loadMessages();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}