import 'package:flutter/material.dart';
import 'api_service.dart';

class FullPageItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Page Items',
      home: Scaffold(
        body: ScrollingPage(),
      ),
    );
  }
}

class ScrollingPage extends StatefulWidget {
  @override
  _ScrollingPageState createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> with SingleTickerProviderStateMixin {
  List<Map<String, String>> quotes = [];
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Начальное положение анимации: снизу
      end: Offset.zero, // Конечное положение анимации: вверху
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));


    _fetchQuotes();
    _pageController.addListener(_loadMoreQuotes);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _fetchQuotes() async {
    final quote = await ApiService.fetchQuote();
    setState(() {
      quotes.add(quote);
    });
  }

  void _loadMoreQuotes() {
    if (_pageController.position.pixels == _pageController.position.maxScrollExtent) {
      _fetchQuotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (_) => _fetchQuotes(), // Изменили обработчик жестов на вертикальный drag
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: _animation.value,
                child: Opacity(
                  opacity: 1 - _animationController.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[800],
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quotes[index]['quote'] ?? '',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          '- ${quotes[index]['author'] ?? ''}',
                          style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
