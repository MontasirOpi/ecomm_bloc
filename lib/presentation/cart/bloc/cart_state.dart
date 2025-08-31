// presentation/cart/bloc/cart_state.dart

import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> cartItems;
  final double totalPrice;

  CartLoaded({required this.cartItems, required this.totalPrice});

  CartLoaded copyWith({Map<Product, int>? cartItems, double? totalPrice}) {
    return CartLoaded(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
