import 'package:cloud_firestore/cloud_firestore.dart';

class Items {

  String? id;
  final String message;
  final String item;
  final String coinValue;
  final int epoch;
  Items({this.id, required this.item, required this.message, required this.coinValue, required this.epoch});


  toJson() => {
    {"item": item, "message": message, "coinValue": coinValue}
  };

  factory Items.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Items(
      id: document.id,
      item: data["item"],
      message: data["message"],
      coinValue: data["coinValue"],
      epoch: data["timestamp"]
    );
  }

}

class SummaryReportModel {

  final String coinValue;
  final int epoch;

  SummaryReportModel({required this.coinValue, required this.epoch});

  factory SummaryReportModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return SummaryReportModel(
      coinValue: data["coinValue"],
      epoch: data["timestamp"]
    );
  }

}


