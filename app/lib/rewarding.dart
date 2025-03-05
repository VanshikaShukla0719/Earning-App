import 'package:app/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RewardingLevels(),
    );
  }
}

class RewardingLevels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 30,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Rewarding Levels',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RewardCard(
                  level: '01', minWithdrawal: 50, earnings: 25, progress: 0.5),
              RewardCard(
                  level: '02', minWithdrawal: 100, earnings: 0, progress: 0.0),
              RewardCard(
                  level: '03', minWithdrawal: 150, earnings: 0, progress: 0.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            // 0 is the index of the Home Icon
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()), // Replace with your Home Screen Widget
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30, color: Colors.white), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.layers, size: 30, color: Colors.white),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30, color: Colors.white),
              label: ''),
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String level;
  final int minWithdrawal;
  final int earnings;
  final double progress;

  RewardCard({
    required this.level,
    required this.minWithdrawal,
    required this.earnings,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Level $level',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minimum Withdrawal = \$${minWithdrawal}',
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                  SizedBox(height: 10),
                  Text('Your earnings = \$${earnings}'),
                  SizedBox(height: 30),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        // borderRadius: BorderRadius.vertical(
                        //     top: Radius.circular(10),
                        //     bottom: Radius.circular(10)),
                        borderRadius: BorderRadius.circular(20)),
                    child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
