import 'dart:async';

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_project/firebase_options.dart';
import 'package:test_project/myHomePage.dart';
import 'package:test_project/routeFile.dart' as router;
import 'package:test_project/widgets/common_widgets.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  CommonWidgets.printFunction("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  CommonWidgets.printFunction("notification setting ${settings.authorizationStatus}");

  FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null) {
      CommonWidgets.printFunction("message data ${value.data}");
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    CommonWidgets.printFunction('onMessage Got a message whilst in the foreground!');
    CommonWidgets.printFunction('Message data: ${message.data}');

    if (message.notification != null) {
      CommonWidgets.printFunction('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    CommonWidgets.printFunction('onMessageOpenedApp');
    CommonWidgets.printFunction('Message data: ${message.data}');

    if (message.notification != null) {
      CommonWidgets.printFunction('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseInstallations installations = FirebaseInstallations.instance;

  FirebasePerformance performance = FirebasePerformance.instance;
  await performance.setPerformanceCollectionEnabled(true);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  /* // Detect the OS
  CommonWidgets.printFunction("os name ${Platform.operatingSystem}");

  // The OS version
  CommonWidgets.printFunction("version name ${Platform.operatingSystemVersion}");*/

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FirebasePerformance performance = FirebasePerformance.instance;

  @override
  void initState() {
    // TODO: implement initState

// Custom data collection is, by default, enabled
//     getPerformanceApp();
    super.initState();

    Timer(
      const Duration(minutes: 1),
      () async {
        CommonWidgets.printFunction("inside timer");
        // await FirebaseAuth.instance.signOut();
      },
    );
  }

  getPerformanceApp() async {
// Set data collection to `false`
//     await performance.setPerformanceCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
          // showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          onGenerateRoute: router.routeController,
          initialRoute: router.homePage,
          theme: ThemeData(useMaterial3: true),
          home: MyHome_Page()
          // home: const SplashScreen(),
          ),
    );
  }
}
