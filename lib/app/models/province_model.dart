class ProvinceModel {
  String provinceId;
  String province;

  ProvinceModel({required this.provinceId, required this.province});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
        provinceId: json["province_id"], province: json["province"]);
  }

  Map<String, dynamic> toJson() =>
      {"province_id": provinceId, "province": province};
}
