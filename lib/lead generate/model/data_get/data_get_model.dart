// To parse this JSON data, do
//
//     final dataGetModel = dataGetModelFromJson(jsonString);

import 'dart:convert';

List<DataGetModel> dataGetModelFromJson(String str) => List<DataGetModel>.from(json.decode(str).map((x) => DataGetModel.fromJson(x)));

String dataGetModelToJson(List<DataGetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataGetModel {
  String name;
  String interest;
  dynamic mobileNo;
  String designation;

  DataGetModel({
    required this.name,
    required this.interest,
    required this.mobileNo,
    required this.designation,
  });

  factory DataGetModel.fromJson(Map<String, dynamic> json) => DataGetModel(
        name: json["name"] ?? "",
        interest: json["interest"] ?? "",
        mobileNo: json["mobileNo"],
        designation: json["designation"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "interest": interest,
        "mobileNo": mobileNo,
        "designation": designation,
      };
}
