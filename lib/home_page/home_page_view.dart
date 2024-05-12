import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_map/helpers/media_query.dart';
import 'package:screenshot/screenshot.dart';
import '../helpers/constants.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('boluevared'),
        ),
        drawer: const MyDrawer(),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Consumer<HomePageController>(
              builder: (context, cnr, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Screenshot(
                      controller: cnr.bluevaredScreenshotController,
                      child: Image.network(
                        width: context.screenWidth * 100,
                        height: context.screenHeight * 80,
                        'https://firebasestorage.googleapis.com/v0/b/boulevared.appspot.com/o/boulevared.png?alt=media&token=84a2588e-7670-4d84-9649-80ca50ee935c',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    cnr.selectedShopsList.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            width: context.screenWidth * 100,
                            height: context.screenHeight * 90,
                            child: Screenshot(
                              controller: cnr.pdfScreenshotController,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyContainer(
                                        item: 'Shop number',
                                        color: Colors.grey,
                                      ),
                                      MyContainer(
                                        item: 'Shop height',
                                        color: Colors.grey,
                                      ),
                                      MyContainer(
                                        item: 'Shop width',
                                        color: Colors.grey,
                                      ),
                                      MyContainer(
                                        item: 'Shop total area ',
                                        color: Colors.grey,
                                      ),
                                      MyContainer(
                                        item: 'Rent value',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 160),
                                    child: SizedBox(
                                      height: context.screenHeight * 20,
                                      child: ListView.builder(
                                        itemCount: cnr.selectedShopsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item =
                                              cnr.selectedShopsList[index];
                                          return Center(
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      MyContainer(
                                                        item:
                                                            item['shop_number']
                                                                .toString(),
                                                        color: Colors.white,
                                                      ),
                                                      MyContainer(
                                                        item: item['height']
                                                            .toString(),
                                                        color: Colors.white,
                                                      ),
                                                      MyContainer(
                                                        item: item['width']
                                                            .toString(),
                                                        color: Colors.white,
                                                      ),
                                                      MyContainer(
                                                        item: item[
                                                                'shop_total_area']
                                                            .toString(),
                                                        color: Colors.white,
                                                      ),
                                                      MyContainer(
                                                        item:
                                                            '${(item['rent_value'].toString())} \$',
                                                        color: Colors.white,
                                                      ),
                                                      // IconButton(
                                                      //   icon: const Icon(Icons.delete),
                                                      //   onPressed: () async {
                                                      //     await cnr.removeShopDetails(item);
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    endIndent:
                                                        context.screenWidth *
                                                            13,
                                                    thickness: 1,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * 100,
                                    height: context.screenHeight * 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //    Manager        //
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            SizedBox(
                                              width: context.screenWidth * 20,
                                              height: context.screenHeight * 30,
                                              child: Column(
                                                children: [
                                                  MyText(
                                                    fontWeight: FontWeight.bold,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    fieldName:
                                                        'Khalid Muhaisen',
                                                    fontSize:
                                                        context.screenSize *
                                                            oneFont,
                                                    color: Colors.black,
                                                  ),
                                                  MyText(
                                                    fontWeight: FontWeight.w500,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    fieldName:
                                                        'Baghdad Boulevard Manager',
                                                    fontSize:
                                                        context.screenSize *
                                                            oneFont,
                                                    color: Colors.black,
                                                  ),
                                                  const Spacer(
                                                    flex: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 2,
                                            ),
                                            SizedBox(
                                              width: context.screenWidth * 20,
                                              height: context.screenHeight * 30,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      MyText(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        fieldName:
                                                            'Total rent value',
                                                        fontSize:
                                                            context.screenSize *
                                                                oneFont,
                                                        color: Colors.black,
                                                      ),
                                                      const Spacer(
                                                        flex: 2,
                                                      ),
                                                      MyText(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        fieldName:
                                                            '${cnr.totalRentValue.toString()} \$',
                                                        fontSize:
                                                            context.screenSize *
                                                                oneFont,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 2,
                                                  ),
                                                  SizedBox(
                                                    width: context.screenWidth *
                                                        20,
                                                    height:
                                                        context.screenHeight *
                                                            5,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        MyText(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          fieldName:
                                                              'Total shops area',
                                                          fontSize: context
                                                                  .screenSize *
                                                              oneFont,
                                                          color: Colors.black,
                                                        ),
                                                        const Spacer(
                                                          flex: 2,
                                                        ),
                                                        MyText(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          fieldName: cnr
                                                              .totalShopsArea
                                                              .toString(),
                                                          fontSize: context
                                                                  .screenSize *
                                                              oneFont,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Provider.of<HomePageController>(context,
                                              listen: false)
                                          .takeScreenshot(context);
                                      cnr.generate();
                                    },
                                    child: Center(
                                      child: Container(
                                        height: context.screenHeight * 7,
                                        width: context.screenWidth * 10,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.green),
                                        child: Center(
                                          child: MyText(
                                            fontSize:
                                                context.screenSize * twoFont,
                                            fieldName: 'Continue',
                                            color: Colors.white,
                                            textDirection: TextDirection.ltr,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: context.screenHeight * 25,
                                  )
                                ],
                              ),
                            ),
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
    required this.textDirection,
    required this.fieldName,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
  }) : super(key: key);
  final TextDirection textDirection;
  final double fontSize;
  final String fieldName;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textDirection: textDirection,
        fieldName,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  String item;
  Color color;
  MyContainer({super.key, required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 3.8,
      width: context.screenWidth * 15,
      decoration: BoxDecoration(
        color: color,
        // border: Border.all(color: Colors.grey),
      ),
      child: MyText(
        fontSize: context.screenSize * oneFont,
        fieldName: item,
        color: Colors.black,
        textDirection: TextDirection.ltr,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
