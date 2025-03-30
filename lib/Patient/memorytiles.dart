import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class MemoryTiles extends StatefulWidget {
  @override
  _MemoryTilesState createState() => _MemoryTilesState();
}

class _MemoryTilesState extends State<MemoryTiles> {
  List<Color> colors = [
    Colors.red, Colors.red,
    Colors.blue, Colors.blue,
    Colors.green, Colors.green,
    Colors.yellow, Colors.yellow,
    Colors.orange, Colors.orange,
    Colors.purple, Colors.purple,
    Colors.cyan, Colors.cyan,
    Colors.brown, Colors.brown,
  ];

  List<bool> flipped = List.generate(16, (_) => false);
  List<int> selectedIndexes = [];
  int score = 0;
  int fastestTime = 999;
  int secondsElapsed = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    colors.shuffle(Random());
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    if (secondsElapsed < fastestTime) {
      fastestTime = secondsElapsed;
    }
  }

  void _flipTile(int index) {
    if (flipped[index] || selectedIndexes.length == 2) return;

    setState(() {
      flipped[index] = true;
      selectedIndexes.add(index);
    });

    if (selectedIndexes.length == 2) {
      _checkMatch();
    }
  }

  void _checkMatch() {
    if (colors[selectedIndexes[0]] == colors[selectedIndexes[1]]) {
      setState(() {
        score++;
        selectedIndexes.clear();
      });

      if (score == 8) {
        stopTimer();
        Future.delayed(Duration(milliseconds: 500), () {
          _showGameCompletionDialog();
        });
      }
    } else {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          flipped[selectedIndexes[0]] = false;
          flipped[selectedIndexes[1]] = false;
          selectedIndexes.clear();
        });
      });
    }
  }

  void _showGameCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("🎉 Congratulations!"),
        content: Text("You completed the game in $secondsElapsed seconds."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text("Play Again"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text("Back to Home"),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      colors.shuffle(Random());
      flipped = List.generate(16, (_) => false);
      selectedIndexes.clear();
      score = 0;
      secondsElapsed = 0;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Memory Tiles",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          SizedBox(height: 5),
          Text(
            "Score: $score | Fastest Time: ${fastestTime == 999 ? 'N/A' : '$fastestTime sec'}",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(height: 5),
          Text(
            "Time: $secondsElapsed sec",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.redAccent),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
              ),
              padding: EdgeInsets.all(20),
              itemCount: 16,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _flipTile(index),
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: flipped[index] ? colors[index] : Colors.grey[800],
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
