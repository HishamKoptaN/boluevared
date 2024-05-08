import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_map/helpers/media_query.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Provider.of<HomePageController>(context, listen: false)
          //         .takeScreenshot(context);
          //   },
          //   child: const Icon(Icons.camera_alt),
          // ),
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
                  controller: model.screenshotController,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          final RenderBox renderBox =
                              context.findRenderObject() as RenderBox;
                          final Offset localPosition =
                              renderBox.globalToLocal(details.globalPosition);
                          print('Tap position: $localPosition');
                        },
                        child: Center(
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/boulevared.appspot.com/o/boulevared.png?alt=media&token=84a2588e-7670-4d84-9649-80ca50ee935c',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: MediaQuery.of(context).size.height / 30,
                      //   bottom: MediaQuery.of(context).size.height / 30,
                      //   right: MediaQuery.of(context).size.width / 30,
                      //   left: MediaQuery.of(context).size.width / 30,
                      //   child: ImageIcon(
                      //     const AssetImage(
                      //       'assets/map_pin.png',
                      //     ),
                      //     size: 20,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(20, 150), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
