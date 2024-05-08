import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_map/helpers/media_query.dart';
import '../../helpers/constants.dart';
import '../home_page_controller.dart';
import 'selected_shops.dart';
import 'zones/zones_view.dart';
import 'shops/shops_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Drawer(
        width: context.screenWidth * 40,
        backgroundColor: Colors.white,
        child: SizedBox(
          width: context.screenWidth * 40,
          height: context.screenHeight * 100,
          child: SingleChildScrollView(
            child: Consumer<HomePageController>(
              builder: (context, model, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.screenHeight * 4.2,
                          width: context.screenWidth * 15,
                          child: MyText(
                            fontSize: context.screenSize * twoFont,
                            fieldName: 'Zones',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 4.2,
                          width: context.screenWidth * 10,
                          child: MyText(
                            fontSize: context.screenSize * twoFont,
                            fieldName: 'Shops',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.screenHeight * 65,
                          width: context.screenWidth * 15,
                          child: const ZonesView(),
                        ),
                        SizedBox(
                          height: context.screenHeight * 65,
                          width: context.screenWidth * 15,
                          child: const shopsView(),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    SizedBox(
                      height: context.screenHeight * 5,
                      width: context.screenWidth * 15,
                      child: MyText(
                        fontSize: context.screenSize * twoFont,
                        fieldName: 'Shop Details',
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.screenHeight * 35,
                          width: context.screenWidth * 40,
                          child: const SelectedShops(),
                          // ShopDetails(),
                        ),
                      ],
                    ),
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

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.fieldName,
    required this.fontSize,
    required this.color,
  }) : super(key: key);

  final double fontSize;
  final String fieldName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textDirection: TextDirection.ltr,
        fieldName,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
