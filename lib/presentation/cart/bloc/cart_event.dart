part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final List<Product> products;
  const LoadCart(this.products);
  @override
  List<Object> get props => [products];
}

class AddToCart extends CartEvent {
  final Product product;
  const AddToCart(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart(this.product);
  @override
  List<Object> get props => [product];
}

class IncreaseQuantity extends CartEvent {
  final Product product;
  const IncreaseQuantity(this.product);
  @override
  List<Object> get props => [product];
}

class DecreaseQuantity extends CartEvent {
  final Product product;
  const DecreaseQuantity(this.product);
  @override
  List<Object> get props => [product];
}
