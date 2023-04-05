import 'dart:convert';

enum ScheduleType {
  quick,
  daily,
  dateTime
}

class Schedule {
  String name;
  ScheduleType type;
  String start;
  String end;
  bool silent;
  bool vibrate;
  bool airplane;
  bool notify;
  bool saturday;
  bool sunday;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool status;
  bool isSelected;

  Schedule({
    required this.name,
    required this.type,
    required this.start,
    required this.end,
    required this.silent,
    required this.vibrate,
    required this.airplane,
    required this.notify,
    required this.saturday,
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.status,
    required this.isSelected,
  });

  // json to schedule object
  factory Schedule.fromJson(Map<String, dynamic> jsonData) {
    return Schedule(
      name: jsonData['name'],
      type: ScheduleType.values.byName(jsonData['type']),
      start: jsonData['start'],
      end: jsonData['end'],
      silent: jsonData['silent'],
      vibrate: jsonData['vibrate'],
      airplane: jsonData['airplane'],
      notify: jsonData['notify'],
      saturday: jsonData['saturday'],
      sunday: jsonData['sunday'],
      monday: jsonData['monday'],
      tuesday: jsonData['tuesday'],
      wednesday: jsonData['wednesday'],
      thursday: jsonData['thursday'],
      friday: jsonData['friday'],
      status: jsonData['status'],
      isSelected: false,
    );
  }

  // schedule to json map
  static Map<String, dynamic> toMap(Schedule schedule) => {
        'name': schedule.name,
        'type': schedule.type.name,
        'start': schedule.start,
        'end': schedule.end,
        'silent': schedule.silent,
        'vibrate': schedule.vibrate,
        'airplane': schedule.airplane,
        'notify': schedule.notify,
        'saturday': schedule.saturday,
        'sunday': schedule.sunday,
        'monday': schedule.monday,
        'tuesday': schedule.tuesday,
        'wednesday': schedule.wednesday,
        'thursday': schedule.thursday,
        'friday': schedule.friday,
        'status': schedule.status,
        'isSelected': schedule.isSelected,
      };

  // encoding list of schedule
  // converting list of schedule object to json string then encode
  static String encode(List<Schedule> schedules) => json.encode(
        schedules
            .map<Map<String, dynamic>>((schedule) => Schedule.toMap(schedule))
            .toList(),
      );

  // decoding list of schedule
  // converting json map string to list of schedule object then encode
  static List<Schedule> decode(String schedules) =>
      (json.decode(schedules) as List<dynamic>)
          .map<Schedule>((item) => Schedule.fromJson(item))
          .toList();
}
