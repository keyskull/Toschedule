import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_schedule/Utilties/screen_size.dart';

class Weekly extends StatelessWidget {
  final ScrollController controller;
  final _time = DateTime.now();
  final bool startWithSunday;
  static int i = 1;

  Weekly(this.controller, {this.startWithSunday = true});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.isDesktop(context)
        ? ScreenSize.getFlashScreenSize(context).height * 0.3
        : ScreenSize.getFlashScreenSize(context).height * 0.5;
    final _pageController =
        PageController(initialPage: _time.weekday, viewportFraction: 1);

    return Column(children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: ScreenSize.getScreenSize(context).width * 0.95,
              maxHeight: 35),
          child: Stack(children: [
            Row(children: [
              ColoredBox(
                  color: Colors.blue, child: TextButton(child: Text("Tasks"))),
              const SizedBox(width: 20),
              ColoredBox(
                color: Colors.red,
                child: TextButton(child: Text("Reschedule")),
              )
            ]),
            Align(
              alignment: Alignment.topRight,
              child: ColoredBox(
                color: Colors.orange,
                child: TextButton(
                  child: Text("Setting"),
                ),
              ),
            ),
          ])),
      ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: ScreenSize.getScreenSize(context).width * 0.987,
              minWidth: 300,
              minHeight: 300),
          child: Container(
              height: _height,
              width: ScreenSize.getScreenSize(context).width * 0.987,
              child: Card(
                  color: Colors.grey,
                  child: Stack(children: [
                    Positioned.fill(
                        child: ScreenSize.isDesktop(context)
                            ? Scrollbar(
                                controller: controller,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: controller,
                                    children: _weeklyView(
                                        startWithSunday, _height, _time)))
                            : PageView(
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                children: _weeklyView(
                                    startWithSunday, _height, _time))),
                    _timeSerialized(_height),
                  ]))))
    ]);
  }
}

final _weekName = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

final _timeArray = [
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

List<Widget> _weeklyView(startWithSunday, _height, _time) =>
    List<Widget>.generate(7, (index) {
      final _fixIndex = startWithSunday ? index : (index + 1);
      var _color = Colors.white38;
      switch (_fixIndex) {
        case 0:
        case 6:
        case 7:
          _color = Colors.black38;
          break;
      }
      if (_time.weekday == 7 && _fixIndex == 0)
        _color = Colors.blueGrey;
      else if (_time.weekday == _fixIndex) _color = Colors.blueGrey;

      return ConstrainedBox(
          constraints: BoxConstraints(minWidth: 300, minHeight: 300),
          child: Container(
              width: _height,
              height: _height,
              child: Card(
                  color: _color,
                  child: Stack(children: [
                    Column(
                      children: <Widget>[
                            Text(_weekName[_fixIndex]),
                            Divider(thickness: 5),
                          ] +
                          _taskList(_height),
                    ),
                   Align(
                       alignment: Alignment.bottomCenter,
                       child: _timeLine(_height))
                  ]))));
    });

Widget _timeLine(_height) => ListView(
    children: List.generate(
        5,
        (index) => ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: (_height - 51) / 4,
                maxHeight: (_height - 51) / 4,
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
                (index) => ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: (_height - 51) / _timeArray.length,
                        maxHeight: (_height - 51) / _timeArray.length),
                    child: Text(
                      _timeArray[index],
                    )),
              )),
    ));

List<Widget> _taskList(_height) => List.generate(
    5,
    (index) => Opacity(
        opacity: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: _height,
              minHeight: (_height - 51) / 5,
              maxHeight: (_height - 51) / 5,
              maxWidth: _height),
          child: ColoredBox(
              color: Colors.transparent,
              child: Text(
                "",
                style: TextStyle(fontSize: 20),
              )),
        )));
