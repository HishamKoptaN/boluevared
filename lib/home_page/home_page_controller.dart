import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class HomePageController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String zone = 'null';
  String focusZone = 'null';
  String focusShop = 'null';
  String zoneDetails = 'null';
  String shopDetails = 'null';
  final List<Map<String, dynamic>> selectedShopsList = [];
  List<DocumentSnapshot> dataList = [];
  ScreenshotController screenshotController = ScreenshotController();
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
          'total_area': totalArea,
          'is_booked': isBooked,
        },
      );
      notifyListeners();
      return true;
    }
    return false;
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
            'total_area': width * height,
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

  void takeScreenshot(context) {
    screenshotController.capture(delay: const Duration(milliseconds: 10)).then(
      (capturedImage) async {
        ShowCapturedWidget(context, capturedImage!);
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
