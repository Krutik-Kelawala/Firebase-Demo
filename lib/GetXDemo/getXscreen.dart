import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/GetXDemo/getXDetailScreen.dart';
import 'package:test_project/GetXDemo/getxController.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/utilities/custom_colors.dart';

class GetDemoScreen extends StatefulWidget {
  const GetDemoScreen({super.key});

  @override
  State<GetDemoScreen> createState() => _GetDemoScreenState();
}

class _GetDemoScreenState extends State<GetDemoScreen> {
  GetDemoController getDemoController = Get.put(GetDemoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("getx_list_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("get X Demo Screen")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Obx(() => !getDemoController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                      itemCount: getDemoController.getApiModel!.articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return GetxDetailScreen(index, getDemoController.getApiModel!.articles);
                              },
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(width: 1)),
                            child: Row(
                              children: [
                                Hero(
                                    tag: "detail$index",
                                    child: Image.network(getDemoController.getApiModel!.articles[index].urlToImage, errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 50,
                                        width: 50,
                                        color: CustomColors.bgColor,
                                      );
                                    }, height: 50, width: 50)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text(maxLines: 2, "Title : ${getDemoController.getApiModel!.articles[index].title}", style: const TextStyle(fontSize: 20))),
                              ],
                            ),
                          ),
                        );
                      }),
                )),
          Obx(
            () {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Update value : ${getDemoController.value}", style: const TextStyle(fontSize: 20)),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  getDemoController.incrementValue();
                },
                child: const Text("Increment Value"),
              ),
              ElevatedButton(
                onPressed: () {
                  getDemoController.decrementValue();
                },
                child: const Text("Decrement Value"),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.deleteAll(force: true);
  }
}
