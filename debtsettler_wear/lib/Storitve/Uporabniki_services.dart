import 'dart:convert';
import 'package:debtsettler_wear/Modeli/Uporabnik_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:debtsettler_wear/konstante.dart' as Constants;



Future<List<Uporabnik>> preberiUporabnike({required String gospodinjstvoKey}) async {
  Map<String, dynamic> body = jsonDecode(await rootBundle.loadString('assets/JSON/uporabniki.json'));
  List<dynamic> data = body[gospodinjstvoKey];

  List<Uporabnik> posts = data
      .map((dynamic item) => Uporabnik.fromJson(item),)
      .toList();

  return posts;
}

// API KLIC ZA PRIDOBITEV VSEH GOSPODINJSTEV PRIJAVLJENEGA UPORABNIKA
Future<List<Uporabnik>> getUporabnikiGospodinjstva({required String gospodinjstvoKey}) async {

  String token = 'Bearer $gospodinjstvoKey';

  var headers = {
    'Authorization': token,
  };

  var request = http.Request('GET', Uri.parse('${Constants.apiBaseURL}/gospodinjstvo/claniGospodinjstva'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    Map<String, dynamic> body = jsonDecode(await response.stream.bytesToString());
    List<dynamic> data = body["uporabniki"];

    List<Uporabnik> posts = data
        .map((dynamic item) => Uporabnik.fromJson(item),)
        .toList();

    return posts;

  } else {
    throw "Unable to retrieve posts because: ${response.reasonPhrase}";
  }

}