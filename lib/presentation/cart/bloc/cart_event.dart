// presentation/cart/bloc/cart_event.dart
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvent {}

class CartLoadEvent extends CartEvent {
  CartLoadEvent(List<Product> products);
}

class CartAddItemEvent extends CartEvent {
  final Product product;

  CartAddItemEvent(this.product);
}

class CartRemoveItemEvent extends CartEvent {
  final Product product;

  CartRemoveItemEvent(this.product);
}

class CartIncreaseQuantityEvent extends CartEvent {
  final Product product;

  CartIncreaseQuantityEvent(this.product);
}

class CartDecreaseQuantityEvent extends CartEvent {
  final Product product;

  CartDecreaseQuantityEvent(this.product);
}

class CartClearEvent extends CartEvent {}
