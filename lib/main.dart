import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/job/Algorithm.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:provider/provider.dart';

void arcReactor() async => await algorithm();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await ClearAllNotifications.clear();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // Provider<ScheduleController>(create: (context) => ScheduleController())
      ],
      child: App(),
    ),
  );
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 1),
    Constant.ARC_REACTOR_ID,
    arcReactor,
    wakeup: true,
    exact: true,
    allowWhileIdle: false,
    rescheduleOnReboot: true,
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Peace Time',
      theme: Constant.lightMode,
      darkTheme: Constant.darkMode,
      themeMode: Provider.of<SettingsProvider>(context).settings.theme,
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
