import 'package:equatable/equatable.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';

class CartState extends Equatable {
  final Map<Product, int> items;
  final double total;

  const CartState({required this.items, required this.total});

  factory CartState.initial() => const CartState(items: {}, total: 0.0);

  CartState copyWith({Map<Product, int>? items, double? total}) {
    return CartState(items: items ?? this.items, total: total ?? this.total);
  }

  @override
  List<Object?> get props => [items, total];
}
