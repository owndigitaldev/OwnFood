import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<http.Response> getRandom() async {
    try {
      return await http.get(
        _baseUrl + 'random.php',
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

  Future<http.Response> getListFilter({@required String by}) async {
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

  Future<http.Response> getDataFilter({
    @required String by,
    @required String data,
  }) async {
    try {
      return await http.get(
        _baseUrl + 'filter.php?' + by + '=' + data,
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

  Future<http.Response> search({@required String data}) async {
    try {
      return await http.get(
        _baseUrl + 'search.php?s=' + data,
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

  Future<http.Response> detail({@required String idMeal}) async {
    try {
      return await http.get(
        _baseUrl + 'lookup.php?i=' + idMeal,
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
