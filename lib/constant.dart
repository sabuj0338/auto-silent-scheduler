import 'package:flutter/material.dart';

class Constant {
  static const Map<int, String> dayNames = {
    1: 'monday',
    2: 'tuesday',
    3: 'wednesday',
    4: 'thursday',
    5: 'friday',
    6: 'saturday',
    7: 'sunday',
  };

  static const String SP_SCHEDULES = "__schedules";
  static const String SP_DEFAULT_SCHEDULE = "__default_schedule";
  static const String SP_NORMAL_PERIOD = "__normal__period";
  static const String SP_INTRODUCTION = "__intro";
  static const String SP_DARKMODE = "__dark_mode";
  static const String SP_RESET = "__reset_v8";
  static const String SP_DEFAULT_SILENT_MINUTE = "__default_silent_minute";

  static const int ARC_REACTOR_ID = 10000000;
  static const int NORMAL_MODE_ID = 99999999;

  static const EMPTY_SVG = 'assets/empty.svg';

  static const APPICON = 'assets/ic_launcher.png';
  static const APPICON_SVG = 'assets/ic_launcher.svg';

  static ThemeData lightMode = ThemeData(
    // brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      // brightness: Brightness.light,
      elevation: 2,
      // titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20)
    ),
    primarySwatch: Colors.indigo,
    primaryColor: Colors.indigo,
    backgroundColor: Color.fromARGB(255, 243, 243, 243),
    scaffoldBackgroundColor: Color.fromARGB(255, 243, 243, 243),
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: const Radius.circular(15.0),
      //     topRight: const Radius.circular(15.0),
      //   ),
      // ),
    ),
    // chipTheme: ChipThemeData(
    //   elevation: 0,
    //   // selectedColor: Colors.indigoAccent,
    //   // backgroundColor: Colors.indigo
    // ),

    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      elevation: 2,
    ),
    dividerColor: Colors.transparent,
  );

  static ThemeData darkMode = ThemeData(
    // colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black,
    ),
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      color: const Color(0xff101010),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: const Radius.circular(15.0),
      //     topRight: const Radius.circular(15.0),
      //   ),
      // ),
    ),
    chipTheme: ChipThemeData(
      elevation: 0,
      backgroundColor: Color(0xff121212),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xff101010),
      elevation: 2,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      // extendedTextStyle: TextStyle(color: Colors.white),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      refreshBackgroundColor: Color(0xff101010),
    ),
    dividerColor: Colors.transparent,
  );

  static ThemeData darkMode2 = ThemeData(
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(elevation: 0),
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xff121212),
    cardTheme: CardTheme(
      elevation: 0,
      color: const Color(0xff191919),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff121212),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: const Radius.circular(15.0),
      //     topRight: const Radius.circular(15.0),
      //   ),
      // ),
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Color(0xff121212),
    // ),
    chipTheme: ChipThemeData(
      elevation: 0,
      backgroundColor: Color(0xff202020),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xff191919),
      elevation: 2,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      // backgroundColor: Color(0xff191919),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      // extendedTextStyle: TextStyle(color: Colors.white),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      refreshBackgroundColor: Color(0xff191919),
    ),
    dividerColor: Colors.transparent,
    // iconTheme: IconThemeData(color: Colors.white),
    // primaryIconTheme: IconThemeData(color: Colors.white),
  );
}
