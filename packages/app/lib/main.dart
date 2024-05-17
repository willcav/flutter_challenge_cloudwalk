import 'package:flutter/material.dart';
import 'package:map/map.dart';

import 'resources_initialization.dart';

Future<void> main() async {
  await ResourcesInitialization.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
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
