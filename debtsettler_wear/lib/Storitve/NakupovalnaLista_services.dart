
import 'dart:convert';
import 'package:debtsettler_wear/Modeli/Izdelek_model.dart';
import 'package:debtsettler_wear/Modeli/Uporabnik_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:debtsettler_wear/konstante.dart' as Constants;


Future<List<Izdelek>> preberiIzdelke({required String gospodinjstvoKey}) async {
  Map<String, dynamic> body = jsonDecode(await rootBundle.loadString('assets/JSON/nakupovalnaLista.json'));
  List<dynamic> data = body[gospodinjstvoKey];

  List<Izdelek> posts = data
      .map((dynamic item) => Izdelek.fromJson(item), )
      .toList();

  return posts;

}

// API KLIC ZA PRIDOBITEV VSEH GOSPODINJSTEV PRIJAVLJENEGA UPORABNIKA
Future<List<Izdelek>> getIzdelki({required String gospodinjstvoKey}) async {

  String token = 'Bearer $gospodinjstvoKey';

  var headers = {
    'Authorization': token,
  };

  var request = http.Request('GET', Uri.parse('${Constants.apiBaseURL}/seznam/gospodinjstvo'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    List<dynamic> data = jsonDecode(await response.stream.bytesToString());

    List<Izdelek> posts = data
        .map((dynamic item) => Izdelek.fromJson(item), )
        .toList();

    return posts;

  } else {
    throw "Unable to retrieve posts because: ${response.reasonPhrase}";
  }

}

// API KLIC ZA IZBRIS IZDELKOV
Future<bool> izbrisiIzdelke(List<Izdelek> izdelki, String gospodinjstvoKey) async {

  String token = 'Bearer $gospodinjstvoKey';

  var headers = {
    'Authorization': token,
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // ZBIRANJE ID-jev IZDELKOV ZA IZBRIS
  List<String> idList = izdelki.map((izdelek) => izdelek.izdelekId).toList();

  var request = http.Request('DELETE', Uri.parse('${Constants.apiBaseURL}/seznam'));
  request.bodyFields = {
    'idArtikla': idList.join(","),
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    //print(await response.stream.bytesToString());
    return true;
  }
  else {
    //print(response.reasonPhrase);
    return false;
  }
}