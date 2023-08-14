import 'package:flutter/material.dart';
import 'dart:math';

class ButtonInfo {
  final int index;
  MaterialColor color;

  ButtonInfo(this.index, this.color);
}

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
  //List<int> numbers = [];
  List<ButtonInfo> btnInfo = [];
  int currentNumber = 1;
  MaterialColor primaryColor = Colors.orange;
  @override
  void initState() {
    super.initState();
    _initializeNumbers();
  }

  void _initializeNumbers() {

    final random = Random();
    btnInfo.clear();
    for (int i = 1; i <= 9; i++) {
      btnInfo.add(ButtonInfo(i, Colors.orange));
    }
    setState(() {
      btnInfo.shuffle(random);
    });
  }

  void _handleNumberTap(int number) {
    if (number == currentNumber) {
      ButtonInfo targetButtonInfo = btnInfo.firstWhere((buttonInfo) => buttonInfo.index == number);
      setState(() {
        targetButtonInfo.color = Colors.grey;
        if (currentNumber >= 9) {
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
      body:
     Container(
       padding: EdgeInsets.all(10), // ボタンの内部余白を調整
    child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0, // アイテムのサイズを制御

          ),
          itemCount: btnInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(

                child: SizedBox(
                  width: 5, height: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: btnInfo[index].color, elevation: 16,),
                    onPressed: () => _handleNumberTap(btnInfo[index].index),
                    child: Text( btnInfo[index].index.toString(), style:  TextStyle(fontSize: 15.0, color:Colors.black,),),
                  ),

                )

                );
          },
        ),
      ),
    ),
    );
  }
}
