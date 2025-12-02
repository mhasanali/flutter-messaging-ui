import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';

class GetAgentResponseUseCase {
  final MessageRepository repository;

  GetAgentResponseUseCase(this.repository);

  Future<MessageEntity> call(String userMessage) async {
    return await repository.getAgentResponse(userMessage);
  }
}