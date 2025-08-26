import 'package:ecomm_bloc/data/model/product_model.dart';

import 'package:ecomm_bloc/presentation/home/bloc/home_screen_bloc.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_event.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_state.dart';

import 'package:ecomm_bloc/presentation/home/product_grid.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_app_bar.dart';
import 'package:ecomm_bloc/presentation/home/widgets/custom_bottom_navBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ["Home", "Profile"];

    return Scaffold(
      appBar: CustomAppBar(title: titles[_currentIndex]),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Page 1: Products
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              switch (state.status) {
                case HomeStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case HomeStatus.failure:
                  return Center(child: Text("Error: ${state.errorMessage}"));
                case HomeStatus.success:
                  return ProductGrid(products: state.products);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
          // Page 2: Profile
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
