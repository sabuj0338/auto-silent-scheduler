
import 'package:peace_time/constant.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/job/MyAlarmManager.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

Future<void> algorithm() async {
  print("===> 🤌 Thanos Snapped At [${DateTime.now()}]");

  List<Schedule>? schedules = await ScheduleController.getSchedules();
  // print("===> Schedules Count = ${schedules?.length}");

  if (schedules == null) return;

  final index = schedules.indexWhere((schedule) =>
  (schedule.status == true && Helper.isToday(schedule) == true && (Helper.isNowBefore(schedule.start) == true || Helper.isTimeBetween(schedule) == true)) ==
      true);

  // return if found that already once activated a schedule
  bool? __normalPeriod = await DBController.getNormalPeriod();
  // print("===> Index [$index], __normalPeriod [$__normalPeriod]");

  if(index < 0 && __normalPeriod == true) {
    await DBController.setNormalPeriod(false);
    __normalPeriod = false;
    await SettingsController.setNormalMode();
  }

  if(index < 0 && __normalPeriod == false) return;

  if(index < 0) return;

  if(Helper.isTimeBetween(schedules[index]) == true) {

    // print("===> Is between 😎 ");

    RingerModeStatus currentSoundMode = await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerModeStatus.normal) {
      DateTime now = DateTime.now();
      // DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      // DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if(Helper.isEndTimeBeforeStartTime(schedules[index].start, schedules[index].end)) {
        endDateTime = DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      // print("Now = $now, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager().setOneShot(index, RingerModeStatus.vibrate);
        await MyAlarmManager().setOneShotAt(endDateTime, index + Constant.NORMAL_MODE_ID, RingerModeStatus.normal);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager().setOneShot(index, RingerModeStatus.silent);
        await MyAlarmManager().setOneShotAt(endDateTime, index + Constant.NORMAL_MODE_ID, RingerModeStatus.normal);
      }
    }
  }
  else if(Helper.isNowBefore(schedules[index].start) == true) {

    // print("===> Is now before 😎 ");

    RingerModeStatus currentSoundMode = await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerModeStatus.normal) {
      DateTime now = DateTime.now();
      DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if(Helper.isEndTimeBeforeStartTime(schedules[index].start, schedules[index].end)) {
        endDateTime = DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      // print("Start = $start, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager().setOneShotAt(startDateTime, index, RingerModeStatus.vibrate);
        await MyAlarmManager().setOneShotAt(endDateTime, index + Constant.NORMAL_MODE_ID, RingerModeStatus.normal);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager().setOneShotAt(startDateTime, index, RingerModeStatus.silent);
        await MyAlarmManager().setOneShotAt(endDateTime, index + Constant.NORMAL_MODE_ID, RingerModeStatus.normal);
      }
    }

  }
}