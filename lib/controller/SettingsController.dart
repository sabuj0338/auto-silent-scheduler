import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class SettingsController {
  static Future<RingerModeStatus> getCurrentSoundMode() async {
    RingerModeStatus ringerStatus;
    try {
      ringerStatus = await SoundMode.ringerModeStatus;
      if (Platform.isIOS) {
        //because i no push meesage form ios to flutter,so need read two times
        await Future.delayed(Duration(milliseconds: 1000), () async {
          ringerStatus = await SoundMode.ringerModeStatus;
        });
      }
    } catch (err) {
      ringerStatus = RingerModeStatus.unknown;
      print('Failed to get device\'s ringer status.$err');
    }
    return ringerStatus;
  }

  static Future<bool> getPermissionStatus() async {
    bool? permissionStatus = false;
    try {
      permissionStatus = await PermissionHandler.permissionsGranted;
      // print(permissionStatus);
      return permissionStatus == true ? true : false;
    } catch (err) {
      // print(err);
      return false;
    }
  }

  static Future<void> setSilentMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setNormalMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.normal);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setVibrateMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.vibrate);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> openDoNotDisturbSettings() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }
}
