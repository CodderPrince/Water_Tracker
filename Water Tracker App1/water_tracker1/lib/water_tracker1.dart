import 'package:flutter/material.dart';
import 'package:water_tracker1/appBar.dart';

import 'addWater1.dart';


class WaterTracker1 extends StatefulWidget {
  const WaterTracker1({super.key});

  @override
  State<WaterTracker1> createState() => _WaterTracker1State();
}

class _WaterTracker1State extends State<WaterTracker1> {
  int _currentIntake = 0;
  final int _goal = 2000;
  bool _shownCongrats = false;

  void _waterAdd(int amount) {
    setState(() {
      int previous = _currentIntake;
      if (_currentIntake + amount <= _goal) {
        _currentIntake += amount;
      } else {
        _currentIntake = _goal;
      }

      if (previous < _goal && _currentIntake >= _goal && !_shownCongrats) {
        _shownCongrats = true;
        _showCongratulationsDialog();
      }
    });
  }

  void _resetWater() {
    setState(() {
      _currentIntake = 0;
      _shownCongrats = false;
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[700],
          title: const Text(
            "Congratulations! 🎉",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: const Text(
            "You've reached your daily water goal!",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Nice!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // void showDeleteConfirmation(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.brown,
  //         title: const Text(
  //           "Alert 🚨",
  //           style: TextStyle(color: Colors.white, fontSize: 30),
  //         ),
  //         content: const Text(
  //           "Do you want to delete?",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text(
  //               "No",
  //               style: TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // perform deletion logic here if any
  //             },
  //             child: const Text(
  //               "Yes",
  //               style: TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentIntake / _goal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Today's InTake",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${_currentIntake} ml",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade500,
                      color: Colors.blueAccent,
                      strokeWidth: 10,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()} %',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 15,
                children: [
                  addWater1(
                    amount: 200,
                    icon: Icons.local_drink,
                    onClick: () => _waterAdd(200),
                  ),
                  addWater1(
                    amount: 500,
                    icon: Icons.local_cafe,
                    onClick: () => _waterAdd(500),
                  ),
                  addWater1(
                    amount: 1000,
                    onClick: () => _waterAdd(1000),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _resetWater,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Example trigger for delete confirmation if needed:
              // TextButton(
              //   onPressed: () => showDeleteConfirmation(context),
              //   child: const Text("Show delete confirmation"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
