import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/data/api_service.dart';
import 'package:ecomm_bloc/presentation/cart/card_manager.dart';
import 'package:ecomm_bloc/presentation/home/product_grid.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_app_bar.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_bottom_navBar.dart';
import 'package:flutter/material.dart';

// Placeholder for ProfileScreen (replace with actual implementation)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Screen'));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<Product> products = [];
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadProducts();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("✅ App is in FOREGROUND (Resumed)");
        break;
      case AppLifecycleState.inactive:
        debugPrint("⚠️ App is INACTIVE (e.g., call or lock screen)");
        break;
      case AppLifecycleState.paused:
        debugPrint("⏸️ App is in BACKGROUND (Paused)");
        break;
      case AppLifecycleState.detached:
        debugPrint("❌ App is DETACHED (UI gone, process still running)");
        break;
      case AppLifecycleState.hidden:
        debugPrint("🫣 App is HIDDEN (not visible)");
        break;
    }
  }

  Future<void> loadProducts() async {
    try {
      final data = await ApiService.fetchProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
      CartManager.loadCart(products); // Ensure loadCart completes
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching products: $e");
      // Optionally show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load products: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGrid(products: products),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: ["Home", "Profile"][_currentIndex],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}