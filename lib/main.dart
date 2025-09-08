import 'package:ecomm_bloc/app/app.dart';
import 'package:ecomm_bloc/app/app_them.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized

  try {
    // Initialize Hive and open required boxes
    await Hive.initFlutter();
    await Hive.openBox('authBox');
    await Hive.openBox<String>('images');
    await CartManager.init();

    final Box<dynamic> authBox = Hive.box('authBox');
    runApp(MyApp(authBox: authBox));
  } catch (e) {
    // If initialization fails, show a simple error UI
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Initialization error:\n$e',
              style: TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
