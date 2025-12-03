import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/message_entity.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final int? id;
  final String text;
  final int timestamp;
  final int isFromUser;
  final int type;

  const MessageModel({
    this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
    required this.type,
  });

  // JSON Serialization
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  // Convert from Entity
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      text: entity.text,
      timestamp: entity.timestamp.millisecondsSinceEpoch,
      isFromUser: entity.isFromUser ? 1 : 0,
      type: entity.type.index,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      text: text,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
      isFromUser: isFromUser == 1,
      type: MessageType.values[type],
    );
  }

  // For SQLite
  Map<String, dynamic> toMap() => toJson();
  factory MessageModel.fromMap(Map<String, dynamic> map) =>
      MessageModel.fromJson(map);
}