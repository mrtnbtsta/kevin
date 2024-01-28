import 'package:flutter/material.dart';
import 'package:vendo/functions.dart';
import 'package:vendo/models.dart';
class Summary extends StatefulWidget {
  const Summary({ Key? key }) : super(key: key);

  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {

  int dailyTotal = 0;
  int weeklyTotal = 0;
  int monthlyTotal = 0;

  var diffDaily;
  var diffWeekly;
  var diffMonthly;

  @override
  void initState() {
    TFunction.getAllDaily().then((value){
      for(var i = 0; i < value.length; i++){
        setState(() {              
          dailyTotal += int.parse(value[i].coinValue); 
        });
      }
    });

  
    TFunction.getAllWeekly().then((value){
      for(var i = 0; i < value.length; i++){
        setState((){
          weeklyTotal += int.parse(value[i].coinValue);
          print("Weekly Total: $weeklyTotal");
        });
      }
    });

    TFunction.getAllMonthly().then((value){
      for(var i = 0; i < value.length; i++){
        setState(() {
          monthlyTotal += int.parse(value[i].coinValue);
          print("Monthly Total: $monthlyTotal");
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Summary Report", 
        style: TextStyle(color: Colors.black87, 
        letterSpacing: 1.5, 
        wordSpacing: 0.5, 
        fontSize: 24)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
             Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Daily", style: TextStyle(color: Colors.white, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 24, fontWeight: FontWeight.bold)),
                
                  FutureBuilder<List<SummaryReportModel>>(
                    future: TFunction.getAllDaily(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: Text(""),);
                      }else if(snapshot.data!.isEmpty){
                        return const Center(child: Text(""),);
                      }else{
                        return Column(
                          children: [
                            ...snapshot.data!.map((e){
                              var currentDate = DateTime.now().millisecondsSinceEpoch / 1000;
                              diffDaily = (currentDate - e.epoch).toInt();
                              return const SizedBox.shrink();
                            }),
                            diffDaily <= 86400 ? Text(dailyTotal.toString(), style: const TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold)) : const Text("0", style: TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold))
                          ],
                        );
                      }
                    },
                  )
                 
                ],
              ),
             ),
             Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Weekly", style: TextStyle(color: Colors.white, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 24, fontWeight: FontWeight.bold)),
                  FutureBuilder<List<SummaryReportModel>>(
                    future: TFunction.getAllDaily(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: Text(""),);
                      }else if(snapshot.data!.isEmpty){
                        return const Center(child: Text(""),);
                      }else{
                        return Column(
                          children: [
                            ...snapshot.data!.map((e){
                              var currentDate = DateTime.now().millisecondsSinceEpoch / 1000;
                              diffWeekly = (currentDate - e.epoch).toInt();
                              return const SizedBox.shrink();
                            }),
                            diffWeekly >= 518400 && diffWeekly < 604800 ? Text(weeklyTotal.toString(), style: const TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold)) : const Text("0", style: TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold))
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
             ),
             Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Monthly", style: TextStyle(color: Colors.white, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 24, fontWeight: FontWeight.bold)),
                  FutureBuilder<List<SummaryReportModel>>(
                    future: TFunction.getAllDaily(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: Text(""),);
                      }else if(snapshot.data!.isEmpty){
                        return const Center(child: Text(""),);
                      }else{
                        return Column(
                          children: [
                            ...snapshot.data!.map((e){
                              var currentDate = DateTime.now().millisecondsSinceEpoch / 1000;
                              diffMonthly = (currentDate - e.epoch).toInt();
                              return const SizedBox.shrink();
                            }),
                            diffMonthly >= 2505600 && diffMonthly < 2592000 ? Text(monthlyTotal.toString(), style: const TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold)) : const Text("0", style: TextStyle(color: Colors.yellowAccent, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 30, fontWeight: FontWeight.bold))
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
             )

            ],
          ),
        ),
      ),
    );
  }
}
