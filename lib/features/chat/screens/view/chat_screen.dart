import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/cha_multi_message_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';
import 'package:intl/intl.dart';

import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/bloc/chat_screen_bloc.dart';
import 'package:surf_practice_chat_flutter/theme/theme.dart';

/// Main screen of chat app, containing messages.
class ChatScreen extends StatelessWidget {
  /// Repository for chat functionality.
  final StudyJamClient client;
  final int chatId;
  final String? chatTitle;

  /// Constructor for [ChatScreen].
  const ChatScreen({
    Key? key,
    required this.client,
    required this.chatId,
    this.chatTitle,
  }) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   _onUpdatePressed();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatScreenBloc(client: client, chatId: chatId, chatTitle: chatTitle)
            ..add(ChatScreenUpdate()),
      child: const ChatView(),
    );
  }

  // Future<void> _onUpdatePressed() async {
  //   final messages = await widget.chatRepository.getMessages();
  //   setState(() {
  //     _currentMessages = messages;
  //   });
  //   scrollToEnd();
  // }

  // void scrollToEnd() {
  //   scrollController
  //       .jumpTo(scrollController.position.maxScrollExtent + 1000000);
  // }

  // Future<void> _onSendPressed(String messageText) async {
  //   final messages = await widget.chatRepository.sendMessage(messageText);
  //   setState(() {
  //     _currentMessages = messages;
  //   });
  // }
}

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ChatScreenBloc>();

    return BlocBuilder<ChatScreenBloc, ChatScreenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: _ChatAppBar(
              controller: TextEditingController(),
              onUpdatePressed: () => bloc.add(ChatScreenUpdate()),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: _ChatBody(
                    messages: state.messages,
                  ),
                ),
              ),
              _ChatTextField(
                  onSendPressed: () => bloc.add(ChatScreenSendMessage())),
            ],
          ),
        );
      },
    );
  }
}

class _ChatBody extends StatelessWidget {
  final Iterable<ChatMultiMessageDto> messages;

  const _ChatBody({required this.messages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: context.watch<ChatScreenBloc>().scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (_, index) => _ChatMessage(
        chatData: messages.elementAt(index),
      ),
    );
  }
}

class _ChatTextField extends StatelessWidget {
  final VoidCallback onSendPressed;

  const _ChatTextField({
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ChatScreenBloc>();
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: mediaQuery.padding.bottom + 8,
          left: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => bloc.add(ChatScreenLoadGeo()),
                  icon: const Icon(Icons.place),
                  color: colorScheme.primary,
                ),
                Expanded(
                  child: TextField(
                    controller:
                        context.watch<ChatScreenBloc>().textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Сообщение',
                    ),
                    onChanged: (value) =>
                        bloc.add(ChatScreenTextChanged(value)),
                  ),
                ),
                IconButton(
                  onPressed: () => {onSendPressed()},
                  icon: const Icon(Icons.send),
                  color: colorScheme.primary,
                ),
              ],
            ),
            BlocBuilder<ChatScreenBloc, ChatScreenState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    state.geolocationDto != null
                        ? const Text('Location added')
                        : Container(),
                    state.images.isNotEmpty
                        ? Text('Images count: ${state.images.length}')
                        : Container(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget {
  final VoidCallback onUpdatePressed;
  final TextEditingController controller;

  const _ChatAppBar({
    required this.onUpdatePressed,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onUpdatePressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage extends StatelessWidget {
  final ChatMultiMessageDto chatData;

  const _ChatMessage({required this.chatData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMe = chatData.chatUserDto is ChatUserLocalDto;
    DateFormat dateFormat = DateFormat('dd.MM.yy  HH:mm');

    final children = [
      _ChatAvatar(userData: chatData.chatUserDto),
      const SizedBox(width: 5),
      Flexible(
        fit: FlexFit.tight,
        child: Container(
          decoration: BoxDecoration(
              color: isMe
                  ? colorScheme.primary.withOpacity(.6)
                  : AppColors.messageCard,
              border: Border.all(
                color: isMe ? colorScheme.primary : Colors.black,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatData.chatUserDto.name ?? 'Аноним',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(chatData.message ?? ''),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: _MessageImages(images: chatData.images),
              ),
              chatData.location != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.place, size: 17),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            MapsLauncher.launchCoordinates(
                                chatData.location!.latitude,
                                chatData.location!.longitude);
                          },
                          child: Text(
                            'Открыть в картах',
                            style: TextStyle(
                              color: isMe ? Colors.black : colorScheme.primary,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateFormat.format(chatData.createdDateTime),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500, minHeight: 40.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMe ? children.reversed.toList() : children,
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final ChatUserDto userData;

  const _ChatAvatar({required this.userData, Key? key}) : super(key: key);

  String iconText() {
    var result = '';
    if (userData.name != null && userData.name!.isNotEmpty) {
      result = userData.name!.split(' ').first[0];
      try {
        result += userData.name!.split(' ').last[0];
      } catch (e) {
        print(e);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // генерируем цвет на основе инициалов, чтобы добиться одинакового цвета на
    // всех устройствах. Для пустых инициалов константый цвет
    int colorCode = iconText().isEmpty
        ? 0xFFc3b7e7
        : iconText().hashCode % 0xFFFFFF + 0xFF000000;
    // / / / / / / / / / / / / / / / / / / / / / / / /
    final colorScheme = Theme.of(context).colorScheme;
    final isMe = userData is ChatUserLocalDto;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: isMe ? Colors.transparent : AppColors.avatarBorder,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50.0))),
      child: CircleAvatar(
        backgroundColor: isMe ? colorScheme.primary : Color(colorCode),
        child: Text(
          iconText(),
          style: TextStyle(
            color: isMe ? colorScheme.onPrimary : AppColors.textAvatarColor,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}

class _MessageImages extends StatelessWidget {
  List<String>? images;
  _MessageImages({Key? key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: images != null
          ? images!.map((e) => _SizedImage(url: e)).toList()
          : [Container()],
    );
  }
}

class _SizedImage extends StatelessWidget {
  const _SizedImage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.network(url,
                errorBuilder: (context, exception, stackTrace) {
              return const Text('😤');
            })),
      ),
    );
  }
}
