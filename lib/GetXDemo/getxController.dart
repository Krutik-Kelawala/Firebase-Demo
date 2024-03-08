import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/GetXDemo/getXapiModel.dart';
import 'package:test_project/widgets/common_widgets.dart';

class GetDemoController extends GetxController {
  RxInt value = 0.obs;
  GetApiModel? getApiModel;

  RxBool isLoading = false.obs;

  void incrementValue() {
    value++;
  }

  void decrementValue() {
    value--;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  fetchData() async {
    final response = await http.get(
      Uri.parse("https://newsapi.org/v2/everything?q=apple&from=2024-01-21&to=2024-01-21&sortBy=popularity&apiKey=ea97c6bb67b040759084c3c20ea5e5cf"),
    );

    if (response.statusCode == 200) {
      isLoading(true);
      if (kDebugMode) {
        CommonWidgets.printFunction("response ${response.body}");
      }
      getApiModel = GetApiModel.fromJson(
        jsonDecode(response.body),
      );
      return getApiModel;
    } else {
      isLoading(false);
      if (kDebugMode) {
        CommonWidgets.printFunction("response status code ${response.statusCode}");
      }
      throw Error();
    }
    // return null;
  }
}
