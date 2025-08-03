import 'package:flutter/material.dart';

class addWater1 extends StatelessWidget {

  final int amount;
  IconData ? icon;

  final VoidCallback onClick;

   addWater1({
    super.key, required this.amount, this.icon, required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          onPressed: onClick,
          label: Text(
            "+ ${amount}ml",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          icon: Icon(icon ?? Icons.water_drop, color: Colors.white),
        ),
      ),
    );
  }
}