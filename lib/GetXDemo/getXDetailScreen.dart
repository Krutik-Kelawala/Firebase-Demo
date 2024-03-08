import 'package:flutter/material.dart';
import 'package:test_project/GetXDemo/getXapiModel.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/utilities/custom_colors.dart';

class GetxDetailScreen extends StatefulWidget {
  final int index;
  final List<Article> articles;

  const GetxDetailScreen(this.index, this.articles, {super.key});

  @override
  State<GetxDetailScreen> createState() => _GetxDetailScreenState();
}

class _GetxDetailScreenState extends State<GetxDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("getx_detail_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Detail Screen")),
      body: Column(children: [
        Hero(
            tag: "detail${widget.index}",
            child: Image.network(widget.articles[widget.index].urlToImage, errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 100,
                width: 100,
                color: CustomColors.bgColor,
              );
            }, height: 100, width: 100)),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Text("Title : ${widget.articles[widget.index].title}", style: const TextStyle(fontSize: 20)),
        ),
      ]),
    );
  }
}
