import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:app/model/pemesanan_hotel.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  List<Widget> allWidgets = [];

  @override
  Widget build(BuildContext context) {
    dynamic getData() async {
      await Hive.initFlutter();
      if (!Hive.isAdapterRegistered(157)) {
        Hive.registerAdapter(PesananAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        // Register Hive Adapter
        Hive.registerAdapter(TimeOfDayAdapter());
      }
      var box = await Hive.openBox('hotels');

      if (box.containsKey('pesanan')) {
        print("ada");
      } else {
        print("gak ada");
      }
      if (box.get('pesanan') != null) {
        print("check");
        print(box.get('pesanan').runtimeType);
        for (var data in box.get('pesanan')) {
          print("bangsat");
          print(data);
        }
        return box.get('pesanan');
      } else {
        print("nor");
        var result = [];
        return result;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Riwayat"),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              print("data succesfully");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(child: Text("Loading..."));
              } else if (snapshot.connectionState == ConnectionState.done) {
                print("horeeee!");
                // ignore: avoid_print
                List dataList = snapshot.data as List;
                for (int x = 0; x < dataList.length; x++) {
                  allWidgets.add(Container(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ubah angka sesuai dengan radius yang diinginkan
                    ),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('${dataList[x].namaHotel}'),
                            subtitle: const Text('Pemesanan'),
                          ),
                        ],
                      ),
                    ),
                  ));
                }
                ;
                return Container(
                    child: ListView(
                  children: allWidgets,
                ));
              } else {
                return Text("null");
              }
            }));
  }
}
