import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';

class AddMessageUseCase {
  final MessageRepository repository;

  AddMessageUseCase(this.repository);

  Future<int> call(MessageEntity message) async {
    return await repository.addMessage(message);
  }
}