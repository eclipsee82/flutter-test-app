import 'package:flutter/material.dart';
import 'other.dart'; // Импорт файла с другой страницей
import 'scrolling_page.dart'; // Импорт файла с бесконечным скроллом

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Page Items',
      home: FullPageItems(),
    );
  }
}

class FullPageItems extends StatefulWidget {
  @override
  _FullPageItemsState createState() => _FullPageItemsState();
}

class _FullPageItemsState extends State<FullPageItems> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ScrollingPage(), // Удалите передачу параметра items
          OtherPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[900], // Задайте цвет панели навигации здесь
        selectedItemColor: Colors.white, // Цвет выбранного элемента
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote_rounded),
            label: 'Мотивация',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Что-то еще...',
          )
        ],
      ),
    );
  }
}
