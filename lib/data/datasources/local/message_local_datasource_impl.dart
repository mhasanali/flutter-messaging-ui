import 'package:messaging_app/data/datasources/local/message_local_datasource.dart';
import 'package:messaging_app/data/models/message_model.dart';

class MessageLocalDataSourceImpl implements MessageLocalDataSource{
  @override
  Future<void> deleteAllMessages() {
    // TODO: implement deleteAllMessages
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getAllMessages() {
    // TODO: implement getAllMessages
    throw UnimplementedError();
  }

  @override
  Future<int> insertMessage(MessageModel message) {
    // TODO: implement insertMessage
    throw UnimplementedError();
  }

}