import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool is24HoursFormat = false;
  bool isFormSubmitting = false;
  TimeOfDay time = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay picked = TimeOfDay(hour: 0, minute: 0);
  Schedule schedule = Schedule(
      name: "",
      type: ScheduleType.daily,
      start: DateTime.now().toString(),
      end: DateTime.now().toString(),
      silent: true,
      vibrate: false,
      airplane: false,
      notify: false,
      saturday: true,
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      status: false,
      isSelected: false);

  Future<Null> selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (picked != null) {
      setState(() {
        // final now = new DateTime.now();
        schedule.start =
            DateTime(2021, 04, 12, picked.hour, picked.minute).toString();
        schedule.end =
            DateTime(2021, 04, 12, picked.hour, picked.minute).toString();
      });
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.parse(schedule.start)));
    if (picked != null) {
      // final now = new DateTime.now();
      schedule.end =
          DateTime(2021, 04, 12, picked.hour, picked.minute).toString();
      if (Helper.isEndTimeBeforeStartTime(schedule.start, schedule.end)) {
        setState(() {
          schedule.end =
              DateTime(2021, 04, 12 + 1, picked.hour, picked.minute).toString();
        });
      } else {
        setState(() {
          schedule.end =
              DateTime(2021, 04, 12, picked.hour, picked.minute).toString();
        });
      }
    }
  }

  Future<void> submitForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() => isFormSubmitting = true);

    if (schedule.name == '') {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Oops! Schedule name required.',
          style: TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (schedule.name.length > 10) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Oops! Schedule name should be less than 10 characters',
          style: TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Provider.of<ScheduleProvider>(context, listen: false).add(schedule);
      Navigator.pop(context, true);
    }

    setState(() => isFormSubmitting = false);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Create New".toUpperCase(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.schedule),
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(children: [
                    SizedBox(height: 10.0),
                    Card(
                      // elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              schedule.name = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name...',
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 8 * 5.0),
                    Card(
                      child: GestureDetector(
                        onTap: () {
                          selectStartTime(context);
                        },
                        child: ListTile(
                          title: Text(
                            Helper.timeText(schedule.start, context),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text("Start Time"),
                          trailing: IconButton(
                            icon: Icon(Icons.alarm_add),
                            onPressed: () {
                              selectStartTime(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: GestureDetector(
                        onTap: () {
                          selectEndTime(context);
                        },
                        child: ListTile(
                          title: Text(
                            Helper.isNextDay(schedule.start, schedule.end)
                                ? Helper.timeText(schedule.end, context) +
                                    ', next day'
                                : Helper.timeText(schedule.end, context),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text("End Time"),
                          trailing: IconButton(
                            icon: Icon(Icons.alarm_add),
                            onPressed: () {
                              selectEndTime(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.saturday = !schedule.saturday;
                              });
                            },
                            child:
                                dayChipButton('s', schedule.saturday, context),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.sunday = !schedule.sunday;
                              });
                            },
                            child: dayChipButton('s', schedule.sunday, context),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  schedule.monday = !schedule.monday;
                                });
                              },
                              child:
                                  dayChipButton('m', schedule.monday, context)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.tuesday = !schedule.tuesday;
                              });
                            },
                            child:
                                dayChipButton('t', schedule.tuesday, context),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.wednesday = !schedule.wednesday;
                              });
                            },
                            child:
                                dayChipButton('w', schedule.wednesday, context),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.thursday = !schedule.thursday;
                              });
                            },
                            child:
                                dayChipButton('t', schedule.thursday, context),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedule.friday = !schedule.friday;
                              });
                            },
                            child: dayChipButton('f', schedule.friday, context),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Silent Mode"),
                        subtitle: Text("Phone will automatically silent."),
                        trailing: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: CupertinoSwitch(
                            value: schedule.silent,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                schedule.silent = !schedule.silent;
                                schedule.vibrate = !schedule.vibrate;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Vibrate Mode"),
                        subtitle: Text("Phone will automatically vibrate."),
                        trailing: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: CupertinoSwitch(
                            value: schedule.vibrate,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                schedule.silent = !schedule.silent;
                                schedule.vibrate = !schedule.vibrate;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                // color: Theme.of(context).backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                child: isFormSubmitting
                    ? const Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        shape: const StadiumBorder(),
                        elevation: 0,
                        height: 50.0,
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: const Text("SAVE"),
                        onPressed: () => submitForm(),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
