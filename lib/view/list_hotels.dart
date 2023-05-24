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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Perform the desired navigation based on the selected index
    if (_selectedIndex == 0) {
      Navigator.pushNamed(context, '/HomePage');
    } else if (_selectedIndex == 1) {
      Navigator.pushNamed(context, '/List');
    } else if (_selectedIndex == 2) {
      Navigator.pushNamed(context, '/Riwayat');
    } else if (_selectedIndex == 3) {
      Navigator.pushNamed(context, '/Login');
    }
  }

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_rounded, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Buy Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.black),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.black),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
