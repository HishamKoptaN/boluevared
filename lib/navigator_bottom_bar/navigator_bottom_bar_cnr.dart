// ignore_for_file: unused_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_page/home_page_view.dart';
import '../pdf/main.dart';
import '../pdf/page/pdf_page.dart';
import '../temporary/pdf_images/main.dart';
import '../test.dart';
import '../test_two.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class NavigatorBottomBarCnr extends GetxController {
  final List<Widget> pages = [
    PdfPage(),
    MyAppScreenShot(),
    MyHomePage(),
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
