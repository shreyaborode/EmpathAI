import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Patient/dailytest.dart';
import 'Patient/memorytiles.dart';
import 'Patient/todolist.dart';
import 'Patient/verbaltest.dart';

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardContent(),
    DailyTestScreen(),
    MemoryTiles(),
    QuizScreen(),
    ToDoListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EmpathAI', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal.shade100
        ,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Daily Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'Memory Games'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'To-Do List'),
        ],
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  int _selectedMood = -1;
  List<String> emojiList = ['😡', '😞', '😐', '😊', '😁'];
  TextEditingController _textController = TextEditingController();

  void _launchYouTubeVideo() async {
    const url = 'https://youtu.be/8BcPHWGQO44?si=BipBgfHJ2TjIlIFg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hey Shreya,\nTime to rewire your brain",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Times New Roman'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageButton('assets/music.png'),
              _buildImageButton('assets/location.png'),
              _buildImageButton('assets/sos.png'),
              _buildImageButton('assets/searchbutton.png'),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/google_memory.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _launchYouTubeVideo,
                  child: _buildImageBox('assets/exercise.png', 'Daily Exercise'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: _buildImageBox('assets/books.png', 'Article to Read')),
            ],
          ),
          SizedBox(height: 20),
          Text("Express Yourself", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _textController,
              maxLines: 6,
              decoration: InputDecoration.collapsed(hintText: "Write anything on your mind..."),
            ),
          ),
          SizedBox(height: 20),
          Text("Mood Tracker", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMood = index;
                });
              },
              child: Text(
                emojiList[index],
                style: TextStyle(
                  fontSize: 32,
                  color: _selectedMood == index ? Colors.redAccent : Colors.black,
                  fontWeight: _selectedMood == index ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            )),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                setState(() {
                  _textController.clear();
                });
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildImageBox(String imagePath, String label) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
