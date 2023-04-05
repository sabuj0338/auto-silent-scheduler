import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/model/ScheduleModel.dart';

class ScheduleController {
  static Future<List<Schedule>?> getSchedules() async {
    String? schedules = await DBController.getSchedules();
    if (schedules == null)
      return null;
    else {
      List<Schedule> results = Schedule.decode(schedules);
      return results;
    }
  }
}
