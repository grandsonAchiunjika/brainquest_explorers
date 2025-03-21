import 'package:flutter/material.dart';
import 'math_world.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BrainQuest Explorers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Your Adventure!', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) => MathWorld()),
               );
                // Navigate to Math World
              },
              child: Text('Enter Numberland (Math)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Science Isles
              },
              child: Text('Visit Science Isles'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Wordtopia
              },
              child: Text('Explore Wordtopia'),
            ),
          ],
        ),
      ),
    );
  }
}
