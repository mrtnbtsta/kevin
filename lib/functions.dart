import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class TFunction {
  static final db = FirebaseFirestore.instance;

  static Future<List<Items>> getAll() async {
    final snapshot = await db.collection("ESP8266").get();
    return snapshot.docs.map((e) => Items.fromSnapshot(e)).toList();
  }

  static Future<List<SummaryReportModel>> getAllDaily() async {
    //24hrs
    var currentDailyTime = ((DateTime.now().millisecond / 1000) * 24 * 60 * 60).toInt();
    // print(currentDailyTime);
    final snapshot = await db.collection("ESP8266").where('timestamp', isGreaterThanOrEqualTo: currentDailyTime).get();
    return snapshot.docs.map((e) => SummaryReportModel.fromSnapshot(e)).toList();
  }

  static Future<List<SummaryReportModel>> getAllWeekly() async {
    //6-7days
    var currentWeeklyTime = ((DateTime.now().millisecond / 1000) * 24 * 60 * 60 * 700 * 10).toInt();
    var currentWeeklyTime1 = ((DateTime.now().millisecond / 1000) * 24 * 60 * 60 * 600 * 10).toInt();
    final snapshot = await db.collection("ESP8266").where('timestamp', isGreaterThanOrEqualTo: currentWeeklyTime).where('timestamp', isLessThanOrEqualTo: currentWeeklyTime1).get();
    return snapshot.docs.map((e) => SummaryReportModel.fromSnapshot(e)).toList();
  }

  static Future<List<SummaryReportModel>> getAllMonthly() async {
    //29-30days
    var currentMonthlyTime = ((DateTime.now().millisecond / 1000) * 24 * 60 * 60 * 1000 * 30).toInt();
    var currentMonthlyTime1 = ((DateTime.now().millisecond / 1000) * 24 * 60 * 60 * 1000 * 29).toInt();
    final snapshot = await db.collection("ESP8266").where('timestamp', isGreaterThanOrEqualTo: currentMonthlyTime).where('timestamp', isLessThanOrEqualTo: currentMonthlyTime1).get();
    // final snapshot = await db.collection("ESP8266").orderBy("timestamp",descending: false).startAt([endDate]).endAt([todayDate]).get();
    return snapshot.docs.map((e) => SummaryReportModel.fromSnapshot(e)).toList();
  }



  

  


}
