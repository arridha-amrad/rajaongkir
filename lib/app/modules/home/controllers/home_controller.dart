import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajaongkir/app/data/constants.dart';
import 'package:rajaongkir/app/models/city_model.dart';
import 'package:rajaongkir/app/models/province_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var selectedProvince = "".obs;
  var selectedCity = "".obs;
  var selectedDestinationProvince = "".obs;
  var selectedDestinationCity = "".obs;
  var selectedCourier = "".obs;
  var weight = 0.obs;

  late TextEditingController weightController;

  Future<List<ProvinceModel>> getProvinces() async {
    List<ProvinceModel> provinces = [];
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
    final response = await http.get(url, headers: {"key": API_KEY});
    final jsonData = json.decode(response.body);
    final results = jsonData["rajaongkir"]["results"] as List<dynamic>;
    for (var i = 0; i < results.length; i++) {
      final newProvince = ProvinceModel.fromJson(results[i]);
      provinces.add(newProvince);
    }
    return provinces;
  }

  Future<List<CityModel>> getCity({required bool isOrigin}) async {
    List<CityModel> cities = [];
    final query = isOrigin ? selectedProvince : selectedDestinationProvince;
    Uri url =
        Uri.parse("https://api.rajaongkir.com/starter/city?province=$query");
    final response = await http.get(url, headers: {"key": API_KEY});
    final jsonData = json.decode(response.body);
    final results = jsonData["rajaongkir"]["results"] as List<dynamic>;
    // print("results : $results");
    for (var i = 0; i < results.length; i++) {
      final city = CityModel.fromJson(results[i]);
      cities.add(city);
    }
    return cities;
  }

  @override
  void onInit() {
    weightController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
}
