import 'dart:math';
import 'package:flutter/material.dart';
import '../services/xp_service.dart';

class ScienceIsles extends StatefulWidget {
  const ScienceIsles({super.key});

  @override
  // ignore: library_private_types_in_public_api
   createState() => _ScienceIslesState();
}

class _ScienceIslesState extends State<ScienceIsles> {
  final XPService xpService = XPService();
  String experiment = '';
  String fact = '';
  int xpGained = 0;
  bool isErupting = false;
  double eruptionHeight = 0.0;

  @override
  void initState() {
    super.initState();
    getRandomExperiment();
    getRandomFact();
  }

  void getRandomExperiment() {
    final rand = Random();
    List<String> experiments = [
      'Baking Soda Volcano', // For now, just this one
      'Magnetic Attraction',
      'Color Mixing',
    ];
    experiment = experiments[rand.nextInt(experiments.length)];
    setState(() {});
  }

  void getRandomFact() {
    final rand = Random();
    List<String> facts = [
      'Water can exist in three states: solid, liquid, and gas.',
      'The Earth is not a perfect sphere but an oblate spheroid.',
      'The Sun’s energy reaches the Earth in about 8 minutes.',
    ];
    fact = facts[rand.nextInt(facts.length)];
    setState(() {});
  }

  void startVolcanoReaction() {
    setState(() {
      isErupting = true;
      eruptionHeight = 100.0; // Eruption height increases
    });

    // After 2 seconds, stop eruption and give XP
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isErupting = false;
        eruptionHeight = 0.0; // Volcano calms down
      });

      xpGained = 20; // XP gained for completing the experiment
      xpService.addXP(xpGained);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Science Isles')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Science Experiment: $experiment', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 20),
            
            // Volcano Animation (Container height increases when eruption happens)
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: eruptionHeight,
              width: 100,
              color: Colors.red, // Volcano color
              child: Center(child: Text("Volcano", style: TextStyle(color: Colors.white))),
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startVolcanoReaction, // Trigger eruption
              child: Text(isErupting ? 'Erupting!' : 'Complete Experiment'),
            ),
            SizedBox(height: 20),
            Text('Fun Fact: $fact', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('XP: ${xpService.currentXP}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
