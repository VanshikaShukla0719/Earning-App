import 'package:app/readnews.dart';
import 'package:app/rewarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        centerTitle: true,
        toolbarHeight: 25.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.workspace_premium, color: Colors.orange),
                        Text(' Level 01',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        Icon(Icons.redeem, color: Colors.green),
                        Text(' \$25.00',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Claim your Daily Reward',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 157, 96, 4),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: buildButtons(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Do Tasks, Earn Reward',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 157, 96, 4),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'You can do these tasks as many times as you want to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(height: 20),
              taskCard('Merge Cooking', 'Play Game', '\$10', 'assets/game.png'),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Readnews()));
                  },
                  child: taskCard(
                      'The News', 'Read News', '\$5', 'assets/news.png')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardingLevels()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buttonWidget(double size, String text, bool isHighlighted) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white : Colors.orange,
        border:
            isHighlighted ? Border.all(color: Colors.orange, width: 2) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isHighlighted ? Colors.orange : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buttonWidget(40, '\$2\nAD', false),
        SizedBox(width: 15),
        buttonWidget(50, '\$2\nAD', false),
        SizedBox(width: 15),
        buttonWidget(60, '\$2\nAD', false),
        SizedBox(width: 15),
        buttonWidget(70, '\$2\nAD', true),
        SizedBox(width: 15),
        buttonWidget(60, '\$2\nAD', false),
        SizedBox(width: 15),
        buttonWidget(50, '\$2\nAD', false),
        SizedBox(width: 15),
        buttonWidget(40, '\$2\nAD', false),
      ],
    );
  }

  Widget taskCard(String title, String action, String reward, String image) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(image,
                fit: BoxFit.cover, height: 150, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(action,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(reward,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks'), backgroundColor: Colors.orange),
      body: Center(
        child: Text('Welcome to Tasks Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
