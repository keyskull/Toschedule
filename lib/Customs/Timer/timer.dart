import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    DateTime _time = DateTime.now();
    return "${_time.hour}:${_time.minute}:${_time.second}";
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(days: 1),
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => Container(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) => Text(timerString,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
