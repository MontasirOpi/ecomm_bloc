// bloc/cart_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_event.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';
import 'package:hive/hive.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartLoadEvent>(_onLoadCart);
    on<CartAddEvent>(_onAddToCart);
    on<CartRemoveEvent>(_onRemoveFromCart);
    on<CartIncreaseQuantityEvent>(_onIncreaseQuantity);
    on<CartDecreaseQuantityEvent>(_onDecreaseQuantity);
    on<CartClearEvent>(_onClearCart);
  }

  static late Box _cartBox;
  final Map<Product, int> _cart = {};

  // Initialize Hive box
  static Future<void> init() async {
    if (!Hive.isBoxOpen('cartBox')) {
      _cartBox = await Hive.openBox('cartBox');
    } else {
      _cartBox = Hive.box('cartBox');
    }
  }

  void _onLoadCart(CartLoadEvent event, Emitter<CartState> emit) {
    try {
      _cart.clear();
      final savedCart = Map<int, int>.from(_cartBox.toMap());

      for (var entry in savedCart.entries) {
        try {
          final product = event.products.firstWhere((p) => p.id == entry.key);
          _cart[product] = entry.value;
        } catch (e) {
          // product not found, skip
        }
      }

      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  void _onAddToCart(CartAddEvent event, Emitter<CartState> emit) {
    try {
      _cart[event.product] = (_cart[event.product] ?? 0) + 1;
      _saveCart();
      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to add to cart: $e'));
    }
  }

  void _onRemoveFromCart(CartRemoveEvent event, Emitter<CartState> emit) {
    try {
      _cart.remove(event.product);
      _saveCart();
      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to remove from cart: $e'));
    }
  }

  void _onIncreaseQuantity(
    CartIncreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      _cart[event.product] = (_cart[event.product] ?? 0) + 1;
      _saveCart();
      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to increase quantity: $e'));
    }
  }

  void _onDecreaseQuantity(
    CartDecreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      if (_cart.containsKey(event.product) && _cart[event.product]! > 1) {
        _cart[event.product] = _cart[event.product]! - 1;
      } else {
        _cart.remove(event.product);
      }
      _saveCart();
      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to decrease quantity: $e'));
    }
  }

  void _onClearCart(CartClearEvent event, Emitter<CartState> emit) {
    try {
      _cart.clear();
      _saveCart();
      emit(CartLoaded(Map.from(_cart), _calculateTotalPrice()));
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  void _saveCart() {
    final saveMap = <int, int>{};
    _cart.forEach((product, qty) {
      saveMap[product.id] = qty;
    });
    _cartBox.putAll(saveMap);
  }

  double _calculateTotalPrice() {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }
}
