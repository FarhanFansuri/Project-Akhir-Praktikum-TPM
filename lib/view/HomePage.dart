import 'dart:convert';
import 'package:app/view/Login.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/connections/conn.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    initial();
    fetchHotelsData();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> hotelsData = [];
  List<String> availableTags = [];
  String selectedTag = "view";
  List<Map<String, dynamic>> filteredHotels = [];

  Future<void> fetchHotelsData() async {
    final response =
    await http.get(
        Uri.parse('https://project-tpm.netlify.app/api/hotels/info'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        hotelsData = List<Map<String, dynamic>>.from(jsonData);
        filteredHotels = List<Map<String, dynamic>>.from(jsonData);
        availableTags = getAvailableTags(hotelsData);
      });
    } else {
      // Handle error case here
      print('Failed to fetch hotels data.');
    }
  }

  List<String> getAvailableTags(List<Map<String, dynamic>> hotels) {
    List<String> tags = [];
    for (var hotel in hotels) {
      if (hotel['Tags'] != null) {
        tags.addAll(hotel['Tags'].cast<String>());
      }
    }
    return tags.toSet().toList();
  }

  void filterHotels(String tag) {
    setState(() {
      selectedTag = tag;
      filteredHotels = hotelsData.where((hotel) {
        if (hotel['Tags'] != null) {
          return hotel['Tags'].contains(tag);
        }
        return false;
      }).toList();
    });
  }

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
      logindata.setBool('login', true);
      Navigator.pushNamed(context, '/Login');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels App'),
          automaticallyImplyLeading: false
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Welcome User',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Yogyakarta',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          StreamBuilder<DateTime>(
                            stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              final currentTime = snapshot.data!.add(Duration(hours: 7));
                              final formattedTime = DateFormat.Hms().format(currentTime);
                              return Text(
                                formattedTime,
                                style: TextStyle(fontSize: 24),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: DropdownButton<String>(
              value: selectedTag,
              hint: Text('Select a tag'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  filterHotels(newValue);
                }
              },
              items: availableTags.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(hotel['HotelName']),
                          content: Text(hotel['Description']),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/hotel.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              hotel['HotelName'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hotel['Description']),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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