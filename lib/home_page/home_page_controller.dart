import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../pdf/model/oder.dart';
import '../pdf_images/pdf_images_api/pdf_images_api.dart';

class HomePageController extends ChangeNotifier {
  List retailD = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
  ];
  List foodCourt = [
    1,
    2,
  ];

  List entertainment = [
    1,
    2,
  ];

  List banks = [
    1,
    2,
  ];
  //    Home   Variables        //
  ScreenshotController bluevaredScreenshotController = ScreenshotController();
  ScreenshotController pdfScreenshotController = ScreenshotController();

  late Uint8List bluevaredScreenshot;
  late Uint8List pdfScreenshot;
  //    Zones   Variables        //
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String zone = 'null';
  String focusZone = 'null';
  String focusShop = 'null';
  String zoneDetails = 'null';
  String shopDetails = 'null';

//    Zones   Variables        //

  List luxuryZone = [3, 4, 5, 6, 7, 8, 9];
  final List<Map<String, dynamic>> selectedShopsList = [];
  List<OrderItem> orderItems = [];
  List<DocumentSnapshot> dataList = [];
  List<int> selected = [1];
  //    Pdf   Variables        //

  int totalRentValue = 0;
  int totalShopsArea = 0;
//    Zones   Methods        //

  Future<void> getZone(String areaId) async {
    focusShop = 'null';
    zoneDetails = 'null';
    shopDetails = 'null';
    try {
      focusZone = areaId;
      zone = areaId;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

//    Shops   Methods        //
  bool chceckBoxOrno(int shopId) {
    return selectedShopsList.any((element) => element['shop_number'] == shopId);
  }

  bool addShopTobilling(
    int shopNumber,
    int rentValue,
    int height,
    int width,
    int totalArea,
    bool isBooked,
  ) {
    if (!selectedShopsList
        .any((element) => element['shop_number'] == shopNumber)) {
      selectedShopsList.add(
        {
          'shop_number': shopNumber,
          'rent_value': rentValue,
          'height': height,
          'width': width,
          'shop_total_area': totalArea,
          'is_booked': isBooked,
        },
      );
      totalRentValue += rentValue;
      totalShopsArea += totalArea;
      notifyListeners();
      return true;
    }
    return false;
  }

  sumMinceTotal(int rentValue, int totalShopsRentValue) {
    totalShopsRentValue -= rentValue;
    totalShopsArea -= totalShopsRentValue;
  }
//    Selected  Shops   Methods        //

  removeShopDetails(item) {
    selectedShopsList.removeWhere(
        (element) => element['shop_number'] == item['shop_number']);

    notifyListeners();
  }

//                    //

  bool isSumOdd(int num1, int num2) {
    int sum = num1 + num2;
    return sum % 2 != 0;
  }

  Future<void> addOrder(String prdouctId) async {
    for (var i = 1; i < 11; i++) {
      int width = 45 + i;
      int height = 20 + i;
      bool isBooked = isSumOdd(width, height);
      try {
        await firestore
            .collection('zones')
            .doc(prdouctId)
            .collection('shops')
            .doc(i.toString())
            .set(
          {
            'shop_number': i,
            'rent_value': width + height + 300,
            'height': width,
            'width': height,
            'shop_total_area': width * height,
            'is_booked': isBooked,
          },
        );
      } catch (error) {
        if (kDebugMode) {
          print('حدث خطأ: $error');
        }
      }
    }
  }

  void takeScreenshot(context) async {
    await bluevaredScreenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then(
      (capturedImage) async {
        bluevaredScreenshot = capturedImage!;
      },
    ).catchError(
      (onError) {
        print(onError);
      },
    );
    await pdfScreenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then(
      (capturedImage) async {
        pdfScreenshot = capturedImage!;
      },
    ).catchError(
      (onError) {
        print(onError);
      },
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  void generate() async {
    final pdfFile =
        await PdfImagesApi.generateImage(bluevaredScreenshot, pdfScreenshot);
    PdfImagesApi.openFile(pdfFile);
  }

  void converData() {
    orderItems = selectedShopsList.map(
      (map) {
        return OrderItem(
          shopNumber: map['shop_number'] ?? '',
          width: map['width'] ?? 0,
          height: map['height'] ?? 0,
          totalShopArea: map['total_shop_area'] ?? 0,
          rentValue: map['rent_value'] ?? 0.0,
        );
      },
    ).toList();
  }
  // Future<void> getShopDetails(String zoneId, String shopId) async {
  //   focusShop = shopId;
  //   try {
  //     zoneDetails = zoneId;
  //     shopDetails = shopId;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void removeShopFromBilling(String shopNumber) {
  //   selectedShopsList
  //       .removeWhere((element) => element['shop_number'] == shopNumber);
  //   notifyListeners();
  // }

  // Future<List<DocumentSnapshot>> fetchShopData(
  //     String zone, String shopId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   DocumentSnapshot doc = await firestore
  //       .collection('zones')
  //       .doc(zone)
  //       .collection('shops')
  //       .doc(shopId)
  //       .get();
  //   dataList.add(doc);
  //   return dataList;
  // }
}
