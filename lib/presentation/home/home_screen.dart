// home_screen.dart
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/card_manager.dart';
import 'package:ecomm_bloc/presentation/home/product_grid.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_app_bar.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_bottom_navBar.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_bloc.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_event.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Placeholder for ProfileScreen
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

class _HomeScreenState extends State<HomeScreen> {
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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: state is HomeScreenLoaded
                ? ["Home", "Profile"][state.currentTab]
                : "Home",
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
