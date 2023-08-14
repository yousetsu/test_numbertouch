import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumberTouchGame(),
    );
  }
}

class NumberTouchGame extends StatefulWidget {
  @override
  _NumberTouchGameState createState() => _NumberTouchGameState();
}

class _NumberTouchGameState extends State<NumberTouchGame> {
  List<int> numbers = [];
  int currentNumber = 1;

  @override
  void initState() {
    super.initState();
    _initializeNumbers();
  }

  void _initializeNumbers() {
    final random = Random();
    numbers.clear();
    for (int i = 1; i <= 16; i++) {
      numbers.add(i);
    }
    numbers.shuffle(random);
  }

  void _handleNumberTap(int number) {
    if (number == currentNumber) {
      setState(() {
        numbers.remove(number);
        if (numbers.isEmpty) {
          _showGameClearDialog();
        } else {
          currentNumber++;
        }
      });
    }
  }

  void _showGameClearDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You cleared the game.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeNumbers();
                currentNumber = 1;
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Touch Game')),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: numbers.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _handleNumberTap(numbers[index]),
              child: Container(
                margin: EdgeInsets.all(8),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    numbers[index].toString(),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
