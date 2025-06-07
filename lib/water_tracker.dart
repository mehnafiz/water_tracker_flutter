import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_water_button.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int currentIntake = 0;
  int maxIntake = 2000;
  final TextEditingController _targetController = TextEditingController();


  void water_add(int amount) {
    setState(() {
      currentIntake = (currentIntake + amount).clamp(0, maxIntake);
    });
  }

  void water_reset() {
    setState(() {
      currentIntake = 0;
    });
  }

  void _showTargetInputDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Today's Water Intake Goal (mL)"),
        content: TextField(
          controller: _targetController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Enter amount in MILI-LITER'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final input = int.tryParse(_targetController.text);
              if (input != null && input > 0) {
                setState(() {
                  maxIntake = input;
                  currentIntake = 0; // optionally reset progress
                });
                _targetController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Set'),
          ),
        ],
      ),
    );
  }

  void goal_reset() {
    setState(() {
      maxIntake = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    double progress = (currentIntake / maxIntake).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        title: const Text(
          'Water Tracker',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.flag, color: Colors.white),
                label: Text(
                  "Today's Goal: ${maxIntake} mL",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 25.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      "Today's InTake",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "$currentIntake mL",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.blueAccent,
                    strokeWidth: 10,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            Wrap(
              spacing: 20,
              children: [
                add_water_button(
                  amount: 100,
                  icon: Icons.local_drink,
                  onClick: () => water_add(100),
                ),
                add_water_button(
                  amount: 500,
                  icon: Icons.local_drink,
                  onClick: () => water_add(500),
                ),
                add_water_button(
                  amount: 1000,
                  icon: Icons.local_drink,
                  onClick: () => water_add(1000),
                ),
              ],
            ),

            SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
              onPressed: water_reset,
              child: Text('Reset', style: TextStyle(fontSize: 25 , color: Colors.white)),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
              onPressed: goal_reset,
              child: Text('Reset Goal', style: TextStyle(fontSize: 25 , color: Colors.white)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: _showTargetInputDialog,
        child: Icon(Icons.flag, color: Colors.white),
      ),

    );
  }
}
