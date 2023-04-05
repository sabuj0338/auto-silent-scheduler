import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/job/Algorithm.dart';
import 'package:peace_time/job/MyAlarmManager.dart';
import 'package:peace_time/model/ScheduleModel.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> schedules = List<Schedule>.empty(growable: true);
  bool selectedMode = false;
  bool isLoading = true;
  bool isAllSelectedMode = false;
  int count = 0;

  // String get name => schedule;
  ScheduleProvider() {
    // print("===== schedule provider initializing");
    initialize();
  }

  Future<void> initialize() async {

    String? schedulesFromPrefs = await DBController.getSchedules();
    if (schedulesFromPrefs != null) {
      List<Schedule> schedulesArray = Schedule.decode(schedulesFromPrefs);
      schedules = Schedule.decode(schedulesFromPrefs);

      schedulesArray.asMap().forEach((index, element) async {
        bool check = Helper.isScheduleRemovable(element);
        if(check) {
          schedules.removeAt(index);
        }
      });

      String encodedSchedulesList = Schedule.encode(schedules);
      await DBController.setSchedules(encodedSchedulesList);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleScheduleStatus(index) async {
    await MyAlarmManager.stopEventById(index);

    schedules[index].status = !schedules[index].status;
    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    await algorithm();

    notifyListeners();
  }

  Future<void> add(Schedule _schedule) async {
    schedules.add(_schedule);

    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    schedules = Schedule.decode(encodedSchedulesList);

    await algorithm();

    notifyListeners();
  }

  Future<void> update(schedule, index) async {
    await MyAlarmManager.stopEventById(index);
    schedules[index] = schedule;
    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    schedules = Schedule.decode(encodedSchedulesList);

    await algorithm();

    notifyListeners();
  }

  Future<void> remove(index) async {
    await MyAlarmManager.stopEventById(index);
    schedules.removeAt(index);
    await DBController.setSchedules(Schedule.encode(schedules));

    await algorithm();

    notifyListeners();
  }

  Future<void> removeMultiple() async {
    schedules.asMap().forEach((index, element) async {
      if(element.isSelected == true) await MyAlarmManager.stopEventById(index);
    });

    schedules.removeWhere((element) => element.isSelected == true);
    await DBController.setSchedules(Schedule.encode(schedules));
    isAllSelectedMode = false;
    selectedMode = false;

    await algorithm();

    notifyListeners();
  }

  Future<void> toggleScheduleSelection(index) async {
    schedules[index].isSelected = !schedules[index].isSelected;
    selectedScheduleItems();

    notifyListeners();
  }

  Future<void> toggleAllScheduleSelection() async {
    if (isAllSelectedMode)
      schedules.forEach((element) => element.isSelected = false);
    else
      schedules.forEach((element) => element.isSelected = true);
    isAllSelectedMode = !isAllSelectedMode;
    selectedScheduleItems();

    notifyListeners();
  }

  Future<void> selectedScheduleItems() async {
    count = 0;
    schedules.forEach((element) {
      if (element.isSelected == true) {
        count++;
      }
    });
    notifyListeners();
  }

  Future<void> setIsAllSelectedMode(bool bool) async {
    schedules.forEach((element) => element.isSelected = false);
    isAllSelectedMode = bool;
    selectedScheduleItems();
    notifyListeners();
  }

  Future<void> quick(int _minute) async {
    DateTime now = DateTime.now();
    Schedule schedule = Schedule(
      name: "Quick $_minute" + "m",
      type: ScheduleType.quick,
      start: DateTime(now.year, now.month, now.day, now.hour, now.minute)
          .toString(),
      end: DateTime(now.year, now.month, now.day, now.hour, now.minute)
          .add(Duration(minutes: _minute))
          .toString(),
      saturday: true,
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      silent: true,
      airplane: false,
      vibrate: false,
      notify: false,
      isSelected: false,
      status: true,
    );
    schedules.add(schedule);

    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    // this line should place before set provider schedules list, otherwise app will crash

    schedules = Schedule.decode(encodedSchedulesList);

    await algorithm();

    notifyListeners();
  }

  Future<void> restoreDB() async {
    await DBController.restore();
    schedules = List<Schedule>.empty(growable: true);

    notifyListeners();
  }
}
