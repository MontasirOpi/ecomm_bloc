import 'package:ecomm_bloc/data/model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Product> products;

  const CustomAppBar({super.key, required this.title, required this.products});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        // Use BlocBuilder to listen for cart state changes
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int cartCount = _getCartCount(state);

            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.push("/cart", extra: widget.products);
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
            );
          },
        ),
      ],
    );
  }

  // Helper method to get cart count from state
  int _getCartCount(CartState state) {
    if (state is CartLoaded) {
      int totalItems = 0;
      for (var item in state.cartItems.values) {
        totalItems += item;
      }
      return totalItems;
    }
    return 0;
  }
}
