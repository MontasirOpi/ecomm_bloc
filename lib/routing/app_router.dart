import 'package:ecomm_bloc/presentation/auth/login/ui/login_screen.dart';
import 'package:ecomm_bloc/presentation/cart/ui/cart_screen.dart';
import 'package:ecomm_bloc/presentation/home/ui/home_screen.dart';
import 'package:ecomm_bloc/presentation/profile/ui/profile_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
      GoRoute(path: "/cart", builder: (context, state) => const CartScreen()),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
