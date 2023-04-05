import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/schedule/EditDateScheduleScreen.dart';
import 'package:peace_time/screen/schedule/EditScreen.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatelessWidget {
  ScheduleCard(this.schedule, this.index);

  final Schedule schedule;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        background: Container(
          padding: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(color: Colors.red.shade400),
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerLeft,
        ),
        key: UniqueKey(),
        onDismissed: (direction) =>
            context.read<ScheduleProvider>().remove(index),
        child: ListTile(
          onTap: () {
            if (schedule.type == ScheduleType.dateTime || schedule.type == ScheduleType.quick) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => EditDateScheduleScreen(index)),
              ).then((response) => null);
            } else {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => EditScreen(index)),
              ).then((response) => null);
            }
          },
          contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 8),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        (schedule.type == ScheduleType.dateTime || schedule.type == ScheduleType.quick)
                            ? Icons.calendar_today
                            : Icons.schedule,
                        size: 18,
                        // color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(schedule.name),
                    ],
                  ),
                  Row(
                    children: [
                      dayChip("S", schedule.saturday, context),
                      dayChip("S", schedule.sunday, context),
                      dayChip("M", schedule.monday, context),
                      dayChip("T", schedule.tuesday, context),
                      dayChip("W", schedule.wednesday, context),
                      dayChip("T", schedule.thursday, context),
                      dayChip("F", schedule.friday, context),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: scheduleCardTimeText(schedule, context),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: schedule.status,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (bool value) async =>
                              await Provider.of<ScheduleProvider>(context,
                                      listen: false)
                                  .toggleScheduleStatus(index),
                          //activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
