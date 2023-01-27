part of 'topics_screen_bloc.dart';

enum TopicsScreenStatus { initial, loaded, openChat, createNew, logOut }

class TopicsScreenState extends Equatable {
  const TopicsScreenState(
      {required this.chats, required this.status, this.chatId, this.chatTitle});

  const TopicsScreenState.initial()
      : chats = const [],
        status = TopicsScreenStatus.initial,
        chatId = null,
        chatTitle = null;

  final List<ChatTopicDto> chats;

  final TopicsScreenStatus status;

  final int? chatId;

  final String? chatTitle;

  @override
  List<Object> get props => [chats, status];

  TopicsScreenState copyWith({
    List<ChatTopicDto>? chats,
    TopicsScreenStatus? status,
    int? chatId,
    String? chatTitle,
  }) {
    return TopicsScreenState(
      chats: chats ?? this.chats,
      status: status ?? this.status,
      chatId: chatId ?? this.chatId,
      chatTitle: chatTitle ?? this.chatTitle,
    );
  }
}
