// states/cart_states.dart
import 'package:flutter/material.dart';

import 'package:ecomm_bloc/data/model/product_model.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> cartItems;
  final double totalPrice;

  CartLoaded(this.cartItems, this.totalPrice);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
