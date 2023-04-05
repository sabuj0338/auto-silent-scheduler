import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/MyNotification.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class MyAlarmManager {
  Future<void> setOneShot(int id, RingerModeStatus mode) async {
    switch (mode) {
      case RingerModeStatus.normal:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 5),
          id,
          setNormal,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      case RingerModeStatus.silent:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 5),
          id,
          setSilent,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      case RingerModeStatus.vibrate:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 5),
          id,
          setVibrate,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      default:
        return;
    }
  }

  Future<void> setOneShotAt(
      DateTime dateTime, int id, RingerModeStatus mode) async {
    switch (mode) {
      case RingerModeStatus.normal:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setNormal,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      case RingerModeStatus.silent:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setSilent,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      case RingerModeStatus.vibrate:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setVibrate,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          // alarmClock: true,
        );
        return;
      default:
        return;
    }
  }
  //
  // Future<void> setSilentAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setSilent,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }
  //
  // Future<void> setVibrateAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setVibrate,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }
  //
  // Future<void> setNormalAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setNormal,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }

  static Future<void> setSilent(int id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.jm().format(now);
    // print("Silent OneShot fired at! = [$id]");
    await MyNotification().notificationDefaultSound(
        title: "Silent Mode Activated!",
        description: "Activated at = [$formattedDate]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setSilentMode();
    await AndroidAlarmManager.cancel(id);
  }

  static Future<void> setVibrate(int id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.jm().format(now);
    // print("Vibrate OneShot fired at! = [$id]");
    await MyNotification().notificationDefaultSound(
        title: "Vibration Mode Activated!",
        description: "Activated at = [$formattedDate]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setVibrateMode();
    await AndroidAlarmManager.cancel(id);
  }

  static Future<void> setNormal(int id) async {
    // print("Normal OneShot fired at! = [$id]");
    // await MyNotification().notificationDefaultSound(title: "Silent Mode Activated!", description: "Activated at = [$formattedDate]");
    await DBController.setNormalPeriod(false);
    await SettingsController.setNormalMode();
    await AndroidAlarmManager.cancel(id + Constant.NORMAL_MODE_ID);
  }

  static Future<void> stopEventById(int id) async {
    await AndroidAlarmManager.cancel(id + Constant.NORMAL_MODE_ID);
    await AndroidAlarmManager.cancel(id);
  }
}
