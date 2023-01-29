import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/screens.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/create_topic/create_topic.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_screen/bloc/topics_screen_bloc.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({Key? key, required this.client}) : super(key: key);
  final StudyJamClient client;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TopicsScreenBloc(client: client)..add(TopicsScreenUpdate()),
      child: BlocListener<TopicsScreenBloc, TopicsScreenState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case TopicsScreenStatus.initial:
              break;
            case TopicsScreenStatus.loaded:
              break;
            case TopicsScreenStatus.openChat:
              if (state.chatId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return ChatScreen(
                        client: client,
                        chatId: state.chatId!,
                        chatTitle: state.chatTitle,
                      );
                    },
                  ),
                );
              }
              break;
            case TopicsScreenStatus.createNew:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return CreateTopicPage(client: client);
                  },
                ),
              );
              break;
            case TopicsScreenStatus.logOut:
              Navigator.pop(context);
              break;
          }
        },
        child: const TopicsView(),
      ),
    );
  }
}

class TopicsView extends StatelessWidget {
  const TopicsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicsScreenBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            bloc.add(TopicsScreenLogOut());
          },
          icon: const Icon(Icons.logout),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                bloc.add(TopicsScreenCreate());
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TopicsScreenBloc, TopicsScreenState>(
        builder: (context, state) {
          final chats = state.chats;
          return LiquidPullToRefresh(
            color: colorScheme.primary.withOpacity(0.6),
            height: 50,
            springAnimationDurationInMilliseconds: 300,
            showChildOpacityTransition: false,
            onRefresh: () async {
              bloc.add(TopicsScreenUpdate());
            },
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    bloc.add(TopicsScreenChooseChat(
                        chatId: chats[index].id, chatTitle: chats[index].name));
                  },
                  child: ListTile(
                    leading: _TopicAvatar(title: chats[index].name),
                    title: Text(chats[index].name ?? ''),
                    subtitle: Text(chats[index].description ?? ''),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _TopicAvatar extends StatelessWidget {
  static const double _size = 42;
  final String? title;

  const _TopicAvatar({
    this.title,
    Key? key,
  }) : super(key: key);

  String iconText() {
    var result = '';

    if (title != null && title!.isNotEmpty) {
      result = title!.split(' ').first[0];
      try {
        result += title!.split(' ').last[0];
      } catch (e) {
        print(e);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    int colorCode = iconText().isEmpty
        ? 0xFFc3b7e7
        : iconText().hashCode % 0xFFFFFF + 0xFF000000;

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: _size,
      height: _size,
      child: Material(
        color: Color(colorCode),
        shape: const CircleBorder(),
        child: Center(
          child: Text(
            iconText(),
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
