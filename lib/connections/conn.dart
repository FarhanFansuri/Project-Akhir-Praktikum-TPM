import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

class ConnectionUrl {
  final dio = Dio();
  List<dynamic>? data = [];

  Future<List?> getHttp() async {
    final response =
        await dio.get('https://project-tpm.netlify.app/api/hotels/info');
    if (response.statusCode == 200) {
      data = response.data;
      return data;
    } else {
      return data;
    }
  }
}
