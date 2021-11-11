import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:rajaongkir/app/data/constants.dart';
import 'package:rajaongkir/app/models/province_model.dart';

void main() async {
  List<ProvinceModel> provinces = [];

  Future<void> addProvince() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
    final response = await http.get(url, headers: {"key": API_KEY});
    final jsonData = json.decode(response.body);
    final results = jsonData["rajaongkir"]["results"] as List<dynamic>;
    for (var i = 0; i < results.length; i++) {
      provinces.add(ProvinceModel.fromJson(results[i]));
    }
    for (var res in provinces) {
      print(res.province);
    }
  }

  await addProvince();
}
