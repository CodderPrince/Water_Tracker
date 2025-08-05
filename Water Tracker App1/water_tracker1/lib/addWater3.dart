import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AddWater3 extends StatefulWidget {
  final int amount;
  final IconData? icon;
  final VoidCallback onClick;

  const AddWater3({
    super.key,
    required this.amount,
    this.icon,
    required this.onClick,
  });

  @override
  State<AddWater3> createState() => _AddWater3State();
}

class _AddWater3State extends State<AddWater3> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  Future<void> _playSoundForAmount(int amt) async {
    String assetPath;

    switch (amt) {
      case 200:
        assetPath = 'sounds/200ml_goal.mp3';
        break;
      case 500:
        assetPath = 'sounds/500ml_special.mp3';
        break;
      case 1000:
        assetPath = 'sounds/1000ml_sound.mp3';
        break;
      default:
        assetPath = 'assets/sounds/win.mp3';
    }

    try {
      await _player.stop();
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      // Optional debug print
      // debugPrint('Error playing sound for $amt ml: $e');
    }
  }


  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _handlePressed() async {
    await _playSoundForAmount(widget.amount);
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _handlePressed,
          icon: Icon(widget.icon ?? Icons.water_drop, color: Colors.white),
          label: Text(
            '+ ${widget.amount}ml',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
