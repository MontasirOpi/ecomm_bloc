import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartItems = CartManager.cartItems;

    // Clear image cache to avoid stale data
    imageCache.clear();
    imageCache.clearLiveImages();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Cart",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text("Cart is empty", style: theme.textTheme.bodyMedium),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems.keys.elementAt(index);
                      final quantity = cartItems[product]!;

                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: product.image,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.broken_image,
                            size: 40,
                            color: theme.iconTheme.color?.withOpacity(0.6),
                          ),
                        ),
                        title: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  CartManager.decreaseQuantity(product);
                                });
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: theme.textTheme.bodyMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  CartManager.increaseQuantity(product);
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: theme.colorScheme.error,
                              ),
                              onPressed: () {
                                setState(() {
                                  CartManager.removeFromCart(product);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Removed from cart"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Total Price Section
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: theme.cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${CartManager.getTotalPrice().toStringAsFixed(2)}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Check Out"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
