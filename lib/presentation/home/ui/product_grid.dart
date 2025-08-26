import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:ecomm_bloc/presentation/home/ui/product_card.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onAddToCart: () {
            CartManager.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Added to cart"),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
