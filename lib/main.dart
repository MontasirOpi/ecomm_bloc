import 'package:ecomm_bloc/presentation/auth/login/ui/login_screen.dart';
import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:ecomm_bloc/presentation/auth/login/bloc/login_bloc.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_bloc.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox'); // box for storing login info
  await Hive.openBox<String>('images');

  await CartManager.init();

  final authBox = Hive.box('authBox');
  final bool isLoggedIn = authBox.get("isLoggedIn", defaultValue: false);

  runApp(MyApp(authBox: authBox, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final Box authBox;
  final bool isLoggedIn;

  const MyApp({super.key, required this.authBox, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(authBox)),
        BlocProvider(create: (_) => HomeScreenBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        //BlocProvider(create: (_) => CartBloc()..add(LoadCart([]))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
