import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(ChatScreenInitial()) {
    on<ChatScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
