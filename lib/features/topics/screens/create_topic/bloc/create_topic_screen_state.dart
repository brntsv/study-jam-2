part of 'create_topic_screen_bloc.dart';

enum CreateTopicScreenStatus { initial, loading, success }

class CreateTopicScreenState extends Equatable {
  const CreateTopicScreenState(
      {required this.status, required this.name, required this.description});

  const CreateTopicScreenState.initial()
      : status = CreateTopicScreenStatus.initial,
        name = '',
        description = '';

  final CreateTopicScreenStatus status;
  final String name;
  final String description;

  @override
  List<Object> get props => [status, name, description];

  CreateTopicScreenState copyWith({
    CreateTopicScreenStatus? status,
    String? title,
    String? description,
  }) {
    return CreateTopicScreenState(
      status: status ?? this.status,
      name: title ?? this.name,
      description: description ?? this.description,
    );
  }
}
