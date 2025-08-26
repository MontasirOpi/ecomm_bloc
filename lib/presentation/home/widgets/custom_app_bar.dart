import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/ui/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Product> products; // Add products parameter

  const CustomAppBar({
    super.key,
    required this.title,
    required this.products, // Require products
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _getCartCount() {
    // Use CartBloc to get cart count instead of CartManager
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      int totalItems = 0;
      for (var item in cartState.cartItems.values) {
        totalItems += item;
      }
      return totalItems;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int cartCount = _getCartCount();

    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(
                      products: widget.products,
                    ), // Use widget.products
                  ),
                ).then((_) {
                  setState(() {}); // refresh badge count when coming back
                });
              },
              icon: const Icon(Icons.add_shopping_cart, size: 36),
            ),
            if (cartCount > 0)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    "$cartCount",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
