import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';

part 'topics_screen_event.dart';
part 'topics_screen_state.dart';

class TopicsScreenBloc extends Bloc<TopicsScreenEvent, TopicsScreenState> {
  TopicsScreenBloc({required StudyJamClient client})
      : topicsRepository = ChatTopicsRepository(client),
        authRepository = AuthRepository(client),
        super(const TopicsScreenState.initial()) {
    on<TopicsScreenUpdate>(_onUpdate);
    on<TopicsScreenCreate>(_onCreate);
    on<TopicsScreenChooseChat>(_onChooseChat);
    on<TopicsScreenLogOut>(_onLogOut);
  }

  final IChatTopicsRepository topicsRepository;
  final IAuthRepository authRepository;

  Future<void> _onUpdate(
      TopicsScreenUpdate event, Emitter<TopicsScreenState> emit) async {
    emit(state.copyWith(status: TopicsScreenStatus.initial));
    try {
      print('_onUpdate');
      final chats = List<ChatTopicDto>.from(
          await topicsRepository.getTopics(topicsStartDate: DateTime(2022)));
      emit(state.copyWith(status: TopicsScreenStatus.loaded, chats: chats));
    } catch (e) {
      print(e);
    }
  }

  void _onChooseChat(
      TopicsScreenChooseChat event, Emitter<TopicsScreenState> emit) {
    print('on choose ${event.chatId}');
    emit(state.copyWith(
        status: TopicsScreenStatus.openChat,
        chatId: event.chatId,
        chatTitle: event.chatTitle));
    emit(state.copyWith(status: TopicsScreenStatus.initial));
  }

  void _onCreate(
      TopicsScreenCreate event, Emitter<TopicsScreenState> emit) async {
    emit(state.copyWith(status: TopicsScreenStatus.createNew));
    emit(state.copyWith(status: TopicsScreenStatus.initial));
  }

  Future<void> _onLogOut(
      TopicsScreenLogOut event, Emitter<TopicsScreenState> emit) async {
    authRepository.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    emit(state.copyWith(status: TopicsScreenStatus.logOut));
  }
}
