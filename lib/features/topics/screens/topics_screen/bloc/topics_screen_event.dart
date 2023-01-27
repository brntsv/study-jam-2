part of 'topics_screen_bloc.dart';

class TopicsScreenEvent extends Equatable {
  const TopicsScreenEvent();

  @override
  List<Object?> get props => [];
}

class TopicsScreenUpdate extends TopicsScreenEvent {}

class TopicsScreenCreate extends TopicsScreenEvent {}
class TopicsScreenLogOut extends TopicsScreenEvent {}

class TopicsScreenChooseChat extends TopicsScreenEvent {
  const TopicsScreenChooseChat({required this.chatId, this.chatTitle});

  final int chatId;
  final String? chatTitle;

  @override
  List<Object?> get props => [chatId];
}
