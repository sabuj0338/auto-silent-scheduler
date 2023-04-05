import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:provider/provider.dart';

class EditDateScheduleScreen extends StatefulWidget {
  final int index;
  const EditDateScheduleScreen(this.index);

  @override
  _EditDateScheduleScreenState createState() => _EditDateScheduleScreenState();
}

class _EditDateScheduleScreenState extends State<EditDateScheduleScreen> {
  late Schedule schedule;
  TimeOfDay time = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay picked = TimeOfDay(hour: 0, minute: 0);
  TextEditingController name = TextEditingController();

  bool is24HoursFormat = false;
  bool isFormSubmitting = false;

  Map<String, bool> errors = {'name': false};

  Future<Null> selectStartTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(schedule.start),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.parse(schedule.start)));
    if (pickedDate != null && pickedTime != null) {
      setState(() {
        schedule.start = DateTime(pickedDate.year, pickedDate.month,
                pickedDate.day, pickedTime.hour, pickedTime.minute)
            .toString();
      });
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(schedule.end),
      firstDate: DateTime.parse(schedule.start),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.parse(schedule.end)));
    if (pickedDate != null && pickedTime != null) {
      // final now = new DateTime.now();
      setState(() {
        schedule.end = DateTime(pickedDate.year, pickedDate.month,
                pickedDate.day, pickedTime.hour, pickedTime.minute)
            .toString();
      });
    }
  }

  void submitForm() async {
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
      schedule.name = name.text;

      Provider.of<ScheduleProvider>(context, listen: false)
          .update(schedule, widget.index);
      Navigator.pop(context, true);
    }

    setState(() => isFormSubmitting = false);
  }

  void getScheduleDetails() async {
    this.schedule = Provider.of<ScheduleProvider>(context, listen: false)
        .schedules[widget.index];
    setState(() {
      name = TextEditingController(text: schedule.name.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () async {
      is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    });
    getScheduleDetails();
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
          "Update".toUpperCase(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.calendar_today),
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
                          controller: name,
                          onChanged: (String value) {
                            setState(() {
                              schedule.name = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name..',
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
                            DateFormat.yMMMMd()
                                .add_jm()
                                .format(DateTime.parse(schedule.start))
                                .toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text("Start DateTime"),
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
                            DateFormat.yMMMMd()
                                .add_jm()
                                .format(DateTime.parse(schedule.end))
                                .toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text("End DateTime"),
                          trailing: IconButton(
                            icon: Icon(Icons.alarm_add),
                            onPressed: () {
                              selectEndTime(context);
                            },
                          ),
                        ),
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
                    // Card(
                    //   child: ListTile(
                    //     title: Text("Airplane Mode"),
                    //     subtitle: Text("Phone will automatically airplane."),
                    //     trailing: CupertinoSwitch(
                    //       value: airplane,
                    //       activeColor: Colors.grey[700],trackColor: Colors.black,
                    //       onChanged: (bool value) {
                    //         setState(() {
                    //           airplane = !airplane;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   child: ListTile(
                    //     title: Text("Notify Me"),
                    //     subtitle: Text("Phone will automatically notify you."),
                    //     trailing: CupertinoSwitch(
                    //       value: notify,
                    //       activeColor: Colors.grey[700],trackColor: Colors.black,
                    //       onChanged: (bool value) {
                    //         setState(() {
                    //           notify = !notify;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
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
                        child: const Text("UPDATE"),
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
