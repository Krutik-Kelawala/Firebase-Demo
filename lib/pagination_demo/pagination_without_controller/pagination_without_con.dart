import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class PaginationWithoutConDemo extends StatefulWidget {
  const PaginationWithoutConDemo({super.key});

  @override
  State<PaginationWithoutConDemo> createState() => _PaginationWithoutConDemoState();
}

class _PaginationWithoutConDemoState extends State<PaginationWithoutConDemo> {
  late PaginationModel paginationModelData;
  bool isLoading = false;
  int pageLimit = 10;
  int listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<PaginationModel> fetchData() async {
    final response = await http.get(Uri.parse(
      "https://dummyjson.com/products?limit=$pageLimit&skip=0",
    ));

    CommonWidgets.printFunction("page limit $pageLimit");
    setState(() {
      isLoading = false;
    });

    var result = PaginationModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      CommonWidgets.printFunction("response ${response.body}");
      paginationModelData = result;
      return result;
    } else {
      CommonWidgets.printFunction("error ${response.statusCode}");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagination Without Controller Demo",
          style: TextStyle(
            fontSize: CommonLogic.textSize * 0.02,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: !isLoading
          ? NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                  // User has reached the end of the list
                  // Load more data or trigger pagination in flutter
                  if (paginationModelData.products.length != paginationModelData.total) {
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        setState(() {
                          pageLimit = pageLimit + 10;
                        });
                        fetchData();
                      },
                    );
                  }
                }
                return false;
              },
              child: paginationModelData.products.isNotEmpty
                  ? ListView.builder(
                      itemCount: paginationModelData.products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        listIndex = index;
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: CommonLogic.textSize * 0.01,
                                horizontal: CommonLogic.textSize * 0.02,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: CommonLogic.textSize * 0.02,
                                horizontal: CommonLogic.textSize * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Center(
                                  child: Image.network(
                                    paginationModelData.products[index].thumbnail,
                                    height: CommonLogic.textSize * 0.2,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: CommonLogic.textSize * 0.16,
                                        width: double.infinity,
                                        color: Colors.yellow.withOpacity(0.3),
                                        child: Icon(
                                          Icons.error_outline,
                                          size: CommonLogic.textSize * 0.04,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: CommonLogic.textSize * 0.01,
                                ),
                                Text(
                                  "Title : ${paginationModelData.products[index].title}",
                                  style: TextStyle(
                                    fontSize: CommonLogic.textSize * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Description : ${paginationModelData.products[index].description}",
                                  style: TextStyle(
                                    fontSize: CommonLogic.textSize * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Price : ₹ ${paginationModelData.products[index].price}",
                                  style: TextStyle(fontSize: CommonLogic.textSize * 0.02, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ]),
                            ),
                            if (paginationModelData.products.length - 1 == index && paginationModelData.products.length != paginationModelData.total) ...[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                                child: const CircularProgressIndicator(strokeWidth: 3,),
                              )
                            ],
                            if (paginationModelData.products.length - 1 == index) ...[
                              SizedBox(
                                height: CommonLogic.textSize * 0.02,
                              )
                            ]
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                      "No data found",
                      style: TextStyle(
                        fontSize: CommonLogic.textSize * 0.02,
                        color: Colors.black,
                      ),
                    )),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

PaginationModel paginationModelFromJson(String str) => PaginationModel.fromJson(json.decode(str));

String paginationModelToJson(PaginationModel data) => json.encode(data.toJson());

class PaginationModel {
  List<Product> products;
  int total;
  int skip;
  int limit;

  PaginationModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  int id;
  String title;
  String description;
  int price;

  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "thumbnail": thumbnail,
      };
}
