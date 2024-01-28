import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vendo/datatable/monitoring_data_table.dart';
import 'package:vendo/dialog/notification.dart';
import 'package:vendo/page/summary.dart';
import '../functions.dart';
import 'package:vendo/models.dart';
class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {


  List<Items> list = <Items>[];
  List<Items> tempList = [];
  

  @override
  void initState() {
    TFunction.getAll().then((value) => {
      setState(() => list.addAll(value))
    });
    tempList = list;
    super.initState();
  }

  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitoring", 
        style: TextStyle(color: Colors.black87, 
        letterSpacing: 1.5, 
        wordSpacing: 0.5, 
        fontSize: 24)),
        actions: [
          Container(
            margin: EdgeInsets.zero,
            child: Stack(
              children: [
              IconButton( 
                onPressed: () => showDialog(context: context, builder:(context) => buildNotifications(context),),
                icon: const Icon(Bootstrap.bell),
              ),
                FutureBuilder(
                  future: TFunction.getAll(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }else if(snapshot.data!.isEmpty){
                      return const SizedBox.shrink();
                    }else {
                      return Positioned(
                        left: 25,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: snapshot.data!.isEmpty
                                  ? Colors.transparent
                                  : Colors.amber.shade600),
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            snapshot.data!.length.toString(),
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }
                )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              TextButton(
                onPressed: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder:(context, animation, secondaryAnimation) => const Summary(),reverseTransitionDuration: Duration.zero, transitionDuration: Duration.zero)),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Text("Summary Report", style: TextStyle(color: Colors.white, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 20)),
                ),
              ),

              const SizedBox(height: 18,),
            
              Theme(
                    data: Theme.of(context).copyWith(cardColor: const Color.fromARGB(255, 247, 242, 242), dividerColor: const Color.fromARGB(255, 219, 221, 223), dataTableTheme: const DataTableThemeData(headingTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PaginatedDataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      horizontalMargin: 40,
                      rowsPerPage: rowsPerPage,
                      availableRowsPerPage: const [5,10,20,30],
                      onRowsPerPageChanged: (value) {
                        setState(() => rowsPerPage = rowsPerPage);
                      },         
                      columnSpacing: 100,
                      columns: const [
                        // DataColumn(label: const Expanded(child: Text("Image")), onSort: (columnIndex, ascending) {
                          // setState(() {
                          //   sortProduct = !sortProduct;
                          // });
                          // onSortDataProduct(columnIndex, ascending);
                        // }),
                         DataColumn(label: Expanded(child: Text("Message"))),
                         DataColumn(label: Expanded(child: Text("Item"))),
                      ],
                      source: MonitoringDataTable(dataList: tempList, context: context),
                      // source: AdminDataTable(dataList: tempList, context: context)
                        ),
                    ),
                    )
              

            ],
          ),
        ),
      ),
    );
  }
}

DataTableSource monitoringData(List<Items> data, BuildContext context) => MonitoringDataTable(dataList: data, context: context);
