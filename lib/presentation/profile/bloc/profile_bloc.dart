import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_event.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Box authBox = Hive.box("authBox");

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<ChangePassword>(_onChangePassword);
    on<Logout>(_onLogout);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    final userId = authBox.get("username", defaultValue: "admin");
    final password = authBox.get("password", defaultValue: "12345");
    emit(state.copyWith(userId: userId, password: password));
  }

  void _onChangePassword(ChangePassword event, Emitter<ProfileState> emit) {
    authBox.put("password", event.newPassword);
    emit(
      state.copyWith(
        password: event.newPassword,
        message: "Password updated successfully",
      ),
    );
  }

  void _onLogout(Logout event, Emitter<ProfileState> emit) {
    authBox.put("isLoggedIn", false);
    authBox.delete("token");
    authBox.delete("username");
  }
}
