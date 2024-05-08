import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_map/helpers/media_query.dart';
import '../../../helpers/constants.dart';
import '../../home_page_controller.dart';

class shopsView extends StatelessWidget {
  const shopsView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: Consumer<HomePageController>(
        builder: (BuildContext context, cnr, Widget? child) {
          return StreamBuilder(
            stream: _firestore
                .collection('zones')
                .doc(cnr.focusZone)
                .collection('shops')
                .orderBy('shop_number')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center();
              }
              return SizedBox(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    String proId = document.id;
                    return GestureDetector(
                      onTap: () async {
                        // await cnr.getShopDetails(cnr.zone, proId);
                      },
                      child: Row(
                        children: [
                          Container(
                            height: context.screenHeight * 3.8,
                            width: context.screenWidth * 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    color: proId == cnr.focusShop
                                        ? const Color.fromARGB(
                                            255, 158, 158, 158)
                                        : null,
                                    child: Row(
                                      children: [
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        SizedBox(
                                          height: context.screenHeight * 3.8,
                                          width: context.screenWidth * 5,
                                          child: MyText(
                                            fontSize:
                                                context.screenSize * oneFont,
                                            fieldName:
                                                '${document['shop_number'].toString()}  ',
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: cnr.chceckBoxOrno(
                                              document['shop_number']),
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                              if (value) {
                                                cnr.addShopTobilling(
                                                  document['shop_number'],
                                                  document['rent_value'],
                                                  document['height'],
                                                  document['width'],
                                                  document['total_area'],
                                                  document['is_booked'],
                                                );
                                              } else {
                                                cnr.removeShopDetails(
                                                  document['shop_number'],
                                                );
                                              }
                                            }
                                          },
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
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
