import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _numberController = TextEditingController();
  String? _errorMessage;

  void _validateAndNavigate() {
    String number = _numberController.text;

    if (number.isEmpty) {
      setState(() {
        _errorMessage = "Number cannot be empty!";
      });
    } else if (number.length != 10) {
      setState(() {
        _errorMessage = "Number must be 10 digits!";
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 160),
            SizedBox(height: 15),
            // Text(
            //   "COINBOOST",
            //   style: TextStyle(
            //     fontSize: 24,
            //     color: Colors.orange,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 30),
            Image.asset("assets/coinbox.png", height: 200),
            SizedBox(height: 60),
            SizedBox(
              width: 290,
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Enter Your Mobile Number",
                  errorText: _errorMessage,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _validateAndNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 110, vertical: 15),
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
