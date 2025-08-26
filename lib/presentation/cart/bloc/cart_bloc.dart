import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';
import 'package:ecomm_bloc/presentation/cart/card_manager.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    //on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }
  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    CartManager.loadCart(event.products);
    emit(_buildState());
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    CartManager.addToCart(event.product);
    emit(_buildState());
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    CartManager.increaseQuantity(event.product);
    emit(_buildState());
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    CartManager.decreaseQuantity(event.product);
    emit(_buildState());
  }

  CartState _buildState() {
    return CartState(
      items: Map<Product, int>.from(CartManager.cartItems),
      total: CartManager.getTotalPrice(),
    );
  }
}
