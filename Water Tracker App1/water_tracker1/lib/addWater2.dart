import 'package:flutter/material.dart';

class AddWater extends StatelessWidget {
  final int amount;
  final IconData? icon;
  final VoidCallback onClick;

  const AddWater({
    super.key,
    required this.amount,
    this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onClick,
          icon: Icon(icon ?? Icons.water_drop, color: Colors.white),
          label: Text(
            '+ ${amount}ml',
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
