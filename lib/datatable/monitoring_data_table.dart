import 'package:flutter/material.dart';
import 'package:vendo/models.dart';

class MonitoringDataTable extends DataTableSource{

  MonitoringDataTable({required this.dataList, required this.context});
  final List<Items> dataList;
  late BuildContext context;
  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(dataList[index].message.toString(), style: const TextStyle(color: Colors.black87, fontSize: 18, letterSpacing: 1.5, wordSpacing: 0.5),)),
        DataCell(Text(dataList[index].item.toString(), style: const TextStyle(color: Colors.black87, fontSize: 18, letterSpacing: 1.5, wordSpacing: 0.5),)),
      ]
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => dataList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}

extension StringExtension on String {
  String ucfirst(){
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}