import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class ChangePassword extends ProfileEvent {
  final String newPassword;
  const ChangePassword(this.newPassword);
  @override
  List<Object> get props => [newPassword];
}

class Logout extends ProfileEvent {}
