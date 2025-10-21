// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palace_beautyapp/screens/splash_screen.dart';
import 'package:palace_beautyapp/service/order_service.dart'; // Import OrderService
import 'package:palace_beautyapp/models/order.dart'; // Import Order for Hive adapter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OrderAdapter());
  runApp(const BeautyPalaceApp());
}

class BeautyPalaceApp extends StatelessWidget {
  const BeautyPalaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the app with ChangeNotifierProvider for OrderService
    return ChangeNotifierProvider(
      create: (context) => OrderService(),
      child: MaterialApp(
        title: 'Beauty Palace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
