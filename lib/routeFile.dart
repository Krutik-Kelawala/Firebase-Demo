import 'package:flutter/material.dart';
import 'package:test_project/e-commerce%20app/splash_screen/splash.dart';
import 'package:test_project/myHomePage.dart';

const String homePage = '/';
const String eCommerceProject = 'e_commerce_project';

Route<dynamic> routeController(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => MyHome_Page());

    // TODO pass single or multiple data another screen with using route method
    // case animationFirstScreen:
    // return MaterialPageRoute(builder: (context) => const AnimationFirstScreen());
    // case animationDetailScreen:
    //   List<dynamic>? argsParam = settings.arguments as List?;
    //   return MaterialPageRoute(builder: (context) => AnimationDetailScreen(index: argsParam![0]));

    case eCommerceProject:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    default:
      return MaterialPageRoute(builder: (context) => MyHome_Page());
  }
}
