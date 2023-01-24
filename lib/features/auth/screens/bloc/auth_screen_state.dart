part of 'auth_screen_bloc.dart';

enum AuthScreenStatus { initial, loading, success, failure, tryLogWithSaved }

class AuthScreenState extends Equatable {
  final String login;
  final String password;
  final bool isClickedContinue;
  final AuthScreenStatus status;
  final StudyJamClient? client;

  const AuthScreenState({
    required this.login,
    required this.password,
    required this.isClickedContinue,
    required this.status,
    this.client,
  });

  const AuthScreenState.initial()
      : login = '',
        password = '',
        isClickedContinue = false,
        status = AuthScreenStatus.initial,
        client = null;

  @override
  List<Object> get props => [login, password, isClickedContinue, status];

  AuthScreenState copyWith({
    String? login,
    String? password,
    bool? isClickedContinue,
    AuthScreenStatus? status,
    StudyJamClient? client,
  }) {
    return AuthScreenState(
      login: login ?? this.login,
      password: password ?? this.password,
      isClickedContinue: isClickedContinue ?? this.isClickedContinue,
      status: status ?? this.status,
      client: client ?? this.client,
    );
  }
}
