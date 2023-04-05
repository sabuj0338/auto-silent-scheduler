import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/schedule/CreateDateScheduleScreen.dart';
import 'package:peace_time/screen/schedule/CreateScreen.dart';
import 'package:provider/provider.dart';

class FloatingActionBottomSheet extends StatefulWidget {
  @override
  _FloatingActionBottomSheetState createState() =>
      _FloatingActionBottomSheetState();
}

class _FloatingActionBottomSheetState extends State<FloatingActionBottomSheet> {
  int _minute = 30;

  void increment({int value = 5}) {
    setState(() {
      _minute += value;
    });
  }

  void decrement({int value = 5}) {
    if (_minute - value >= 0) {
      setState(() {
        _minute -= value;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 0), () async {
      _minute = await DBController.getDefaultSilentMinute();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(4.0),
                    // width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // padding: const EdgeInsets.all(8),
                      // color: Colors.teal[200],
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CreateDateScheduleScreen()),
                        ).then((response) =>
                            response ? Navigator.of(context).pop() : null),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_sharp,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text("Calender")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(4.0),
                    // width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // padding: const EdgeInsets.all(8),
                      // color: Colors.teal[100],
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CreateScreen()),
                        ).then((response) =>
                            response ? Navigator.of(context).pop() : null),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text("Daily")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(8.0),
                    // width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () => decrement(value: 5),
                              customBorder: CircleBorder(),
                              child: Card(
                                  color: Theme.of(context).focusColor,
                                  shape: StadiumBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.remove),
                                  ))),
                          Card(
                            // color: Colors.blue,
                            shape: StadiumBorder(),
                            child: Text(
                              _minute.toString(),
                              style: TextStyle(fontSize: 48),
                            ),
                          ),
                          InkWell(
                              onTap: () => increment(value: 5),
                              customBorder: CircleBorder(),
                              child: Card(
                                  color: Theme.of(context).focusColor,
                                  shape: StadiumBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.add),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(8.0),
                    // width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // padding: const EdgeInsets.all(8),
                      // color: Colors.teal[100],
                      child: InkWell(
                        onTap: () {
                          Provider.of<ScheduleProvider>(context, listen: false)
                              .quick(_minute);
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.volume_off,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text("Quick [${_minute}m]")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.schedule),
              SizedBox(height: 5),
              Text("Daily")
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_sharp),
              SizedBox(height: 5),
              Text("Calender")
            ],
          ),
        )
        // ListTile(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(0),
        //   ),
        //   leading: const Icon(Icons.schedule),
        //   title: const Text('Daily Schedule'),
        //   onTap: () => Navigator.push(
        //     context,
        //     CupertinoPageRoute(builder: (context) => CreateScreen()),
        //   ).then((response) => response ? Navigator.of(context).pop() : null),
        // ),
        // ListTile(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(0),
        //   ),
        //   leading: const Icon(Icons.calendar_today_sharp),
        //   title: const Text('Calender Schedule'),
        //   onTap: () => Navigator.push(
        //     context,
        //     CupertinoPageRoute(
        //         builder: (context) => CreateDateScheduleScreen()),
        //   ).then((response) => response ? Navigator.of(context).pop() : null),
        // ),
        // ListTile(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(0),
        //   ),
        //   leading: const Icon(Icons.volume_off_sharp),
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Text('Quick Silent'),
        //       Container(
        //         padding: EdgeInsets.all(3),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             color: Theme.of(context).primaryColor),
        //         child: Row(
        //           children: [
        //             InkWell(
        //                 onTap: () => decrement(value: 5),
        //                 child: Icon(Icons.remove, color: Colors.white)),
        //             Container(
        //               margin: EdgeInsets.symmetric(horizontal: 3),
        //               padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(3),
        //                   color: Colors.white),
        //               child: Text(
        //                 _minute.toString(),
        //                 style: TextStyle(color: Colors.black, fontSize: 16),
        //               ),
        //             ),
        //             InkWell(
        //                 onTap: () => increment(value: 5),
        //                 child: Icon(Icons.add, color: Colors.white)),
        //           ],
        //         ),
        //       ),
        //       // IconButton(onPressed: () {}, icon: Icon(Icons.done))
        //     ],
        //   ),
        //   onTap: () {
        //     Provider.of<ScheduleProvider>(context, listen: false)
        //         .quick(_minute);
        //     Navigator.of(context).pop();
        //   },
        // ),
      ],
    );
  }
}
