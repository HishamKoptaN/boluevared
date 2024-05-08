// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:real_estate_map/helpers/media_query.dart';
// import '../../helpers/constants.dart';
// import 'home_page/home_page_controller.dart';

// class ShopsSelectedWidget extends StatelessWidget {
//   const ShopsSelectedWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<HomePageController>(
//         builder: (BuildContext context, cnr, Widget? child) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: context.screenHeight * 25,
//                 width: context.screenWidth * 40,
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                   ),
//                   itemCount: cnr.selectedShopsList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final item = cnr.selectedShopsList[index];
//                     return Card(
//                       margin: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () async {
//                               await cnr.remove(item);
//                             },
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 'Number       : ${item['shop_number'].toString()}',
//                             color: Colors.black,
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 'Rent Value   : \$ ${item['rent_value'].toString()}',
//                             color: Colors.black,
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 'Height         : ${item['height'].toString()}',
//                             color: Colors.black,
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 'Width          : ${item['width'].toString()}',
//                             color: Colors.black,
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 'Total Area   : ${item['total_area'].toString()}',
//                             color: Colors.black,
//                           ),
//                           MyText(
//                             fontSize: context.screenSize * oneFont,
//                             fieldName:
//                                 item['is_booked'] ? 'Booked' : 'Not booked',
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Spacer(),
//               Center(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                       color: Colors.green),
//                   height: context.screenHeight * 7,
//                   width: context.screenWidth * 10,
//                   child: Center(
//                     child: MyText(
//                       fontSize: context.screenSize * twoFont,
//                       fieldName: 'Continue',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               Spacer(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class MyText extends StatelessWidget {
//   const MyText({
//     Key? key,
//     required this.fieldName,
//     required this.fontSize,
//     required this.color,
//   }) : super(key: key);
//   final double fontSize;
//   final String fieldName;
//   final Color color;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       fieldName,
//       style: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.bold,
//         color: color,
//       ),
//     );
//   }
// }
