import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import 'package:surf_practice_chat_flutter/features/chat/models/cha_multi_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final IChatRepository _chatRepository;
  final int chatId;
  final String? chatTitle;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ChatScreenBloc(
      {this.chatTitle, required StudyJamClient client, required this.chatId})
      : _chatRepository = ChatRepository(client),
        super(const ChatScreenState.initial()) {
    on<ChatScreenUpdate>(_onUpdate);
    on<ChatScreenTextChanged>(_onTextChanged);
    on<ChatScreenSendMessage>(_onSendMessage);
    on<ChatScreenShowStickerKeyboard>(_onShowKeyboard);
    on<ChatScreenHideStickerKeyboard>(_onHideKeyboard);
    on<ChatScreenChangeStickerKeyboard>(_onChangeKeyboard);
    on<ChatScreenLoadGeo>(_onLoadGeo);
    on<ChatScreenLoadImage>(_onLoadImage);
  }

  Future<void> _onUpdate(
      ChatScreenUpdate event, Emitter<ChatScreenState> emit) async {
    emit(state.copyWith(status: ChatScreenStatus.loading));
    try {
      final messages = await _chatRepository.getMessagesByChatId(chatId);
      print('_onUpdate mes:$messages len ${messages.length}, chatid $chatId');
      emit(state.copyWith(messages: messages, status: ChatScreenStatus.loaded));
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    } catch (e) {
      print(e);
    }
  }

  void _onTextChanged(
      ChatScreenTextChanged event, Emitter<ChatScreenState> emit) {
    emit(state.copyWith(messageText: event.text));
  }

  Future<void> _onSendMessage(
      ChatScreenSendMessage event, Emitter<ChatScreenState> emit) async {
    add(ChatScreenHideStickerKeyboard());
    print('sendOnMult');
    print(
        'state: chayId $chatId, geo = ${state.geolocationDto} mes = ${state.messageText} iamges = ${state.images}');
    await _chatRepository.sendMultiMessage(
      location: state.geolocationDto,
      message: state.messageText,
      images: state.images,
      chatId: chatId,
    );
    textEditingController.clear();
    emit(const ChatScreenState.clear());
    add(ChatScreenUpdate());
  }

  void _onShowKeyboard(
      ChatScreenShowStickerKeyboard event, Emitter<ChatScreenState> emit) {
    emit(state.copyWith(isStickerKeyboard: true));
  }

  void _onHideKeyboard(
      ChatScreenHideStickerKeyboard event, Emitter<ChatScreenState> emit) {
    emit(state.copyWith(isStickerKeyboard: false));
  }

  void _onChangeKeyboard(
      ChatScreenChangeStickerKeyboard event, Emitter<ChatScreenState> emit) {
    emit(state.copyWith(isStickerKeyboard: false));
  }

  Future<void> _onLoadGeo(
      ChatScreenLoadGeo event, Emitter<ChatScreenState> emit) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    emit(state.copyWith(status: ChatScreenStatus.askGeo));

    final loc = await Geolocator.getCurrentPosition();
    final gDto = ChatGeolocationDto.fromGeoPoint([loc.latitude, loc.longitude]);
    emit(state.copyWith(geolocationDto: gDto, status: ChatScreenStatus.loaded));
  }

  void _onLoadImage(ChatScreenLoadImage event, Emitter<ChatScreenState> emit) {
    emit(state.copyWith(images: [...state.images, event.url]));
  }
}
