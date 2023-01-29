part of 'create_topic_screen_bloc.dart';

enum CreateTopicScreenStatus { initial, loading, success }

class CreateTopicScreenState extends Equatable {
  const CreateTopicScreenState(
      {required this.status, required this.title, required this.description});

  const CreateTopicScreenState.initial()
      : status = CreateTopicScreenStatus.initial,
        title = '',
        description = '';

  final CreateTopicScreenStatus status;
  final String title;
  final String description;

  @override
  List<Object> get props => [status, title, description];

  CreateTopicScreenState copyWith({
    CreateTopicScreenStatus? status,
    String? title,
    String? description,
  }) {
    return CreateTopicScreenState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
