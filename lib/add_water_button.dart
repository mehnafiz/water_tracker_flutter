import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class add_water_button extends StatelessWidget {
  final int amount;
  IconData ? icon;
  final VoidCallback onClick;
  add_water_button({
    super.key, required this.amount, required this.onClick,this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed:onClick,
          label: Text(
            '+${amount} mL',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          icon: Icon(Icons.local_drink),
        ),
      ),
    );
  }
}