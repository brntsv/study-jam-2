part of 'chat_screen_bloc.dart';

class ChatScreenEvent extends Equatable {
  const ChatScreenEvent();

  @override
  List<Object?> get props => [];
}

class ChatScreenUpdate extends ChatScreenEvent {}

class ChatScreenTextChanged extends ChatScreenEvent {
  const ChatScreenTextChanged(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

class ChatScreenSendMessage extends ChatScreenEvent {}

class ChatScreenLoadGeo extends ChatScreenEvent {}

class ChatScreenShowGallery extends ChatScreenEvent {}

class ChatScreenHideGallery extends ChatScreenEvent {}

class ChatScreenChoosePhoto extends ChatScreenEvent {}

class ChatScreenLoadImage extends ChatScreenEvent {
  const ChatScreenLoadImage(this.url);
  final String url;
  @override
  List<Object?> get props => [url];
}
