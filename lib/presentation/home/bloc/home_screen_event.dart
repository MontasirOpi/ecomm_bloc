// home_screen_event.dart
import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends HomeScreenEvent {}

class ChangeTab extends HomeScreenEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class RefreshProducts extends HomeScreenEvent {}
