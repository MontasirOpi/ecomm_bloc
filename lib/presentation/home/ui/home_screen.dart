import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_event.dart';
import 'package:ecomm_bloc/presentation/home/ui/product_grid.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_app_bar.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_bottom_navBar.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_bloc.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_event.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_state.dart';
import 'package:ecomm_bloc/presentation/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _cartLoaded = false; // Track if cart has been loaded

  @override
  void initState() {
    super.initState();
    // Trigger initial product loading
    context.read<HomeScreenBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        // Handle errors by showing snackbars
        if (state is HomeScreenError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        // Load cart only once when products are successfully loaded
        if (state is HomeScreenLoaded && !_cartLoaded) {
          context.read<CartBloc>().add(CartLoadEvent(state.products));
          _cartLoaded = true;
        }

        // Reset cart loaded flag if we get back to loading state
        if (state is HomeScreenLoading) {
          _cartLoaded = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: state is HomeScreenLoaded
                ? ["Home", "Profile"][state.currentTab]
                : "Home",
            products: state is HomeScreenLoaded ? state.products : [],
          ),
          body: _buildBody(state),
          bottomNavigationBar: state is HomeScreenLoaded
              ? CustomBottomNavBar(
                  currentIndex: state.currentTab,
                  onTap: (index) {
                    context.read<HomeScreenBloc>().add(ChangeTab(index));
                  },
                )
              : null,
        );
      },
    );
  }

  Widget _buildBody(HomeScreenState state) {
    if (state is HomeScreenInitial || state is HomeScreenLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomeScreenError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.message}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<HomeScreenBloc>().add(LoadProducts());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is HomeScreenLoaded) {
      final List<Widget> pages = [
        // Home Tab
        RefreshIndicator(
          onRefresh: () async {
            context.read<HomeScreenBloc>().add(RefreshProducts());
            // Reset cart loaded flag when refreshing
            _cartLoaded = false;
          },
          child: ProductGrid(products: state.products),
        ),
        // Profile Tab
        const ProfileScreen(),
      ];

      return IndexedStack(index: state.currentTab, children: pages);
    }

    return const Center(child: Text('Unknown state'));
  }
}
