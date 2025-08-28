import 'package:ecomm_bloc/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:ecomm_bloc/presentation/auth/login/bloc/login_bloc.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_bloc.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_bloc.dart';

import 'package:ecomm_bloc/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await Hive.openBox<String>('images');

  await CartManager.init();

  final authBox = Hive.box('authBox');
  runApp(MyApp(authBox: authBox));
}

class MyApp extends StatelessWidget {
  final Box authBox;

  const MyApp({super.key, required this.authBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(authBox)),
        BlocProvider(create: (_) => HomeScreenBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
