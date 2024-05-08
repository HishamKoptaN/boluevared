import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'home_page_controller.dart';
import 'widgets/my_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<HomePageController>(context, listen: false)
                .takeScreenshot(context);
          },
          child: const Icon(Icons.camera_alt),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('boluevared'),
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Consumer<HomePageController>(
            builder: (context, model, child) {
              return Screenshot(
                // إضافة Screenshot للتقاط الصورة
                controller: model.screenshotController,
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/boulevared.appspot.com/o/boulevared.png?alt=media&token=84a2588e-7670-4d84-9649-80ca50ee935c',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      right: 350, // النسبة المئوية للموضع الأفقي
                      top: 100, // النسبة المئوية للموضع الرأسي
                      child: Icon(Icons.location_city),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
