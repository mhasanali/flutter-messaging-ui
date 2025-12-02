import '../repositories/message_repository.dart';

class ClearMessagesUseCase {
  final MessageRepository repository;

  ClearMessagesUseCase(this.repository);

  Future<void> call() async {
    await repository.clearAllMessages();
  }
}