import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajaongkir/app/models/courier_result_model.dart';
import 'package:rajaongkir/app/modules/home/controllers/home_controller.dart';

class HomeBottomSheet extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "Pilih jenis layanan ${controller
                    .selectedCourier.toUpperCase()}"),
          ),
          FutureBuilder(
            future: controller.calculateCost(),
            builder: (context,
                AsyncSnapshot<List<CostsModel>> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          controller.setCourierService(
                              data[index].service,
                              data[index].cost.value,
                              data[index].cost.etd);
                          Navigator.of(context).pop();
                        },
                        hoverColor: Colors.amber,
                        selectedTileColor: Colors.redAccent,
                        title: Text(
                            "${data[index]
                                .service} (${data[index]
                                .cost.etd} hari)"),
                        subtitle: Text(data[index]
                            .cost
                            .value
                            .toString()),
                      );
                    });
              }
              return Center(
                child: Text("Something went wrong"),
              );
            },
          )
        ],
      ),
    );
  }
}
