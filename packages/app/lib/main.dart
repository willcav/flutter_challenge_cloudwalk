import 'package:app/resources_initialization.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';

Future<void> main() async {
  await ResourcesInitialization.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge Cloudwalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: MapPage(),
      ),
    );
  }
}
