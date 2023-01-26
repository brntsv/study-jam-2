import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/cha_multi_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(const ChatScreenState.initial()) {
    on<ChatScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
