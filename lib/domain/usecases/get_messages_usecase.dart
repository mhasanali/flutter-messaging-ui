import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';

class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase(this.repository);

  /// Get all messages from storage as we don't have remote rn
  Future<List<MessageEntity>> call() async {
    return await repository.getAllMessages();
  }
}