import 'package:ecomm_bloc/data/api_service.dart';

import 'package:ecomm_bloc/presentation/auth/login/bloc/login_event.dart';
import 'package:ecomm_bloc/presentation/auth/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Box authBox;

  LoginBloc(this.authBox) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      // Call API
      final loginResponse = await ApiService.loginUser(
        event.userId,
        event.password,
      );

      // Save username, password, and token in Hive
      await authBox.put("username", event.userId);
      await authBox.put("password", event.password); // ✅ Save password
      await authBox.put("token", loginResponse.token);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure("Login failed: $e"));
    }
  }
}
