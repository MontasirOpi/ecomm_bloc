// home_screen_state.dart
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Product> products;
  final int currentTab;
  final bool hasError;

  const HomeScreenLoaded({
    required this.products,
    this.currentTab = 0,
    this.hasError = false,
  });

  @override
  List<Object> get props => [products, currentTab, hasError];

  HomeScreenLoaded copyWith({
    List<Product>? products,
    int? currentTab,
    bool? hasError,
  }) {
    return HomeScreenLoaded(
      products: products ?? this.products,
      currentTab: currentTab ?? this.currentTab,
      hasError: hasError ?? this.hasError,
    );
  }
}

class HomeScreenError extends HomeScreenState {
  final String message;

  const HomeScreenError(this.message);

  @override
  List<Object> get props => [message];
}
