import 'dart:math';
import 'package:flutter/material.dart';

class DailyTestScreen extends StatefulWidget {
  @override
  _DailyTestScreenState createState() => _DailyTestScreenState();
}

class _DailyTestScreenState extends State<DailyTestScreen> {
  final List<Map<String, String>> family = [
    {'name': 'Jinisha', 'image': 'assets/jinisha.jpg'},
    {'name': 'Shreya', 'image': 'assets/shreya.jpg'},
    {'name': 'Ruchi', 'image': 'assets/ruchi.png'},
    {'name': 'Papa', 'image': 'assets/papa.jpg'},
    {'name': 'Devyani', 'image': 'assets/devyani.jpg'},
    {'name': 'Mummy', 'image': 'assets/mummy.jpeg'},
    {'name': 'Wife', 'image': 'assets/wife.png'},
    {'name': 'Son', 'image': 'assets/child.jpg'},
  ];

  final List<Map<String, String>> animals = [
    {'name': 'Lion', 'image': 'assets/lion.jpeg'},
    {'name': 'Elephant', 'image': 'assets/elephant.jpg'},
    {'name': 'Zebra', 'image': 'assets/zebra.jpeg'},
    {'name': 'Giraffe', 'image': 'assets/giraffe.jpg'},
  ];

  final List<Map<String, String>> birds = [
    {'name': 'Parrot', 'image': 'assets/parrot.jpg'},
    {'name': 'Eagle', 'image': 'assets/eagle.jpeg'},
    {'name': 'Peacock', 'image': 'assets/peacock.jpg'},
    {'name': 'Sparrow', 'image': 'assets/sparrow.jpg'},
  ];

  final List<Map<String, String>> places = [
    {'name': 'Home', 'image': 'assets/home.jpg'},
    {'name': 'Office', 'image': 'assets/office.jpg'},
    {'name': 'Farmhouse', 'image': 'assets/farmhouse.jpeg'},
    {'name': "Devyani's House", 'image': 'assets/devyanis_house.jpg'},
  ];

  final List<Map<String, String>> foodDishes = [
    {'name': 'Biryani', 'image': 'assets/biryani.jpg'},
    {'name': 'Paneer Tikka', 'image': 'assets/paneer_tikka.jpg'},
    {'name': 'Dosa', 'image': 'assets/dosa.jpg'},
    {'name': 'Chole Bhature', 'image': 'assets/chole_bhature.jpg'},
    {'name': 'Pani Puri', 'image': 'assets/pani_puri.jpg'},
  ];

  final List<Map<String, String>> fruits = [
    {'name': 'Apple', 'image': 'assets/apple.jpg'},
    {'name': 'Banana', 'image': 'assets/banana.jpg'},
    {'name': 'Mango', 'image': 'assets/mango.jpg'},
    {'name': 'Grapes', 'image': 'assets/grapes.jpg'},
  ];

  late String questionText;
  late Map<String, String> correctAnswer;
  late List<Map<String, String>> options;
  late List<Map<String, String>> selectedCategory;

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    final random = Random();
    final category = random.nextInt(6); // Randomly select a category

    switch (category) {
      case 0:
        selectedCategory = family;
        questionText = 'Who among them is';
        break;
      case 1:
        selectedCategory = animals;
        questionText = 'What image is a';
        break;
      case 2:
        selectedCategory = birds;
        questionText = 'What bird is this?';
        break;
      case 3:
        selectedCategory = places;
        questionText = 'Which place is this?';
        break;
      case 4:
        selectedCategory = foodDishes;
        questionText = 'What dish is this?';
        break;
      case 5:
        selectedCategory = fruits;
        questionText = 'What fruit is this?';
        break;
    }

    correctAnswer = selectedCategory[random.nextInt(selectedCategory.length)];
    options = List.from(selectedCategory)..shuffle();
    options = options.take(4).toList();
    if (!options.contains(correctAnswer)) {
      options[random.nextInt(4)] = correctAnswer;
    }
    setState(() {});
  }

  void checkAnswer(Map<String, String> selectedOption) {
    bool isCorrect = selectedOption['name'] == correctAnswer['name'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isCorrect ? 'Correct! 🎉' : 'Try Again 😔',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(correctAnswer['image']!, height: 120),
            SizedBox(height: 10),
            Text(
              isCorrect
                  ? 'Well done! This is indeed ${correctAnswer['name']}.'
                  : 'Oops! This is ${correctAnswer['name']}. Remember next time! 😊',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              generateNewQuestion();
            },
            child: Text('Next Question', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Memory Test', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$questionText ${correctAnswer['name']}?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => checkAnswer(options[index]),
                  child: Image.asset(options[index]['image']!, fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
