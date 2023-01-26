import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import 'chat_geolocation_geolocation_dto.dart';

class ChatMultiMessageDto extends ChatMessageDto {
  final ChatGeolocationDto? location;

  final List<String>? images;

  final int? chatId;

  const ChatMultiMessageDto(
      {required ChatUserDto chatUserDto,
      this.location,
      this.images,
      required String message,
      required DateTime createdDate,
      this.chatId})
      : super(
          chatUserDto: chatUserDto,
          message: message,
          createdDateTime: createdDate,
        );

  ChatMultiMessageDto.fromSJClient(
      {required SjMessageDto sjMessageDto,
      required SjUserDto sjUserDto,
      required bool isLocalUser})
      : location = sjMessageDto.geopoint != null
            ? ChatGeolocationDto.fromGeoPoint(sjMessageDto.geopoint!)
            : null,
        images = sjMessageDto.images,
        chatId = sjMessageDto.chatId,
        super(
          createdDateTime: sjMessageDto.created,
          message: sjMessageDto.text,
          chatUserDto: isLocalUser
              ? ChatUserLocalDto.fromSJClient(sjUserDto)
              : ChatUserDto.fromSJClient(sjUserDto),
        );
}
