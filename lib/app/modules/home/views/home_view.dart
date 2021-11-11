import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rajaongkir/app/models/city_model.dart';
import 'package:rajaongkir/app/models/province_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              _myDropDown<ProvinceModel>(
                hintText: "Pilih provinsi asal",
                labelText: "Provinsi asal",
                context: context,
                onChange: (ProvinceModel? model) => model == null
                    ? controller.selectedProvince.value = ""
                    : controller.selectedProvince.value = model.provinceId,
                onFind: (String? _) async => await controller.getProvinces(),
                itemAsString: (ProvinceModel? item) => item!.province,
                popupItemBuilder: (context, ProvinceModel item, isSelected) =>
                    _popUpItem(item.province),
              ),
              SizedBox(
                height: 20.0,
              ),
              _myDropDown<CityModel>(
                hintText: "Pilih kota/kabupaten asal",
                labelText: "Kota/Kabupaten asal",
                context: context,
                onChange: (CityModel? model) => model == null
                    ? controller.selectedCity.value = ""
                    : controller.selectedCity.value = model.cityId,
                onFind: (String? _) async =>
                    await controller.getCity(isOrigin: true),
                itemAsString: (CityModel? item) =>
                    "${item!.type} ${item.cityName}",
                popupItemBuilder: (context, CityModel item, isSelected) =>
                    _popUpItem("${item.type} ${item.cityName}"),
              ),
              SizedBox(
                height: 20.0,
              ),
              _myDropDown<ProvinceModel>(
                hintText: "Pilih provinsi tujuan",
                labelText: "Provinsi tujuan",
                context: context,
                onChange: (ProvinceModel? model) => model == null
                    ? controller.selectedDestinationProvince.value = ""
                    : controller.selectedDestinationProvince.value =
                        model.provinceId,
                onFind: (String? _) async => await controller.getProvinces(),
                itemAsString: (ProvinceModel? item) => item!.province,
                popupItemBuilder: (context, ProvinceModel item, isSelected) =>
                    _popUpItem(item.province),
              ),
              SizedBox(
                height: 20.0,
              ),
              _myDropDown<CityModel>(
                hintText: "Pilih kota/kabupaten tujuan",
                labelText: "Kota/Kabupaten tujuan",
                context: context,
                onChange: (CityModel? model) => model == null
                    ? controller.selectedDestinationCity.value = ""
                    : controller.selectedDestinationCity.value = model.cityId,
                onFind: (String? _) async =>
                    await controller.getCity(isOrigin: false),
                itemAsString: (CityModel? item) =>
                    "${item!.type} ${item.cityName}",
                popupItemBuilder: (context, CityModel item, isSelected) =>
                    _popUpItem("${item.type} ${item.cityName}"),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownSearch(
                maxHeight: 200,
                emptyBuilder: (_, __) => const SizedBox(),
                showClearButton: true,
                popupElevation: 0.0,
                items: ["jne", "pos", "tiki"],
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Pilih kurur",
                  labelText: "Kurir",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                ),
                onChanged: (String? value) =>
                    controller.selectedCourier.value = value!,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controller.weightController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    helperText: "Gunakan titik (.) sebagai koma",
                    suffix: Text("Kg"),
                    border: OutlineInputBorder(),
                    labelText: "Berat"),
              ),
              MaterialButton(
                onPressed: () async {
                  print(controller.selectedProvince.value);
                  print(controller.selectedCity.value);
                  print(controller.selectedDestinationProvince.value);
                  print(controller.selectedDestinationCity.value);
                  print("kurir : ${controller.selectedCourier}");
                  print(
                      "berat : ${int.parse(controller.weightController.text) * 100}");
                },
                child: Text("Press"),
              )
            ],
          )),
    );
  }

  DropdownSearch _myDropDown<T>(
      {required String hintText,
      required String labelText,
      required BuildContext context,
      void Function(T?)? onChange,
      Future<List<T>> Function(String?)? onFind,
      String Function(T?)? itemAsString,
      Widget Function(BuildContext, T, bool)? popupItemBuilder}) {
    return DropdownSearch<T>(
      emptyBuilder: (_, __) => const SizedBox(),
      showClearButton: true,
      onFind: onFind,
      popupElevation: 0.0,
      itemAsString: itemAsString,
      popupItemBuilder: popupItemBuilder,
      dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
      ),
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
          autofocus: true,
          decoration: InputDecoration(
              labelText: "Cari $labelText",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: UnderlineInputBorder())),
      onChanged: onChange,
    );
  }

  _popUpItem(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Text(label),
    );
  }
}
