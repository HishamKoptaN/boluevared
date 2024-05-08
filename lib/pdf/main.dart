import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page/pdf_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyAppPdf());
}

class MyAppPdf extends StatelessWidget {
  static const String title = 'Order';

  const MyAppPdf({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: PdfPage(),
      );
}
