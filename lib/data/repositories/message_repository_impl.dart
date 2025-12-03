import 'dart:math';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/local/message_local_datasource.dart';
import '../models/message_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageLocalDataSource localDataSource;

  MessageRepositoryImpl({required this.localDataSource});

  @override
  Future<List<MessageEntity>> getAllMessages() async {
    final models = await localDataSource.getAllMessages();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<int> addMessage(MessageEntity message) async {
    final model = MessageModel.fromEntity(message);
    return await localDataSource.insertMessage(model);
  }

  @override
  Future<void> clearAllMessages() async {
    await localDataSource.deleteAllMessages();
  }

  @override
  Future<MessageEntity> getAgentResponse(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: AppConstants.typingIndicatorDelayInSeconds));

    String response = _generateResponse(userMessage);

    final agentMessage = MessageEntity(
      text: response,
      timestamp: DateTime.now(),
      isFromUser: false,
    );

    final id = await addMessage(agentMessage);
    return agentMessage.copyWith(id: id);
  }

  String _generateResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return "Hello! Welcome to our support. How can I assist you today?";
    } else if (lowerMessage.contains('help')) {
      return "I'm here to help! What do you need assistance with?";
    } else if (lowerMessage.contains('thanks') ||
        lowerMessage.contains('thank you')) {
      return "You're welcome! Is there anything else I can help you with?";
    } else if (lowerMessage.contains('bye')) {
      return "Goodbye! Feel free to reach out anytime.";
    } else {
      final random = Random();
      return AppConstants.agentResponses[
      random.nextInt(AppConstants.agentResponses.length)];
    }
  }
}