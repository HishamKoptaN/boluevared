import 'package:flutter/material.dart';

class MyAppFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Responsive Interface'),
        ),
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double localeHeight = constraints.maxHeight;
                double localeWidth = constraints.maxWidth;
                return Stack(
                  children: [
                    Image.network(
                      width: 1280,
                      height: 720,
                      'https://firebasestorage.googleapis.com/v0/b/boulevared.appspot.com/o/boulevared.png?alt=media&token=84a2588e-7670-4d84-9649-80ca50ee935c',
                      fit: BoxFit.none,
                    ),
                    Positioned(
                      top: localeHeight / 2,
                      right: localeWidth / 2,
                      child: Image.asset(
                          height: localeHeight / 100,
                          width: localeWidth / 100,
                          'assets/map_pin.png'),
                    ),
                    Center(
                      child: Container(
                        width: localeWidth / 10,
                        height: localeHeight / 10,
                        color: Colors.black,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
