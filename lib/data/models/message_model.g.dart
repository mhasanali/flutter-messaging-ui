// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  id: (json['id'] as num?)?.toInt(),
  text: json['text'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  isFromUser: (json['isFromUser'] as num).toInt(),
  type: (json['type'] as num).toInt(),
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'timestamp': instance.timestamp,
      'isFromUser': instance.isFromUser,
      'type': instance.type,
    };
