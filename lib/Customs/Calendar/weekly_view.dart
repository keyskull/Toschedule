import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_schedule/Utilties/screen_size.dart';
import 'dart:math';

class Weekly extends StatelessWidget {
  final _time = DateTime.now();
  final ScrollController controller;
  final bool startWithSunday;

  Weekly(this.controller, {this.startWithSunday = true});

  @override
  Widget build(BuildContext context) {
    final double _height = ScreenSize.isDesktop(context) ? 500 : 300;
    final _width = ScreenSize.getFlashScreenSize(context).width * 0.97;

    return Container(
        width: _width,
        height: _height,
        child: Card(
            color: Colors.grey,
            child: Stack(children: [
              Scrollbar(
                  controller: controller,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: [
                        _weeklyView(startWithSunday, _height, _time)
                      ])),
              _timeSerialized(_height),
            ])));
  }
}

const _weekName = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

const _timeArray = [
  "4:00",
  "6:00",
  "8:00",
  "10:00",
  "12:00",
  "14:00",
  "16:00",
  "18:00",
  "20:00",
  "22:00"
];

Widget _weeklyView(startWithSunday, _height, _time) {
  return Row(
      children: List<Widget>.generate(7, (index) {
    final _fixIndex = startWithSunday ? index : index + 1;
    var _color = Colors.white38;
    switch (_fixIndex) {
      case 0:
      case 6:
      case 7:
        _color = Colors.lightGreen;
        break;
    }

    if ((_time.weekday == 7 && _fixIndex == 0) || _time.weekday == _fixIndex)
      _color = Colors.blueGrey;

    return Container(
        width: _height,
        height: _height,
        constraints: BoxConstraints(minWidth: 300, minHeight: 300),
        child: Card(
            color: _color,
            child: Stack(children: [
              _numberOfDate(_fixIndex, _time,_height),
              _taskList(_height, _fixIndex),
              _timeLine(_height)
            ])));
  }));
}

Widget _numberOfDate(_index, DateTime _time,_hieght) => Opacity(
    opacity: 0.6,
    child: Align(
        alignment: Alignment.center,
        child: Text("${(_time.day + (_index - _time.weekday))}",
            style: TextStyle(height: 1, fontSize: _hieght > 300 ? 300: 250))));

Widget _timeLine(_height) => Column(
    children: List.generate(
        5,
        (index) => Container(
            constraints: BoxConstraints(
              minHeight: (_height - 51) / 5,
              maxHeight: (_height - 51) / 5,
            ),
            child: Divider(thickness: 0.3, color: Colors.black54))));

Widget _timeSerialized(_height) => Container(
    width: 45,
    child: Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Column(
          children: <Widget>[Text("Time"), Divider(thickness: 5)] +
              List<Widget>.generate(
                _timeArray.length,
                (index) => Container(
                    constraints: BoxConstraints(
                        minHeight: (_height - 51) / _timeArray.length,
                        maxHeight: (_height - 51) / _timeArray.length),
                    child: Text(
                      _timeArray[index],
                    )),
              )),
    ));

Widget _taskList(_height, _fixIndex) {
  List colors = [Colors.blueGrey, Colors.teal, Colors.deepPurple];
  Random random = new Random();
  return Column(
    children: <Widget>[
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(_weekName[_fixIndex])),
          Divider(thickness: 5),
        ] +
        List.generate(
            5,
            (index) => Opacity(
                  opacity: 0.8,
                  child: Container(
                      height: (_height - 51) / 5,
                      width: _height,
                      color: Colors.transparent,
                      // color: colors[random.nextInt(3)],
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 20, decorationColor: Colors.green),
                      )),
                )),
  );
}
