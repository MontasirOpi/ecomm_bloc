// cart_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_event.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final List<Product> products; // Add this parameter

  const CartScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartBloc()..add(LoadCart(products)), // Load cart with products
      child: const _CartScreenContent(),
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  const _CartScreenContent();

  @override
  Widget build(BuildContext context) {
    // Clear image cache to avoid stale data
    imageCache.clear();
    imageCache.clearLiveImages();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial || state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is CartLoaded) {
            final cartItems = state.cartItems;

            if (cartItems.isEmpty) {
              return const Center(child: Text("Cart is empty"));
            }

            return Column(
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
                          errorWidget: (context, url, error) {
                            return const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            );
                          },
                        ),
                        title: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  DecreaseQuantity(product),
                                );
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  IncreaseQuantity(product),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  RemoveFromCart(product),
                                );
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
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${state.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
