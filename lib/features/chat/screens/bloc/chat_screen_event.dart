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

class ChatScreenShowStickers extends ChatScreenEvent {}

class ChatScreenHideStickers extends ChatScreenEvent {}

class ChatScreenChooseSticker extends ChatScreenEvent {}

class ChatScreenLoadSticker extends ChatScreenEvent {
  const ChatScreenLoadSticker(this.url);
  final String url;
  @override
  List<Object?> get props => [url];
}

// class ChatScreenSelectImages extends ChatScreenEvent {
//   const ChatScreenSelectImages(this.image);
//   final List<XFile> image;
//   @override
//   List<Object?> get props => [image];
// }

// class ChatScreenUnselectImages extends ChatScreenEvent {}
