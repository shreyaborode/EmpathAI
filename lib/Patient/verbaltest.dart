import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> questions = [
    {'question': 'What season is it right now?', 'answer': 'Summer'},
    {'question': 'What do you usually eat for breakfast?', 'answer': 'Poha'},
    {'question': 'Who is the current Prime Minister?', 'answer': 'Narendra Modi'},
    {'question': 'What year is it?', 'answer': '2025'},
    {'question': 'Can you name five animals?', 'answer': 'Dog, cat, elephant, tiger, cow'},
    {'question': 'What rhymes with "bat"?', 'answer': 'Hat, cat, mat'},
    {'question': 'Spell "WORLD" backwards.', 'answer': 'DLROW'},
    {'question': 'What is 10 minus 3?', 'answer': '7'},
    {'question': 'Name the colors in the rainbow.', 'answer': 'Red, orange, yellow, green, blue, indigo, violet'},
    {'question': 'What do you do if you see smoke in the house?', 'answer': 'Find the source and call for help'}
  ];

  int questionIndex = 0;
  int score = 0;
  List<Map<String, String>> results = [];
  TextEditingController answerController = TextEditingController();

  void checkAnswer() {
    String userAnswer = answerController.text.trim();
    String correctAnswer = questions[questionIndex]['answer'];
    bool isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();

    if (isCorrect) {
      score++;
    }

    results.add({
      'question': questions[questionIndex]['question'],
      'userAnswer': userAnswer,
      'correctAnswer': correctAnswer,
      'status': isCorrect ? 'Correct' : 'Incorrect'
    });

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        answerController.clear();
      });
    } else {
      viewScore();
    }
  }

  void skipQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        answerController.clear();
      });
    } else {
      viewScore();
    }
  }

  void viewScore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(results: results, score: score, total: questions.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quiz'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.score),
            onPressed: viewScore,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $score/${questions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Text(
              questions[questionIndex]['question'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: skipQuestion,
                  child: Text('Skip'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final List<Map<String, String>> results;
  final int score;
  final int total;

  ScoreScreen({required this.results, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Report'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Final Score: $score/$total',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(results[index]['question']!),
                      subtitle: Text(
                        'Your Answer: ${results[index]['userAnswer']}\nCorrect Answer: ${results[index]['correctAnswer']}',
                        style: TextStyle(
                          color: results[index]['status'] == 'Correct' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
