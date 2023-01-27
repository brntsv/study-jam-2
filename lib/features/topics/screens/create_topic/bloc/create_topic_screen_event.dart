part of 'create_topic_screen_bloc.dart';

class CreateTopicScreenEvent extends Equatable {
  const CreateTopicScreenEvent();

  @override
  List<Object?> get props => [];
}

class CreateTopicScreenTitleChanged extends CreateTopicScreenEvent {
  const CreateTopicScreenTitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class CreateTopicScreenDescriptionChanged extends CreateTopicScreenEvent {
  const CreateTopicScreenDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class CreateTopicScreenCreate extends CreateTopicScreenEvent {}
