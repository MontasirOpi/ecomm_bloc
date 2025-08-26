import 'package:equatable/equatable.dart';

sealed class ProfileState extends Equatable {
  final String userId;
  final String password;
  final bool isLoading;
  final String? messege;

  const ProfileState({
    this.userId = "admin",
    this.password = "1234",
    this.isLoading = false,
    this.messege,
  });

  ProfileState copyWith({
    String? userId,
    String? password,
    bool? isLoading,
    String? messege,
  }) {
    return ProfileInitial(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      messege: messege ?? this.messege,
    );
  }

  @override
  List<Object> get props => [userId, password, isLoading, messege ?? ''];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({
    String userId = "admin",
    String password = "1234",
    bool isLoading = false,
    String? messege,
  }) : super(
         userId: userId,
         password: password,
         isLoading: isLoading,
         messege: messege,
       );
}
