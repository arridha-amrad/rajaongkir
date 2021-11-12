class CourierResultModel {
  String code;
  String name;
  List<CostsModel> costs;

  CourierResultModel(
      {required this.code, required this.name, required this.costs});

  factory CourierResultModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonCosts = json["costs"];
    List<CostsModel> costResults = [];
    for (var i = 0; i < jsonCosts.length; i++) {
      costResults.add(CostsModel.fromJson(jsonCosts[i]));
    }
    return CourierResultModel(
        code: json["code"], name: json["name"], costs: costResults);
  }
}

class CostsModel {
  String service;
  String description;
  Cost cost;

  CostsModel({
    required this.service,
    required this.cost,
    required this.description,
  });

  factory CostsModel.fromJson(Map<String, dynamic> json) {
    final jsonCost = json["cost"][0];
    final Cost costModel = Cost.fromJson(jsonCost);
    return CostsModel(
        service: json["service"],
        description: json["description"],
        cost: costModel);
  }

  @override
  String toString() {
    return "service: $service, description: $description, cost: $cost";
  }
}

class Cost {
  int value;
  String etd;
  String? note;

  Cost({required this.value, required this.etd, this.note});

  factory Cost.fromJson(Map<String, dynamic> json) {
    return Cost(value: json["value"], etd: json["etd"], note: json["note"]);
  }

  @override
  String toString() {
    return "value: $value, etd: $etd hari, note: $note";
  }
}
