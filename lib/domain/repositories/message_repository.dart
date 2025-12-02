import '../entities/message_entity.dart';

abstract class MessageRepository{
  Future<List<MessageEntity>> getAllMessages();
  Future<int> addMessage(MessageEntity message);
  Future<void> clearAllMessages();
  Future<MessageEntity> getAgentResponse(String userMessage);
}