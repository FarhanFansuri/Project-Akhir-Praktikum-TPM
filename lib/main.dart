import 'package:app/view/HomePage.dart';
import 'package:app/view/Login.dart';
import 'package:app/view/Riwayat.dart';
import 'package:app/view/list_hotels.dart';
import 'package:flutter/material.dart';
import 'connections/conn.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: Login(),
    routes: {
      '/HomePage' : (context) => const HomePage(),
      '/List' : (context) => const ListHotels(),
      '/Riwayat' : (context) => const Riwayat(),
      '/Login' : (context) => const Login(),


    },
  ));
}
