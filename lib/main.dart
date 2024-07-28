import 'package:flutter/material.dart';
import 'package:pixel_6/HomePage.dart';
import 'package:pixel_6/Provider/UserProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>UserProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Homepage()
      ),
    );
  }
}

