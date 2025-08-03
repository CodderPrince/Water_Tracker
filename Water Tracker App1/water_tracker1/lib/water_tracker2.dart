import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_tracker1/appBar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';

import 'addWater.dart';


class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int _currentIntake = 0;
  static const int _goal = 2000;
  bool _shownCongrats = false;
  bool _isDialogShowing = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _tips = [
    "Try drinking a glass every hour.",
    "Carry a reusable bottle with you.",
    "Set a reminder on your phone.",
    "Flavor water with lemon or mint.",
    "Drink before each meal to build habit.",
  ];

  void _waterAdd(int amount) {
    setState(() {
      final previous = _currentIntake;
      _currentIntake += amount;
      if (_currentIntake > _goal) _currentIntake = _goal;

      if (previous < _goal && _currentIntake >= _goal && !_shownCongrats) {
        _shownCongrats = true;
        _playGoalSound();
        HapticFeedback.mediumImpact();
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

  Future<void> _playGoalSound() async {
    try {
      await _audioPlayer.play(AssetSource('assets/sounds/win.mp3'));
    } catch (e) {
      debugPrint('Audio play error: $e');
    }
  }

  void _showCongratulationsDialog() {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Congratulations! 🎉',
                        speed: const Duration(milliseconds: 80),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "You've reached your daily water goal!",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.yellowAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(seconds: 1),
                          animatedTexts: _tips
                              .map(
                                (tip) => FadeAnimatedText(
                              tip,
                              duration: const Duration(milliseconds: 2500),
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShowing = false;
              },
              child: const Text(
                'Got it!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      _isDialogShowing = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentIntake / _goal).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar:  MyAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      "Today's Intake",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_currentIntake ml',
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
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 8,
                  children: [
                    AddWater(
                      amount: 200,
                      icon: Icons.local_drink,
                      onClick: () => _waterAdd(200),
                    ),
                    AddWater(
                      amount: 500,
                      icon: Icons.local_cafe,
                      onClick: () => _waterAdd(500),
                    ),
                    AddWater(amount: 1000, onClick: () => _waterAdd(1000)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _resetWater,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
