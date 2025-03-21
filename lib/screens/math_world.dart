import 'dart:math';
import 'package:flutter/material.dart';
import '../services/xp_service.dart';

class MathWorld extends StatefulWidget {
  const MathWorld({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MathWorldState createState() => _MathWorldState();
}

class _MathWorldState extends State<MathWorld> {
  int num1 = 0;
  int num2 = 0;
  int answer = 0;
  int userAnswer = 0;
  String feedback = '';
  final XPService xpService = XPService();

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final rand = Random();
    num1 = rand.nextInt(10) + 1;
    num2 = rand.nextInt(10) + 1;
    answer = num1 + num2;
    feedback = '';
    userAnswer = 0;
    setState(() {});
  }

  void checkAnswer() {
    if (userAnswer == answer) {
      feedback = 'Correct! 🎉 +10 XP';
      xpService.addXP(10);
    } else {
      feedback = 'Oops! Try again.';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Numberland - Math World')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Solve: $num1 + $num2 = ?', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                userAnswer = int.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your answer',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: checkAnswer, child: Text('Submit')),
            SizedBox(height: 20),
            Text(feedback, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: generateQuestion, child: Text('Next Question')),
            SizedBox(height: 30),
            Text('XP: ${xpService.currentXP}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
