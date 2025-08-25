import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:hive/hive.dart';


class CartManager {
  static late Box _cartBox; // Hive box
  static final Map<Product, int> _cart = {};

  // Initialize Hive box (call this in main)
  static Future<void> init() async {
    if (!Hive.isBoxOpen('cartBox')) {
      _cartBox = await Hive.openBox('cartBox');
    } else {
      _cartBox = Hive.box('cartBox');
    }
  }

  // Load saved cart from Hive
  static void loadCart(List<Product> products) {
    _cart.clear();
    final savedCart = Map<int, int>.from(_cartBox.toMap());
    for (var entry in savedCart.entries) {
      try {
        final product = products.firstWhere((p) => p.id == entry.key);
        _cart[product] = entry.value;
      } catch (e) {
        // product not found, skip
      }
    }
  }

  static Map<Product, int> get cartItems => _cart;

  static void _saveCart() {
    final saveMap = <int, int>{};
    _cart.forEach((product, qty) {
      saveMap[product.id] = qty;
    });
    _cartBox.putAll(saveMap);
  }

  static void addToCart(Product product) {
    _cart[product] = (_cart[product] ?? 0) + 1;
    _saveCart();
  }

  static void removeFromCart(Product product) {
    _cart.remove(product);
    _saveCart();
  }

  static void increaseQuantity(Product product) {
    _cart[product] = (_cart[product] ?? 0) + 1;
    _saveCart();
  }

  static void decreaseQuantity(Product product) {
    if (_cart.containsKey(product) && _cart[product]! > 1) {
      _cart[product] = _cart[product]! - 1;
    } else {
      _cart.remove(product);
    }
    _saveCart();
  }

  static double getTotalPrice() {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }
}
