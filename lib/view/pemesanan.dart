import 'package:app/controller/pemesanan_controller.dart';
import 'package:app/view/list_hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../connections/conn.dart';
import '../model/pemesanan_hotel.dart';

class Pemesanan extends StatefulWidget {
  List<dynamic>? value;
  Pemesanan({super.key, required this.value});
  @override
  State<Pemesanan> createState() => _PemesananState(value: value);
}

class _PemesananState extends State<Pemesanan> {
  List<dynamic>? value;
  _PemesananState({this.value});
  List<Widget> allWidgets = [];
  Object? arguments;
  TimeOfDay selectedTimeCheckIn = TimeOfDay.now();
  TimeOfDay selectedTimeCheckOut = TimeOfDay.now();
  dynamic idPemesanan = (DateTime.now()).millisecondsSinceEpoch;
  DateTime datetimein = DateTime(2021, 12, 24, 3, 30);
  DateTime datetimeout = DateTime(2021, 12, 24, 3, 30);
  Future<DateTime?> pickDateIn() => showDatePicker(
      context: context,
      initialDate: datetimein,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030));
  Future<DateTime?> pickDateOut() => showDatePicker(
      context: context,
      initialDate: datetimeout,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          // backgroundColor: Color(0x44000000),
          elevation: 0,
          title: const Text("TAHAP PEMESANAN"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: SizedBox(
                  child: ListView(
                children: [
                  const SizedBox(height: 20.0),
                  const Center(
                      child: Text(
                    "Info Pemesanan",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.numbers),
                        title: Text('ID Pemesanan'),
                        subtitle: Text('${idPemesanan}'),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.apartment),
                        title: Text('Nama Hotel'),
                        subtitle: Text("${value?[0]}"),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.hotel),
                        title: Text('Kamar hotel'),
                        subtitle: Text('${value?[1]['Description']}'),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.hotel),
                        title: Text('Tipe Kamar'),
                        subtitle: Text('${value?[1]['Type']}'),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.input_rounded),
                        title: Text('Check in'),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${selectedTimeCheckIn.hour} : ${selectedTimeCheckIn.minute}'),
                              Text(
                                  '${datetimein.year.toString()}/${datetimein.month.toString()}/${datetimein.day.toString()} '),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        // code butuh perbaikan
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    selectedTimeCheckIn);

                                        if (timeOfDay != null) {
                                          setState(() {
                                            selectedTimeCheckIn = timeOfDay;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.access_time)),
                                  IconButton(
                                      onPressed: () async {
                                        var date = await pickDateIn();
                                        if (date == null) return;
                                        setState(() {
                                          datetimein = date;
                                        });
                                      },
                                      icon: Icon(Icons.date_range)),
                                ],
                              ),
                            ]),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.output_rounded),
                        title: Text('Check Out'),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${selectedTimeCheckOut.hour} : ${selectedTimeCheckOut.minute}'),
                              Text(
                                  '${datetimeout.year.toString()}/${datetimeout.month.toString()}/${datetimeout.day.toString()}'),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        // code butuh perbaikan
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    selectedTimeCheckOut);

                                        if (timeOfDay != null) {
                                          setState(() {
                                            selectedTimeCheckOut = timeOfDay;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.access_time)),
                                  IconButton(
                                      onPressed: () async {
                                        var date = await pickDateOut();
                                        if (date == null) return;
                                        setState(() {
                                          datetimeout = date;
                                        });
                                      },
                                      icon: Icon(Icons.date_range)),
                                ],
                              ),
                            ]),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.price_change),
                        title: Text('Total Biaya'),
                        subtitle: Text("${value?[1]['BaseRate']}"),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Pesanan sendData = Pesanan(
                              idPemesanan: idPemesanan,
                              namaHotel: value?[0],
                              kamarHotel: value?[1]['Description'],
                              tipeKamar: value?[1]['Type'],
                              waktuCheckIn: selectedTimeCheckIn,
                              waktuCheckOut: selectedTimeCheckOut,
                              hariCheckIn: datetimein,
                              hariCheckOut: datetimeout,
                              price: value?[1]['BaseRate']);
                          PemesananController.pesan(sendData);
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text('Pesanan Berhasil!'),
                                          const SizedBox(height: 15),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ListHotels()));
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(25.0),
                          width: 100,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 0, 118, 228),
                          ),
                          child: Center(
                              child: Text(
                            'Pesan',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: AutofillHints.addressCity,
                                color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  )
                ],
              )),
            )));
  }
}
