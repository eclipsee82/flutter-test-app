import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // Set background color here
      body: Center(
        child: Text(
          'Это пустая страница',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }
}
