import 'package:app/connections/conn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'details.dart';

class ListHotels extends StatefulWidget {
  const ListHotels({super.key});

  @override
  State<ListHotels> createState() => _ListHotelsState();
}

class _ListHotelsState extends State<ListHotels> {
  List<Widget> allWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text("LIST HOTEL"),
      ),
      body: FutureBuilder(
          future: ConnectionUrl().getHttp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                allWidgets.add(
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Details(value: snapshot.data![i]['HotelId'])));
                      },
                      child: Container(
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.apartment)),
                          title: Text('${snapshot.data![i]['HotelName']}'),
                          subtitle:
                              Text('Rating : ${snapshot.data![i]['Rating']}'),
                          trailing: Icon(Icons.arrow_outward_sharp),
                        ),
                      )),
                );
              }

              return Container(
                  child: ListView(
                children: allWidgets,
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(child: Text("Waiting.."));
            } else {
              return Text("Failed");
            }
          }),
    );
  }
}
