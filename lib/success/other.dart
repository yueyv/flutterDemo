import 'package:flutter/material.dart';
import 'dart:math';

class MathTest extends StatefulWidget {
  final String username;
  const MathTest({required this.username, Key? key}) : super(key: key);

  @override
  MathTestState createState() => MathTestState();
}

class MathTestState extends State<MathTest> {
  final Random _random = Random();
  int firstNumber = 0;
  int secondNumber = 0;
  int? expectedAnswer;
  int? userAnswer;
  String result = "结果";
  bool opt = true;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    firstNumber = _random.nextInt(10);
    secondNumber = _random.nextInt(10);
    opt = _random.nextBool();
    if (opt) {
      expectedAnswer = firstNumber + secondNumber;
    } else {
      if (firstNumber < secondNumber) {
        int number = secondNumber;
        secondNumber = firstNumber;
        firstNumber = number;
      }
      expectedAnswer = firstNumber - secondNumber;
    }
    userAnswer = 0;
    result = '结果';
  }

  void checkAnswer() {
    if (userAnswer == expectedAnswer) {
      result = "正确";
    } else {
      result = '错误，答案为 $expectedAnswer';
    }
    setState(() {});
  }

  void reset() {
    setState(() {});
    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '移动平台开发技术与应用期中作业',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
            displayLarge:
                TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 30.0),
            bodyMedium: TextStyle(fontSize: 30.0, fontFamily: 'Hind')),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录成功你的用户名:${widget.username}'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 180, 20, 20),
                child: Text(
                  '$firstNumber ${opt ? "+" : "-"} $secondNumber = ',
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 200, 20, 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  onChanged: (newValue) => userAnswer = int.parse(newValue),
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: ElevatedButton(
                  onPressed: checkAnswer,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFFD90B3)),
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xff31C27C)),
                    shadowColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(8))), //圆角弧度
                  ),
                  child: const Text(
                    '计算',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Text(result),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: reset,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFFD90B3)),
                        overlayColor:
                            MaterialStateProperty.all(const Color(0xff31C27C)),
                        shadowColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(8))), //圆角弧度
                      ),
                      child:
                          const Text('下一题', style: TextStyle(fontSize: 40.0)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
