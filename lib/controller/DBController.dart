import 'package:flutter/material.dart';
import 'package:peace_time/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBController {
  static Future<bool> getIntroductionScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getBool(Constant.SP_INTRODUCTION) == true ? true : false;
  }

  static Future<void> toggleIntroductionScreenStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_INTRODUCTION, value);
    await prefs.reload();
  }

  static Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? value = prefs.getString(Constant.SP_DARKMODE);

    if (value == ThemeMode.light.name.toString()) {
      // await togglelightModeStatus(false);
      return ThemeMode.light;
    } else if (value == ThemeMode.dark.name.toString()) {
      // await toggleDarkModeStatus(false);
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static Future<void> setThemeMode(ThemeMode value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.SP_DARKMODE, value.name.toString());
    await prefs.reload();
  }

  static Future<bool> getDefaultSchedulesStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getBool(Constant.SP_INTRODUCTION) == true ? true : false;
  }

  static Future<void> setDefaultSchedulesStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_DEFAULT_SCHEDULE, value);
    await prefs.reload();
  }

  static Future<String?> getSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getString(Constant.SP_SCHEDULES);
  }

  static Future<void> setSchedules(String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.SP_SCHEDULES, string);
    await prefs.reload();
  }

  static Future<bool> getNormalPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getBool(Constant.SP_NORMAL_PERIOD) == true ? true : false;
  }

  static Future<void> setNormalPeriod(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_NORMAL_PERIOD, value);
    await prefs.reload();
  }

  static Future<int> getDefaultSilentMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    int? minute = prefs.getInt(Constant.SP_DEFAULT_SILENT_MINUTE);
    return minute == null ? 0 : minute;
  }

  static Future<void> setDefaultSilentMinute(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constant.SP_DEFAULT_SILENT_MINUTE, value);
    await prefs.reload();
  }

  static Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final reset = prefs.getBool(Constant.SP_RESET);
    if (reset == null || reset == false) {
      // await prefs.clear();
      await prefs.remove(Constant.SP_SCHEDULES);
      // await prefs.setString(Constant.SP_SCHEDULES, '');
      await prefs.setBool(Constant.SP_RESET, true);
    } else {
      await prefs.setBool(Constant.SP_RESET, true);
    }
    await prefs.reload();
  }

  static Future<void> restore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final reset = prefs.getBool(Constant.SP_RESET);
    await prefs.clear();
    await prefs.setBool(Constant.SP_RESET, true);

    await prefs.reload();
  }
}
