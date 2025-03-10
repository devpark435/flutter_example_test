import 'package:flutter/material.dart';
import 'dart:async';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimerExample(),
    );
  }
}

class TimerExample extends StatefulWidget {
  const TimerExample({super.key});

  @override
  TimerExampleState createState() => TimerExampleState();
}

class TimerExampleState extends State<TimerExample> {
  bool isRunning = false;
  int remainingSeconds = 30;
  Timer? timer;

  void startStopTimer() {
    if (isRunning) {
      // 타이머 일시정지
      timer?.cancel();
    } else {
      // 타이머 시작
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            timer.cancel();
            isRunning = false;
          }
        });
      });
    }

    setState(() {
      isRunning = !isRunning;
    });
  }

  void resetTimer() {
    setState(() {
      remainingSeconds = 30;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Example'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            spacing: 18,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Indicator(seconds: remainingSeconds),
              TimerDisplay(seconds: remainingSeconds),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    startStopTimer();
                  });
                },
                child: Text('Start, Stop Timer'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    resetTimer();
                  });
                },
                child: Text('Reset Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  final int seconds;

  const TimerDisplay({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$seconds',
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int seconds;

  const Indicator({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: 1 - seconds / 30,
      strokeWidth: 10.0,
      backgroundColor: Colors.grey,
      color: Colors.blue,
    );
  }
}
