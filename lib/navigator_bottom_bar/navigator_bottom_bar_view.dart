// ignore_for_file: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_map/helpers/media_query.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../helpers/constants.dart';
import '../../test.dart';
import '../home_page/home_page_controller.dart';
import 'navigator_bottom_bar_cnr.dart';

class NavigateBarScreen extends StatefulWidget {
  const NavigateBarScreen({super.key});
  @override
  State<NavigateBarScreen> createState() => _HomePageState();
}

class _HomePageState extends State<NavigateBarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<NavigatorBottomBarCnr>(
        init: NavigatorBottomBarCnr(),
        builder: (cnr) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<HomePageController>(context, listen: false)
                    .takeScreenshot(context);
              },
              child: const Icon(Icons.camera_alt),
            ),
            appBar: AppBar(
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromRadius(1.0),
                child: Container(
                  color: Colors.grey,
                  height: 1.0,
                ),
              ),
              elevation: 0,
            ),
            resizeToAvoidBottomInset: true,
            body: SizedBox(child: cnr.pages[cnr.currentIndex]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: EdgeInsets.all(context.screenSize * 0.05),
              child: SalomonBottomBar(
                curve: Curves.slowMiddle,
                currentIndex: cnr.currentIndex,
                backgroundColor: Colors.white60,
                onTap: (int index) async {
                  cnr.setCurrentIndex(index);
                },
                items: [
                  SalomonBottomBarItem(
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.favorite,
                        size: context.screenSize * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "المفضله",
                      style:
                          TextStyle(fontSize: context.screenSize * threeFont),
                    ),
                  ),
                  SalomonBottomBarItem(
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        size: context.screenSize * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "سلة الطلبات",
                      style:
                          TextStyle(fontSize: context.screenSize * threeFont),
                    ),
                  ),
                  SalomonBottomBarItem(
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.category_rounded,
                        size: context.screenSize * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "الفئات",
                      style:
                          TextStyle(fontSize: context.screenSize * threeFont),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
