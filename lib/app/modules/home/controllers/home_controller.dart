import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajaongkir/app/data/constants.dart';
import 'package:rajaongkir/app/models/city_model.dart';
import 'package:rajaongkir/app/models/courier_result_model.dart';
import 'package:rajaongkir/app/models/province_model.dart';
import 'package:http/http.dart' as http;
import 'package:rajaongkir/app/models/service_courier.dart';

class HomeController extends GetxController {
  var selectedProvince = "".obs;
  var selectedCity = "".obs;
  var selectedDestinationProvince = "".obs;
  var selectedDestinationCity = "".obs;
  var selectedCourier = "".obs;
  var weight = 0.obs;

  var isSelected = false.obs;

  var service = CourierService().obs;

  late TextEditingController weightController;

  void setCourierService(String serviceCode, int cost, String estimationDay){
    service(CourierService(service: serviceCode, cost: cost, estimationDay: estimationDay));
  }

  Future<List<CostsModel>> calculateCost() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    final response = await http.post(url, headers: {
      "content-type": "application/x-www-form-urlencoded",
      "key": API_KEY
    }, body: {
      "origin": "${selectedCity.value}",
      "destination": "${selectedDestinationCity.value}",
      "weight": "${double.parse(weightController.text) * 1000}",
      "courier": "${selectedCourier.value}"
    });
    final jsonData = json.decode(response.body);
    final result = jsonData["rajaongkir"]["results"][0];
    CourierResultModel courierResult = CourierResultModel.fromJson(result);
    return courierResult.costs;
  }

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
