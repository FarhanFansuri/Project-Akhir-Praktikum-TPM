import 'package:app/connections/conn.dart';
import 'package:app/view/pemesanan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Details extends StatefulWidget {
  dynamic value;
  Details({super.key, required this.value});

  @override
  State<Details> createState() => _DetailsState(value: value);
}

class _DetailsState extends State<Details> {
  dynamic value;
  _DetailsState({required this.value});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text("LIST KAMAR HOTEL"),
      ),
      body: FutureBuilder(
        future: ConnectionUrl().getHttp(),
        builder: (context, snapshot) {
          List<Widget> allList = [];
          if (snapshot.connectionState == ConnectionState.done) {
            dynamic data =
                snapshot.data?.where((element) => element['HotelId'] == value);
            for (var item in data) {
              for (int x = 0; x < item['Rooms'].length; x++) {
                allList.add(
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Pemesanan(
                                value: [item['HotelName'], item['Rooms'][x]])));
                      },
                      child: Container(
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.hotel)),
                          title: Text('${item['Rooms'][x]['Type']}'),
                          subtitle: Text('${item['Rooms'][x]['Description']}'),
                          trailing: Icon(Icons.add_home_work_sharp),
                        ),
                      )),
                );
              }
            }
            return Container(
              child: ListView(
                children: allList,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Waiting ...");
          } else {
            return Text("Failed");
          }
        },
      ),
    );
  }
}
