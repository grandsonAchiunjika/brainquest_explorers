import 'package:flutter/material.dart';
import 'language_lagoon.dart';
import 'math_world.dart';
import 'science_isles.dart';
import '../services/xp_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final XPService xpService = XPService();

  @override
  void initState() {
    super.initState();
    _loadXP();
  }

  Future<void> _loadXP() async {
    await Future.delayed(Duration(milliseconds: 300)); // Wait for XPService to initialize
    setState(() {}); // Trigger rebuild with loaded XP
  }

  @override
  Widget build(BuildContext context) {
    int currentXP = xpService.currentXP;
    int nextMilestone = ((currentXP ~/ 100) + 1) * 100;
    double progress = (currentXP % 100) / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('BrainQuest Explorers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('XP: $currentXP', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text('Next Reward at: $nextMilestone XP'),
            SizedBox(height: 40),
            Text(
              'Choose Your Adventure!',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MathWorld()),
                );
                setState(() {}); // Refresh XP after returning
              },
              child: Text('Enter Numberland (Math)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScienceIsles()),
                );
                setState(() {});
              },
              child: Text('Visit Science Isles'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageLagoon()),
                );
                setState(() {});
              },
              child: Text('Explore Wordtopia'),
            ),
          ],
        ),
      ),
    );
  }
}
