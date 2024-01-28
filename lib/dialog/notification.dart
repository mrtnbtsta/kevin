import 'package:flutter/material.dart';
import 'package:vendo/functions.dart';

Widget buildNotifications(BuildContext context) {
  return AlertDialog(
    insetPadding: const EdgeInsets.all(20),
    contentPadding: const EdgeInsets.all(20),
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Text("Notifications",
            style:  TextStyle(
                color: Colors.black87, letterSpacing: 1.5, wordSpacing: 0.5, fontWeight: FontWeight.bold)),
        // Container(
        //   decoration: const BoxDecoration(
        //       color: Colors.deepPurple,
        //       borderRadius: BorderRadius.all(Radius.circular(5))),
        //   child: TextButton(
        //     onPressed: () => {},
        //     child: const Text("Clear All",
        //         style: TextStyle(
        //             color: Colors.white,
        //             letterSpacing: 1.5,
        //             wordSpacing: 0.5)),
        //   ),
        // )
      ],
    ),
    content: SizedBox(
      width: 300,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
            future: TFunction.getAll(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.isEmpty){
                return const Center(child: Text("No Notification"),);
              }else{
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Bought a ${data.item}", style: const TextStyle(color: Colors.black87, letterSpacing: 1.5, wordSpacing: 0.5, fontSize: 16),),
                          const Divider()
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
    ),
  );
}

extension StringExtension on String {
  String ucfirst(){
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
