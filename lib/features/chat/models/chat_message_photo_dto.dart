// ignore: implementation_imports
import 'package:surf_study_jam/src/dto.dart';

import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';

class ChatMessagePhotoDto extends ChatMessageDto {
  final List<String> images;

  ChatMessagePhotoDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
  })  : images = sjMessageDto.images!,
        super(
          chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
          message: sjMessageDto.text,
          createdDateTime: sjMessageDto.created,
        );

  const ChatMessagePhotoDto({
    required ChatUserDto chatUserDto,
    required String? message,
    required DateTime createdDateTime,
    required this.images,
  }) : super(
            chatUserDto: chatUserDto,
            message: message,
            createdDateTime: createdDateTime);
}
