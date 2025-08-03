import 'package:flutter/material.dart';

import 'water_tracker.dart';

void main() {
  runApp(MyApp19());
}

class MyApp19 extends StatelessWidget {
  const MyApp19({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watar Tracker App',
      home: WaterTracker(),
    );
  }
}
