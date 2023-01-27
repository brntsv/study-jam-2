part of 'chat_screen_bloc.dart';

enum ChatScreenStatus { initial, loading, loaded, askGeo }

class ChatScreenState extends Equatable {
  final Iterable<ChatMultiMessageDto> messages;
  final ChatScreenStatus status;
  final String messageText;
  final ChatGeolocationDto? geolocationDto;
  final bool isStickerKeyboard;
  final List<String> images;

  const ChatScreenState({
    required this.messages,
    required this.status,
    required this.messageText,
    required this.geolocationDto,
    required this.isStickerKeyboard,
    required this.images,
  });

  const ChatScreenState.initial()
      : messages = const [],
        status = ChatScreenStatus.initial,
        messageText = '',
        geolocationDto = null,
        isStickerKeyboard = false,
        images = const [];

  @override
  List<Object> get props =>
      [messages, status, messageText, isStickerKeyboard, images];

  const ChatScreenState.clear()
      : messages = const [],
        status = ChatScreenStatus.loaded,
        messageText = '',
        geolocationDto = null,
        isStickerKeyboard = false,
        images = const [];

  ChatScreenState copyWith({
    Iterable<ChatMultiMessageDto>? messages,
    ChatScreenStatus? status,
    String? messageText,
    ChatGeolocationDto? geolocationDto,
    bool? isStickerKeyboard,
    List<String>? images,
  }) {
    return ChatScreenState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      messageText: messageText ?? this.messageText,
      geolocationDto: geolocationDto ?? this.geolocationDto,
      isStickerKeyboard: isStickerKeyboard ?? this.isStickerKeyboard,
      images: images ?? this.images,
    );
  }
}
