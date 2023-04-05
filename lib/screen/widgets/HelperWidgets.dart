import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:provider/provider.dart';

Widget dayChip(name, isActive, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 0.03 * MediaQuery.of(context).size.width,
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).chipTheme.disabledColor,
      ),
    ),
  );
}

Widget timeView(Schedule schedule, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.Hm().format(DateTime.parse(schedule.start)).toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            "~",
            style: TextStyle(fontSize: 32),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.Hm().format(DateTime.parse(schedule.end)).toString(),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ],
  );
}

Widget dayChipButton(String name, bool status, BuildContext context) {
  return Chip(
    label: Text(name.toUpperCase()),
    backgroundColor: status ? Theme.of(context).primaryColor : null,
    labelStyle: TextStyle(
      color: status ? Theme.of(context).scaffoldBackgroundColor : null,
    ),
  );
}

Widget scheduleCardTimeText(Schedule schedule, BuildContext context) {
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  String startTime = '';
  String endTime = '';
  if (is24HoursFormat) {
    if (schedule.type == ScheduleType.dateTime) {
      startTime =
          DateFormat.jm().add_yMd().format(DateTime.parse(schedule.start));
      endTime = DateFormat.jm().add_yMd().format(DateTime.parse(schedule.end));
    } else {
      startTime = DateFormat.Hm().format(DateTime.parse(schedule.start));
      endTime = Helper.isNextDay(schedule.start, schedule.end)
          ? DateFormat.Hm().format(DateTime.parse(schedule.end))
          : DateFormat.Hm().format(DateTime.parse(schedule.end));
    }
  } else {
    if (schedule.type == ScheduleType.dateTime) {
      startTime =
          DateFormat.yMMMd().add_jm().format(DateTime.parse(schedule.start));
      endTime =
          DateFormat.yMMMd().add_jm().format(DateTime.parse(schedule.end));
    } else {
      startTime = DateFormat.jm().format(DateTime.parse(schedule.start));
      endTime = Helper.isNextDay(schedule.start, schedule.end)
          ? DateFormat.jm().format(DateTime.parse(schedule.end))
          : DateFormat.jm().format(DateTime.parse(schedule.end));
    }
  }

  if (schedule.type == ScheduleType.dateTime) {
    return Text(
      (startTime + " ~ \n" + endTime).toString(),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 14,
      ),
    );
  } else {
    return Text(
      (startTime + " ~ " + endTime).toString(),
      style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
    );
  }
}

Widget timeText(String timeString, BuildContext context) {
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
  String time = '';
  if (is24HoursFormat) {
    time = DateFormat.Hm().format(DateTime.parse(timeString));
  } else {
    time = DateFormat.jm().format(DateTime.parse(timeString));
  }
  return Text(time.toLowerCase().toString());
}

Widget emptyWidget(BuildContext context) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: SvgPicture.asset(Constant.EMPTY_SVG),
    ),
  );
}

Widget bottomNavigationBar(BuildContext context) {
  var scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
  return BottomAppBar(
    child: Container(
      margin: EdgeInsets.only(left: 12.0, right: 75.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
              shape: StadiumBorder(),
              child: Icon(
                Icons.volume_off_sharp,
                color: Theme.of(context).disabledColor,
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => scheduleProvider.quick(60),
                  child: Chip(
                    label: Text('60m'),
                  ),
                ),
                GestureDetector(
                  onTap: () => scheduleProvider.quick(120),
                  child: Chip(
                    label: Text('120m'),
                  ),
                ),
                GestureDetector(
                  onTap: () => scheduleProvider.quick(180),
                  child: Chip(
                    label: Text('150m'),
                  ),
                ),
                GestureDetector(
                  onTap: () => scheduleProvider.quick(180),
                  child: Chip(
                    label: Text('180m'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    //to add a space between the FAB and BottomAppBar
    shape: CircularNotchedRectangle(),
    //color of the BottomAppBar
    // color: Colors.white,
  );
}
