import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<http.Response> getList({@required String by}) async {
    try {
      return await http.get(
        _baseUrl + 'list.php?' + by + '=list',
        headers: {
          'Accept': 'application/json',
        },
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error('TimeoutException: Request timeout.');
    } on SocketException catch (e) {
      print(e);
      return Future.error('SocketException: Periksa koneksi internet.');
    } on http.ClientException catch (e) {
      print(e);
      return Future.error('ClientException: Kesalahan pada klien.');
    }
  }
}
