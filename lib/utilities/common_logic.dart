import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

class CommonLogic {
  static late double height;
  static late double width;
  static late num textSize;

  // TODO get devices height width & responsive text size

  static void initiateHeightWidth(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    textSize = pow((height * height) + (width * width), 1 / 2);
  }

  // TODO use for analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  static firebaseEventTrack(String screenName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: screenName,
      parameters: {
        "content_type": "screen tracking",
      },
    );
  }
}
