import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

part 'auth_screen_event.dart';
part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  final IAuthRepository _repository;

  AuthScreenBloc({required IAuthRepository authRepository})
      : _repository = authRepository,
        super(const AuthScreenState.initial()) {
    on<AuthScreenLoginChanged>(_onLoginChanged);
    on<AuthScreenPasswordChanged>(_onPasswordChanged);
    on<AuthScreenContinueClicked>(_onContinueClicked);
    on<AuthScreenInit>(_onInit);
  }

  void _onLoginChanged(
      AuthScreenLoginChanged event, Emitter<AuthScreenState> emit) {
    print('_onLoginChanged ${event.login}');

    emit(state.copyWith(login: event.login));
  }

  void _onPasswordChanged(
      AuthScreenPasswordChanged event, Emitter<AuthScreenState> emit) {
    print('_onPasswordChanged ${event.password}');

    emit(state.copyWith(password: event.password));
  }

  Future<void> _onContinueClicked(
      AuthScreenContinueClicked event, Emitter<AuthScreenState> emit) async {
    print('_onContinueClicked');
    emit(state.copyWith(
        isClickedContinue: true, status: AuthScreenStatus.loading));
    final prefs = await SharedPreferences.getInstance();

    try {
      print('${state.login} ${state.password}');
      var token = await _repository.signIn(
          login: state.login, password: state.password);
      prefs.setString('token', token.token);

      emit(state.copyWith(
          client: StudyJamClient().getAuthorizedClient(token.token),
          status: AuthScreenStatus.success));
    } catch (e) {
      print(e);
      print('${state.login} ${state.password}');
      emit(state.copyWith(status: AuthScreenStatus.failure));
      emit(state.copyWith(status: AuthScreenStatus.initial));
    }
  }

  Future<void> _onInit(
      AuthScreenInit event, Emitter<AuthScreenState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedToken = prefs.getString('token');
    print('savedToken $savedToken');

    if (savedToken != null && savedToken.isNotEmpty) {
      emit(state.copyWith(
          client: StudyJamClient().getAuthorizedClient(savedToken),
          status: AuthScreenStatus.success));
    }
    emit(state.copyWith(status: AuthScreenStatus.tryLogWithSaved));
  }
}
