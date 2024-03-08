import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_project/lead%20generate/model/data_get/data_get_model.dart';
import 'package:test_project/widgets/common_widgets.dart';

class HttpRepository {
  Future sendExcelData(
    String userName,
    String userInterest,
    String userMobileNo,
    String userDesignation,
  ) async {
    CommonWidgets.printFunction("params $userName $userMobileNo $userInterest $userDesignation");
    final httpResponse = await http.post(
      Uri.parse("https://script.google.com/macros/s/AKfycbxitHHDAJ08kH1JTXnDRU6Nm9VbfUfgXy94ri4ftkXtRdEZ5dfyecocz3cYhya6LVQjyQ/exec"),
      body: {
        "name": userName,
        "interest": userInterest,
        "mobileNo": userMobileNo,
        "designation": userDesignation,
      },
    );

    // var result = jsonDecode(response.body);
    //   CommonWidgets.printFunction("Response: ${SendLeadModel.fromJson(JsonDecoder().convert(response.body))}");
    // if (response.statusCode == 200) {
    //   return SendLeadModel.fromJson(JsonDecoder().convert(response.body));
    // } else {
    //   CommonWidgets.printFunction("Error ${response.statusCode}");
    // }
    // throw UnimplementedError();
    return httpResponse;
  }

  Future<List<DataGetModel>> dataGetFromSheet() async {
    final getDataResponse = await http.get(
      Uri.parse("https://script.google.com/macros/s/AKfycbySST1DI3VyKpVw4yoLEp08tOXFu_qRTNJ9chmUpW_crIQqei58ZrUMtgHPZTYt4ntI9w/exec"),
    );
    if (getDataResponse.statusCode == 200) {
      final List result = jsonDecode(getDataResponse.body);
      CommonWidgets.printFunction("result $result");
      return result.map((e) => DataGetModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
