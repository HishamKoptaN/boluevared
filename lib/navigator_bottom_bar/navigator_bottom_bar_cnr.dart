import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_page/home_page_view.dart';
import '../pdf_images/page/pdf_images_page.dart';
import '../take_screenshot.dart';

class NavigatorBottomBarCnr extends GetxController {
  final List<Widget> pages = [
    PdfImagesPage(),
    const MyHomePage(),
    MyAppScreenShot(),
  ];
  int currentIndex = 0;
  void setCurrentIndex(int index) async {
    switch (index) {
      case 0:
      case 1:
      case 2:
    }
    currentIndex = index;
    update();
  }
}
