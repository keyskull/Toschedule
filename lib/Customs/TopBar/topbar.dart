import 'package:flutter/material.dart';
import 'package:to_schedule/Customs/Timer/timer.dart';
import 'package:to_schedule/Utilties/screen_size.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.getFlashScreenSize(context).width * 0.97;

    return Container(
        width: _width,
        height: 50,
        color: Colors.black12,
        child: Row(children: [
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            color: Colors.white,
            onPressed: () async => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => SimpleDialog(
                      title: Center(child: Text("To-do")),
                      children: [
                        SimpleDialogOption(
                            child: Row(children: [
                              Checkbox(value: false,),
                              Text("fuck you")]))
                      ],
                    )),
          ),

          // width: 140,
          IconButton(
              icon: Icon(Icons.access_time, semanticLabel: "Reschedule"),
              color: Colors.red,
              iconSize: 30,
              onPressed: () => {}
              // Text(
              //   "Reschedule",
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.red),
              // )
              // style: TextButton.styleFrom(shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: Colors.red),
              ),
          IconButton(
              icon: Icon(Icons.assignment_turned_in, semanticLabel: "Check"),
              color: Colors.white,
              iconSize: 30,
              onPressed: () => {}),
          IconButton(
              icon: Icon(Icons.refresh, semanticLabel: "Refresh"),
              color: Colors.green,
              iconSize: 30,
              onPressed: () => {}),
          Expanded(
            child: Center(child: Timer()),
          ),
          IconButton(
            icon: Icon(Icons.archive_sharp),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => {},
          ),
          const SizedBox(width: 10),
        ]));
  }
}
