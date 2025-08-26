import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> cartItems;
  final double totalPrice;

  const CartLoaded({required this.cartItems, required this.totalPrice});

  @override
  List<Object> get props => [cartItems, totalPrice];

  CartLoaded copyWith({Map<Product, int>? cartItems, double? totalPrice}) {
    return CartLoaded(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
