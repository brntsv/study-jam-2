part of 'chat_screen_bloc.dart';

abstract class ChatScreenState extends Equatable {
  const ChatScreenState();
  
  @override
  List<Object> get props => [];
}

class ChatScreenInitial extends ChatScreenState {}
