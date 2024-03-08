import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_project/GetXDemo/getXscreen.dart';
import 'package:test_project/lead%20generate/screen/data_list.dart';
import 'package:test_project/lead%20generate/screen/form_screen/form_screen.dart';
import 'package:test_project/pagination_demo/pagination_with_controller/pagination_with_con.dart';
import 'package:test_project/pagination_demo/pagination_without_controller/pagination_without_con.dart';
import 'package:test_project/routeFile.dart' as router;
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class MyHome_Page extends StatefulWidget {
  @override
  State<MyHome_Page> createState() => _MyHome_PageState();
}

class _MyHome_PageState extends State<MyHome_Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserToken();
    foregroundService();

    subscribeTopic();
  }

  Future<void> subscribeTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic("Register");
  }

  Future<void> getUserToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      CommonWidgets.printFunction("fcm token : $fcmToken");
    }
  }

  foregroundService() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      CommonWidgets.printFunction('Got a message whilst in the foreground!');
      CommonWidgets.printFunction('Message data: ${message.data}');

      if (message.notification != null) {
        CommonWidgets.printFunction('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void instanceId() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
        // appBar: CommonWidgets.commonAppBar("My Home Page"),
        appBar: AppBar(title: const Text("My Home Page"), actions: [
          InkWell(
              onTap: () async {
                await FirebaseMessaging.instance.unsubscribeFromTopic("Register");
              },
              child: const Tooltip(
                message: "Unsubscribe from FCM topic",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Icon(Icons.unsubscribe),
                ),
              ))
        ]),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  // TPStreamPlayer(assetId: "7crsS6xxNrF", accessToken: "0ac0a750-b647-4b13-985f-d967caa3383f"),
                  const Text('Test project for routes and navigation', textAlign: TextAlign.center),
                  ElevatedButton(
                    onPressed: () => throw Exception(),
                    child: const Text("Throw Test Exception"),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const GetDemoScreen();
                            }));
                          },
                          child: const Text("GetX Demo"))),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, router.eCommerceProject);
                          },
                          child: const Text("E - Commerce Project Demo"))),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const FormScreen();
                            }));
                          },
                          child: const Text("Data Send to Excel"))),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const DataListScreen();
                            }));
                          },
                          child: const Text("Data Get From Excel"))),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const PaginationWithControllerDemo();
                            }));
                          },
                          child: const Text("Pagination With Controller"))),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const PaginationWithoutConDemo();
                            }));
                          },
                          child: const Text("Pagination Without Controller"))),
                ]),
              )),
        ));
  }
}
