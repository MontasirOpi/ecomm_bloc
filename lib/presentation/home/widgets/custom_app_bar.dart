import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:ecomm_bloc/presentation/cart/ui/cart_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title, required List products});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _getCartCount() {
    int totalItems = 0;
    for (var item in CartManager.cartItems.values) {
      totalItems += item;
    }
    return totalItems;
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
                  MaterialPageRoute(builder: (_) => const CartScreen()),
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
