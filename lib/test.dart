import 'package:flutter/material.dart';

class MyAppOffest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Offset Example'),
        ),
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 50,
                  top: 50,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Positioned Widget',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  painter: MyCustomPainter(),
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    print('Tap Position: ${details.globalPosition}');
                  },
                ),
              ],
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

    canvas.drawCircle(const Offset(100, 150), 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
