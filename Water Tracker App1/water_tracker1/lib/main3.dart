import 'package:flutter/material.dart';
import 'package:water_tracker1/water_tracker3.dart';

void main() {
  runApp(MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Tracker App',
      home: WaterTracker3(),
    );
  }
}
