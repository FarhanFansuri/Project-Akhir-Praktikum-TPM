import 'package:app/view/list_hotels.dart';
import 'package:flutter/material.dart';
import 'connections/conn.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListHotels(),
  ));
}
