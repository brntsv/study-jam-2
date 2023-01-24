import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/bloc/auth_screen_bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/token.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Screen for authorization process.
///
/// Contains [IAuthRepository] to do so.
class AuthScreen extends StatelessWidget {
  /// Repository for auth implementation.
  final IAuthRepository authRepository;

  /// Constructor for [AuthScreen].
  const AuthScreen({required this.authRepository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          AuthScreenBloc(authRepository: authRepository)..add(AuthScreenInit()),
      child: BlocListener<AuthScreenBloc, AuthScreenState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          print(state);
          switch (state.status) {
            case AuthScreenStatus.success:
              _pushToChat(context, state.client!);
              break;
            case AuthScreenStatus.initial:
              break;
            case AuthScreenStatus.loading:
              print('loading');
              break;
            case AuthScreenStatus.failure:
              _showErrorSnack(context);
              break;
            case AuthScreenStatus.tryLogWithSaved:
              break;
          }
        },
        child: const AuthView(),
      ),
    );
  }

  void _showErrorSnack(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(' Error: invalid login or password'),
            ],
          ),
        ),
      );
  }

  void _pushToChat(BuildContext context, StudyJamClient client) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(appBar: AppBar());
      // TopicsPage(client: client);
    }));
  }

  // void _pushToChat(BuildContext context, TokenDto token) {
  //   Navigator.push<ChatScreen>(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return ChatScreen(
  //           chatRepository: ChatRepository(
  //             StudyJamClient().getAuthorizedClient(token.token),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthScreenBloc>();
    String initLogin = 'brntsv';
    String initPassword = 'u1ME9HAhVhWj';

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: initLogin,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                labelText: 'Логин',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => {
                bloc.add(
                  AuthScreenLoginChanged(value),
                ),
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: initPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Пароль',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => {
                bloc.add(
                  AuthScreenPasswordChanged(value),
                ),
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {bloc.add(AuthScreenContinueClicked())},
                child: const Text('ДАЛЕЕ'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
