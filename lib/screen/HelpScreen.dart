import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // backgroundColor: Theme.of(context).cardColor,
        // elevation: 0,
        title: Text('How to use?'.toUpperCase()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.help_outline_rounded,
              // color: Colors.grey[700],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Quick schedule"),
                subtitle: Text(
                    "Tap floating plus (+) button then set minutes and tap \'Quick Silent'\. It will create your selected fixed minute quick schedule silent."),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Create schedule"),
                subtitle: Text(
                    "Tap floating plus (+) button then tap \'New Schedule'\ and create new schedule by giving schedule name and select start and end time and select days and select silent and vibrate options."),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Update schedule"),
                subtitle: Text(
                    "Tap any schedule from schedule list in home screen and update schedule by giving schedule name and select start and end time and select days and select silent and vibrate options."),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Remove schedule one by one"),
                subtitle: Text(
                    "Hold and swipe right which schedule you want to remove and it will remove."),
              ),
            ),
            // Card(
            //   child: ListTile(
            //     title: Text("Remove multiple schedule at a time"),
            //     subtitle: Text(
            //         "Long press any of schedule from schedule list and select schedule and remove schedule by taping floating trash button."),
            //   ),
            // ),
            Card(
              child: ListTile(
                title: Text(
                  "Note: Why app is not working?",
                  style: TextStyle(color: Colors.red.shade300),
                ),
                subtitle: Text(
                    "Realme, Oneplus, Samsung, Xiaomi, Huawei and a few other manufacturers have their own layer of 'Battery Saver' or 'Security' that kills or restricts background running apps. That's why app is not working properly. You have to enable battery uses restictions, or other security restrictions so that app can work properly."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
