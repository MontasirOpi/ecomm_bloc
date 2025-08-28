// events/cart_events.dart
import 'package:flutter/material.dart';

import 'package:ecomm_bloc/data/model/product_model.dart';

@immutable
abstract class CartEvent {}

class CartLoadEvent extends CartEvent {
  final List<Product> products;
  CartLoadEvent(this.products);
}

class CartAddEvent extends CartEvent {
  final Product product;
  CartAddEvent(this.product);
}

class CartRemoveEvent extends CartEvent {
  final Product product;
  CartRemoveEvent(this.product);
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
