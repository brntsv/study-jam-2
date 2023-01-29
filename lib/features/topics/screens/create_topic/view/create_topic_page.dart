import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/create_topic/bloc/create_topic_screen_bloc.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class CreateTopicPage extends StatelessWidget {
  const CreateTopicPage({Key? key, required this.client}) : super(key: key);
  final StudyJamClient client;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTopicScreenBloc(client: client),
      child: BlocListener<CreateTopicScreenBloc, CreateTopicScreenState>(
        listenWhen: (prev, cur) => prev.status != cur.status,
        listener: (context, state) {
          if (state.status == CreateTopicScreenStatus.success) {
            Navigator.pop(context);
          }
        },
        child: const CreateTopicView(),
      ),
    );
  }
}

class CreateTopicView extends StatelessWidget {
  const CreateTopicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateTopicScreenBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Название топика',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (value) {
                  bloc.add(CreateTopicScreenTitleChanged(value));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (value) {
                  bloc.add(CreateTopicScreenDescriptionChanged(value));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  bloc.add(CreateTopicScreenCreate());
                },
                child: const Text('Создать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
