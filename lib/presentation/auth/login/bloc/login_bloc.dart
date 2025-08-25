
import 'package:ecomm_bloc/presentation/auth/login/bloc/login_event.dart';
import 'package:ecomm_bloc/presentation/auth/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Box authBox;

  final String defaultUserId = "admin";
  final String defaultPassword = "12345";

  LoginBloc(this.authBox) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay

    String savedPass = authBox.get("password", defaultValue: defaultPassword);

    if (event.userId == defaultUserId && event.password == savedPass) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Invalid User ID or Password"));
    }
  }
}
