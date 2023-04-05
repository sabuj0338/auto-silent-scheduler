import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:provider/provider.dart';

class ThemeModeBottomSheet extends StatefulWidget {
  const ThemeModeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeModeBottomSheet> createState() => _ThemeModeBottomSheetState();
}

class _ThemeModeBottomSheetState extends State<ThemeModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var _settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return Container(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: <Widget>[
          Card(
            // color: _settingsProvider.settings.theme == ThemeMode.system
            //     ? Theme.of(context).primaryColor
            //     : Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              // leading: const Icon(Icons.share),
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.android_sharp,
                    size: 60,
                    color: _settingsProvider.settings.theme == ThemeMode.system
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  // SizedBox(height: 10),
                  // Text("System")
                ],
              ),
              onTap: () => Provider.of<SettingsProvider>(context, listen: false)
                  .toggleThemeMode(ThemeMode.system),
            ),
          ),
          Card(
            // color: _settingsProvider.settings.theme == ThemeMode.dark
            //     ? Theme.of(context).primaryColor
            //     : Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              // leading: const Icon(Icons.share),
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dark_mode_sharp,
                    size: 60,
                    color: _settingsProvider.settings.theme == ThemeMode.dark
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  // SizedBox(height: 10),
                  // Text("Dark")
                ],
              ),
              onTap: () => Provider.of<SettingsProvider>(context, listen: false)
                  .toggleThemeMode(ThemeMode.dark),
            ),
          ),
          Card(
            // color: _settingsProvider.settings.theme == ThemeMode.light
            //     ? Theme.of(context).primaryColor
            //     : Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              // leading: const Icon(Icons.share),
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.light_mode_sharp,
                    size: 60,
                    color: _settingsProvider.settings.theme == ThemeMode.light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  // SizedBox(height: 10),
                  // Text("Light")
                ],
              ),
              onTap: () => Provider.of<SettingsProvider>(context, listen: false)
                  .toggleThemeMode(ThemeMode.light),
            ),
          ),
        ],
      ),
    );
  }
}
