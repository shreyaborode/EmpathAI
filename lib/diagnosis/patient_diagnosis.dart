import 'package:flutter/material.dart';

class PatientDiagnosis extends StatefulWidget {
  @override
  _PatientDiagnosisState createState() => _PatientDiagnosisState();
}

class _PatientDiagnosisState extends State<PatientDiagnosis> {
  List<Map<String, dynamic>> questions = [
    {'question': "What is today’s date?", 'answer': "Date"},
    {'question': "What is the name of the current President/Prime Minister?", 'answer': "Leader"},
    {'question': "Can you recall three words after a few minutes?", 'answer': "Three Words"},
    {'question': "What city are we in right now?", 'answer': "City"},
    {'question': "What is 100 minus 7, and then subtract 7 again (repeat)?", 'answer': "Math"},
    {'question': "Can you name a common object, like a pen or a watch?", 'answer': "Object"},
    {'question': "Repeat the following phrase: 'No ifs, ands, or buts.'", 'answer': "Phrase"},
    {'question': "Can you follow a three-step command?", 'answer': "Three-step"},
    {'question': "Can you draw a clock showing the time as 10:10?", 'answer': "Clock"},
    {'question': "Do you have trouble remembering appointments or recent events?", 'answer': "Memory"},
    {'question': "Do you have difficulty handling finances or making decisions?", 'answer': "Finance"},
    {'question': "Have you noticed changes in mood, behavior, or personality?", 'answer': "Mood"},
  ];

  int questionIndex = 0;
  int score = 0;
  List<Map<String, String>> results = [];
  TextEditingController answerController = TextEditingController();

  void checkAnswer() {
    String userAnswer = answerController.text.trim();
    bool isCorrect = userAnswer.isNotEmpty;

    if (isCorrect) {
      score++;
    }

    results.add({
      'question': questions[questionIndex]['question'],
      'userAnswer': userAnswer,
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
        title: Text('Patient Diagnosis', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              onPressed: checkAnswer,
              child: Text(
                questionIndex < questions.length - 1 ? 'Next' : 'Finish',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
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

  String getDiagnosis() {
    if (score < 5) {
      return "You might have Alzheimer’s. Please consult a specialist.";
    } else if (score >= 5 && score <= 7) {
      return "Check with our doctors personally.";
    } else {
      return "You are normal.";
    }
  }

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
              'Final Score: $score / $total',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 15),
            Text(
              getDiagnosis(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(results[index]['question']!,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Your Answer: ${results[index]['userAnswer']}',
                        style: TextStyle(
                          color: results[index]['status'] == 'Correct' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
