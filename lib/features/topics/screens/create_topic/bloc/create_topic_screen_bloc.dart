import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_send_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

part 'create_topic_screen_event.dart';
part 'create_topic_screen_state.dart';

class CreateTopicScreenBloc
    extends Bloc<CreateTopicScreenEvent, CreateTopicScreenState> {
  CreateTopicScreenBloc({required StudyJamClient client})
      : _topicsRepository = ChatTopicsRepository(client),
        super(const CreateTopicScreenState.initial()) {
    on<CreateTopicScreenTitleChanged>(_onTitleChanged);
    on<CreateTopicScreenDescriptionChanged>(_onDescriptionChanged);
    on<CreateTopicScreenCreate>(_onCreate);
  }

  final IChatTopicsRepository _topicsRepository;

  void _onTitleChanged(CreateTopicScreenTitleChanged event,
      Emitter<CreateTopicScreenState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(CreateTopicScreenDescriptionChanged event,
      Emitter<CreateTopicScreenState> emit) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onCreate(CreateTopicScreenCreate event,
      Emitter<CreateTopicScreenState> emit) async {
    emit(state.copyWith(status: CreateTopicScreenStatus.loading));
    print(state);
    final topic =
        ChatTopicSendDto(name: state.title, description: state.description);
    print(topic);

    await _topicsRepository.createTopic(topic);
    emit(state.copyWith(status: CreateTopicScreenStatus.success));
    print('success');
  }
}
