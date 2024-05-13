import 'package:boluevared/helpers/media_query.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../helpers/constants.dart';
import '../../home_page_controller.dart';

class ZonesView extends StatelessWidget {
  const ZonesView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: Consumer<HomePageController>(
        builder: (BuildContext context, cnr, Widget? child) {
          return StreamBuilder(
            stream:
                _firestore.collection('zones').orderBy('zone_id').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              } else {
                return SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      String proId = document.id;
                      return Container(
                        color: proId == cnr.focusZone
                            ? const Color.fromARGB(255, 158, 158, 158)
                            : null,
                        child: Stack(
                          children: [
                            proId == cnr.focusZone
                                ? Positioned(
                                    right: context.screenWidth * 1,
                                    child: Icon(
                                      Icons.forward,
                                      size: context.screenSize * 0.03,
                                    ),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                              onTap: () async {
                                // await cnr.addOrder(proId);
                                await cnr.getZone(proId);
                              },
                              child: Container(
                                height: context.screenHeight * 3.8,
                                width: context.screenWidth * 15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: MyText(
                                    fontSize: context.screenSize * oneFont,
                                    fieldName: document['zone_name'],
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
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
    return Text(
      textDirection: TextDirection.ltr,
      fieldName,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
