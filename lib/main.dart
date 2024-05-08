// ignore_for_file: unused_import

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home_page/home_page_controller.dart';
import 'home_page/home_page_view.dart';
import 'navigator_bottom_bar/navigator_bottom_bar_view.dart';
import 'test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {} catch (e, st) {
    print(e);
    print(st);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomePageController()),
          ],
          child: MyHomePage(),
          // const NavigateBarScreen(),
        ),
      ),
    );
  }
}
