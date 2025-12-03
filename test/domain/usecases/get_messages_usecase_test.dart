import 'package:flutter_test/flutter_test.dart';
import 'package:messaging_app/domain/entities/message_entity.dart';
import 'package:messaging_app/domain/repositories/message_repository.dart';
import 'package:messaging_app/domain/usecases/get_messages_usecase.dart';
import 'package:mocktail/mocktail.dart';


class MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  late GetMessagesUseCase useCase;
  late MockMessageRepository mockRepository;

  setUp(() {
    mockRepository = MockMessageRepository();
    useCase = GetMessagesUseCase(mockRepository);
  });

  group('GetMessagesUseCase', () {
    test('should return list of messages from repository', () async {
      final testMessages = [
        MessageEntity(
          id: 1,
          text: 'Hello!',
          timestamp: DateTime(2025, 12, 3, 10, 0),
          isFromUser: true,
        ),
        MessageEntity(
          id: 2,
          text: 'Hi there! How can I help?',
          timestamp: DateTime(2025, 12, 3, 10, 1),
          isFromUser: false,
        ),
      ];

      when(() => mockRepository.getAllMessages())
          .thenAnswer((_) async => testMessages);

      final result = await useCase();

      expect(result, testMessages);
      expect(result.length, 2);
      expect(result[0].text, 'Hello!');
      expect(result[1].isFromUser, false);
      verify(() => mockRepository.getAllMessages()).called(1);
    });

    test('should return empty list when no messages exist', () async {
      when(() => mockRepository.getAllMessages())
          .thenAnswer((_) async => []);

      final result = await useCase();

      expect(result, isEmpty);
      verify(() => mockRepository.getAllMessages()).called(1);
    });
  });
}