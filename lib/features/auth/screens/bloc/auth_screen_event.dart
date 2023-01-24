part of 'auth_screen_bloc.dart';

class AuthScreenEvent extends Equatable {
  const AuthScreenEvent();

  @override
  List<Object?> get props => [];
}

class AuthScreenLoginChanged extends AuthScreenEvent {
  final String login;
  const AuthScreenLoginChanged(this.login);

  @override
  List<Object?> get props => [login];
}

class AuthScreenPasswordChanged extends AuthScreenEvent {
  final String password;
  const AuthScreenPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class AuthScreenContinueClicked extends AuthScreenEvent {}

class AuthScreenInit extends AuthScreenEvent {}
