part of 'chat_screen_bloc.dart';

enum ChatScreenStatus { initial, loading, loaded, askGeo }

class ChatScreenState extends Equatable {
  final Iterable<ChatMultiMessageDto> messages;
  final ChatScreenStatus status;
  final String messageText;
  final ChatGeolocationDto? geolocationDto;
  final bool isStickerKeyboard;
  final List<String> stickers;
  // final List<XFile>? images;

  const ChatScreenState({
    required this.messages,
    required this.status,
    required this.messageText,
    required this.geolocationDto,
    required this.isStickerKeyboard,
    required this.stickers,
    // required this.images,
  });

  const ChatScreenState.initial()
      : messages = const [],
        status = ChatScreenStatus.initial,
        messageText = '',
        geolocationDto = null,
        isStickerKeyboard = false,
        stickers = const [];
  // images = const [];

  @override
  List<Object> get props =>
      [messages, status, messageText, isStickerKeyboard, stickers];

  const ChatScreenState.clear()
      : messages = const [],
        status = ChatScreenStatus.loaded,
        messageText = '',
        geolocationDto = null,
        isStickerKeyboard = false,
        stickers = const [];
  // images = const [];

  ChatScreenState copyWith({
    Iterable<ChatMultiMessageDto>? messages,
    ChatScreenStatus? status,
    String? messageText,
    ChatGeolocationDto? geolocationDto,
    bool? isStickerKeyboard,
    List<String>? stickers,
    // List<XFile>? images,
  }) {
    return ChatScreenState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      messageText: messageText ?? this.messageText,
      geolocationDto: geolocationDto ?? this.geolocationDto,
      isStickerKeyboard: isStickerKeyboard ?? this.isStickerKeyboard,
      stickers: stickers ?? this.stickers,
      // images: images ?? this.images,
    );
  }
}
