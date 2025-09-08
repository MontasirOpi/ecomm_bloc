class ProfileState {
  final String userId;
  final String password;
  final String? message;

  ProfileState({this.userId = "", this.password = "", this.message});

  ProfileState copyWith({String? userId, String? password, String? message}) {
    return ProfileState(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }
}

class ProfileInitial extends ProfileState {}
