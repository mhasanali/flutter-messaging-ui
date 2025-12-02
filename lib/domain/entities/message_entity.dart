enum MessageType {
  text,
  emoji,
  image,
  multimedia
}

class MessageEntity {
  final int? id;
  final String text;
  final DateTime timestamp;
  final bool isFromUser;
  final MessageType type;

  const MessageEntity({
    this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
    this.type = MessageType.text,
  });

  MessageEntity copyWith({
    int? id,
    String? text,
    DateTime? timestamp,
    bool? isFromUser,
    MessageType? type,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isFromUser: isFromUser ?? this.isFromUser,
      type: type ?? this.type,
    );
  }
}