import 'package:bloc_market_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'features/home/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.darkNeon,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
