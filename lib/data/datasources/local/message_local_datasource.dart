import '../../models/message_model.dart';

abstract class MessageLocalDataSource{
  Future<List<MessageModel>> getAllMessages();
  Future<int> insertMessage(MessageModel message);
  Future<void> deleteAllMessages();
}