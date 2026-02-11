import 'package:fff_skin_tools/Provider/ads_provider.dart';
import 'package:fff_skin_tools/Provider/home_provider.dart';
import 'package:fff_skin_tools/Provider/onboarding_provider.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/helper/remote_config_service.dart';
import 'package:fff_skin_tools/helper/notification_service.dart';
import 'package:fff_skin_tools/screen/splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await RemoteConfigService.initialize();
  await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();

    // Global internet listener
    InternetConnectionChecker.createInstance().onStatusChange.listen((status) {
      setState(() {
        hasInternet = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: MyApp.analytics),
      ],
      debugShowCheckedModeBanner: false,
      title: 'FFFF Skin Pro - Diamond Unlock',
      theme: AppTheme.darkTheme,
      home: GlobalWrapper(
        child: const SplashScreen(),
      ),
    );
  }
}
