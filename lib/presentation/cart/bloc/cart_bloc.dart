// presentation/cart/bloc/cart_bloc.dart
import 'package:ecomm_bloc/presentation/cart/bloc/cart_event.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartLoadEvent>(_onCartLoad);
  
    on<CartAddItemEvent>(_onAddItem);
    on<CartRemoveItemEvent>(_onRemoveItem);
    on<CartIncreaseQuantityEvent>(_onIncreaseQuantity);
    on<CartDecreaseQuantityEvent>(_onDecreaseQuantity);
    on<CartClearEvent>(_onClearCart);
  }

  void _onCartLoad(CartLoadEvent event, Emitter<CartState> emit) {
    try {
      final cartItems = CartManager.cartItems;
      final totalPrice = CartManager.getTotalPrice();
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  void _onAddItem(CartAddItemEvent event, Emitter<CartState> emit) {
    try {
      CartManager.addToCart(event.product);
      final cartItems = CartManager.cartItems;
      final totalPrice = CartManager.getTotalPrice();
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to add item: $e'));
    }
  }

  void _onRemoveItem(CartRemoveItemEvent event, Emitter<CartState> emit) {
    try {
      CartManager.removeFromCart(event.product);
      final cartItems = CartManager.cartItems;
      final totalPrice = CartManager.getTotalPrice();
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to remove item: $e'));
    }
  }

  void _onIncreaseQuantity(
    CartIncreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      CartManager.increaseQuantity(event.product);
      final cartItems = CartManager.cartItems;
      final totalPrice = CartManager.getTotalPrice();
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to increase quantity: $e'));
    }
  }

  void _onDecreaseQuantity(
    CartDecreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      CartManager.decreaseQuantity(event.product);
      final cartItems = CartManager.cartItems;
      final totalPrice = CartManager.getTotalPrice();
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to decrease quantity: $e'));
    }
  }

  void _onClearCart(CartClearEvent event, Emitter<CartState> emit) {
    try {
      CartManager.clearCart();
      final cartItems = CartManager.cartItems; // Get the updated empty cart
      final totalPrice =
          CartManager.getTotalPrice(); // Get the updated total (0.0)
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }
}
