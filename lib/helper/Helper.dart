import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/constant.dart';

class Helper {
  static TimeOfDay fromStringToTimeOfDay(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  static TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  static TimeOfDay from24StringToTimeOfDay(String tod) {
    TimeOfDay _currentTime = Helper.stringToTimeOfDay(tod);
    // _currentTime.format(context)
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  static bool isTimeBetween(Schedule schedule) {
    // DateFormat dateFormat = new DateFormat.Hm();
    DateTime nowTime = DateTime.now();
    DateTime startTime = DateTime.parse(schedule.start);
    DateTime endTime = DateTime.parse(schedule.end);
    // .subtract(Duration(minutes: 1));
    DateTime now = DateTime(2021, 04, 12, nowTime.hour, nowTime.minute);
    DateTime start =
        DateTime(2021, 04, 12, startTime.hour, startTime.minute - 1);
    DateTime end = DateTime(2021, 04, 12, endTime.hour, endTime.minute);
    if (startTime.day != endTime.day) {
      if (now.isBefore(end)) {
        start =
            DateTime(2021, 04, 12 - 1, startTime.hour, startTime.minute - 1);
      } else if (now.isAfter(start)) {
        end = DateTime(2021, 04, 12 + 1, endTime.hour, endTime.minute);
      }
    }
    if (schedule.type == ScheduleType.dateTime || schedule.type == ScheduleType.quick) {
      start = DateTime(startTime.year, startTime.month, startTime.day,
          startTime.hour, startTime.minute - 1);
      end = DateTime(endTime.year, endTime.month, endTime.day, endTime.hour,
          endTime.minute);
      now = DateTime(nowTime.year, nowTime.month, nowTime.day, nowTime.hour,
          nowTime.minute);
    }
    // print('now = ' + now.toString());
    // print('start = ' + start.toString());
    // print('end = ' + end.toString());
    // print('-------------');
    if (now.isAfter(start) && now.isBefore(end)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTimeAfterThisEndTime(String startTime, String endTime) {
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime start = dateFormat.parse(startTime);
    DateTime end = dateFormat.parse(endTime);

    if (end.isAfter(start)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEndTimeBeforeStartTime(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);

    if (end.isBefore(start)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isNextDay(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);
    // DateTime now = DateTime.now();
    if (DateTime(end.year, end.month, end.day)
            .difference(DateTime(start.year, start.month, start.day))
            .inDays ==
        1) {
      return true;
    } else {
      return false;
    }
  }

  static String timeText(String timeString, BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    String time = '';
    if (is24HoursFormat) {
      time = DateFormat.Hm().format(DateTime.parse(timeString));
    } else {
      time = DateFormat.jm().format(DateTime.parse(timeString));
    }
    return time;
  }

  static bool isToday(Schedule schedule) {

    DateTime today = DateTime.now();

    if(schedule.type == ScheduleType.dateTime || schedule.type == ScheduleType.quick) {
      DateTime startDay = DateTime.parse(schedule.start);
      DateTime endDay = DateTime.parse(schedule.end);

      if(today.difference(startDay).inDays == 0) return true;
      else if(today.difference(endDay).inDays == 0) return true;
      else return false;
    }

    String? todayName = Constant.dayNames[today.weekday];

    if (schedule.saturday == true && todayName == 'saturday')
      return true;
    else if (schedule.sunday == true && todayName == 'sunday')
      return true;
    else if (schedule.monday == true && todayName == 'monday')
      return true;
    else if (schedule.tuesday == true && todayName == 'tuesday')
      return true;
    else if (schedule.wednesday == true && todayName == 'wednesday')
      return true;
    else if (schedule.thursday == true && todayName == 'thursday')
      return true;
    else if (schedule.friday == true && todayName == 'friday')
      return true;
    else
      return false;
  }

  static bool isNowBefore(String startTime) {
    // DateFormat dateFormat = new DateFormat.Hm();
    DateTime dateTimeNow = DateTime.now();
    DateTime start = DateTime.parse(startTime);
    DateTime dateTimeCreatedAt = DateTime(dateTimeNow.year,dateTimeNow.month,dateTimeNow.day,start.hour,start.minute);
    final difference = dateTimeCreatedAt.difference(dateTimeNow).inSeconds;
    // print('Start time = $dateTimeCreatedAt');
    // print('Now = $dateTimeNow');
    // print('difference minutes = $difference');
    if (difference <= 600 && difference > 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isScheduleRemovable(Schedule schedule) {
    if(schedule.type == ScheduleType.daily) return false;
    // DateFormat dateFormat = new DateFormat.Hm();
    DateTime dateTimeNow = DateTime.now();
    DateTime end = DateTime.parse(schedule.end);
    DateTime dateTimeEnding = DateTime(end.year,end.month,end.day,end.hour,end.minute);
    final difference = dateTimeEnding.difference(dateTimeNow).inSeconds;
    // print('End time = $dateTimeEnding');
    // print('Now = $dateTimeNow');
    // print('difference minutes = $difference');
    if (difference < 0) {
      return true;
    } else {
      return false;
    }
  }
}
