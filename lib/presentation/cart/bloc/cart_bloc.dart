import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:hive/hive.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  static late Box _cartBox;
  final Map<Product, int> _cart = {};

  // Initialize Hive box (call this in main)
  static Future<void> init() async {
    if (!Hive.isBoxOpen('cartBox')) {
      _cartBox = await Hive.openBox('cartBox');
    } else {
      _cartBox = Hive.box('cartBox');
    }
  }

  double _calculateTotalPrice() {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
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

      emit(
        CartLoaded(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      _cart[event.product] = (_cart[event.product] ?? 0) + 1;
      _saveCart();

      emit(
        (state as CartLoaded).copyWith(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      _cart.remove(event.product);
      _saveCart();

      emit(
        (state as CartLoaded).copyWith(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    }
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      _cart[event.product] = (_cart[event.product] ?? 0) + 1;
      _saveCart();

      emit(
        (state as CartLoaded).copyWith(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    }
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      if (_cart.containsKey(event.product) && _cart[event.product]! > 1) {
        _cart[event.product] = _cart[event.product]! - 1;
      } else {
        _cart.remove(event.product);
      }
      _saveCart();

      emit(
        (state as CartLoaded).copyWith(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      _cart.clear();
      _saveCart();

      emit(
        (state as CartLoaded).copyWith(
          cartItems: Map.from(_cart),
          totalPrice: _calculateTotalPrice(),
        ),
      );
    }
  }

  void _saveCart() {
    final saveMap = <int, int>{};
    _cart.forEach((product, qty) {
      saveMap[product.id] = qty;
    });
    _cartBox.putAll(saveMap);
  }
}
