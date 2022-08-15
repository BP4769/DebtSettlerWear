import 'dart:convert';
import 'package:debtsettler_wear/Modeli/Gospodinjstvo_model.dart';
import 'package:debtsettler_wear/Modeli/Uporabnik_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:debtsettler_wear/konstante.dart' as Constants;


Future<List<Gospodinjstvo>> preberiGospodinjstva() async {
  Map<String, dynamic> body = jsonDecode(await rootBundle.loadString('assets/JSON/gospodinjstva.json'));
  List<dynamic> data = body["tokens"];

  List<Gospodinjstvo> posts = data
      .map((dynamic item) => Gospodinjstvo.fromJson(item),)
      .toList();

  return posts;
}


// API KLIC ZA PRIDOBITEV VSEH GOSPODINJSTEV PRIJAVLJENEGA UPORABNIKA
Future<List<Gospodinjstvo>> getGospodinjstva() async {

  var headers = {
    'Authorization': 'Bearer ${Constants.zeton}'
  };
  var request = http.Request('GET', Uri.parse('${Constants.apiBaseURL}/gospodinjstvo/tokeniUporabnikGospodinjstev'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    Map<String, dynamic> body = jsonDecode(await response.stream.bytesToString());
    List<dynamic> data = body["tokens"];

    List<Gospodinjstvo> posts = data
        .map((dynamic item) => Gospodinjstvo.fromJson(item),)
        .toList();

    return posts;

  } else {
    throw "Unable to retrieve posts because: ${response.reasonPhrase}";
  }

}