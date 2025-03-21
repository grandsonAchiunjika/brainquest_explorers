import 'package:flutter/material.dart';
import 'dart:math';
import '../services/xp_service.dart';

class LanguageLagoon extends StatefulWidget {
  const LanguageLagoon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageLagoonState createState() => _LanguageLagoonState();
}

class _LanguageLagoonState extends State<LanguageLagoon> {
  final XPService xpService = XPService();

  final List<Map<String, dynamic>> vocabList = [
    {
      'word': 'Swift',
      'correct': 'Moving very fast',
      'options': ['Moving very fast', 'Being strong', 'Feeling sad']
    },
    {
      'word': 'Bright',
      'correct': 'Full of light',
      'options': ['Full of light', 'Very big', 'Kind of soft']
    },
    {
      'word': 'Journey',
      'correct': 'A trip from one place to another',
      'options': ['A type of food', 'A trip from one place to another', 'A kind of song']
    },
  ];

  int currentIndex = 0;
  bool showFeedback = false;
  String feedbackMessage = '';

  void checkAnswer(String selected) {
    String correct = vocabList[currentIndex]['correct'];
    if (selected == correct) {
      xpService.addXP(15); // Award 15 XP
      feedbackMessage = '🎉 Correct! +15 XP';
    } else {
      feedbackMessage = '❌ Oops! Try again.';
    }

    setState(() {
      showFeedback = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showFeedback = false;
        currentIndex = (currentIndex + 1) % vocabList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final vocab = vocabList[currentIndex];
    final options = List<String>.from(vocab['options']);
    options.shuffle(Random());

    return Scaffold(
      appBar: AppBar(title: Text('Language Lagoon')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Word: ${vocab['word']}', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 20),
            ...options.map((opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                onPressed: () => checkAnswer(opt),
                child: Text(opt),
              ),
            )),
            SizedBox(height: 20),
            if (showFeedback)
              Text(feedbackMessage, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('XP: ${xpService.currentXP}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
