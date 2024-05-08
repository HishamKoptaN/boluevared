import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home_page/home_page_controller.dart';
import '../api/pdf_api.dart';
import '../api/pdf_order_api.dart';
import '../main.dart';
import '../model/customer.dart';
import '../model/oder.dart';
import '../model/supplier.dart';
import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final List<OrderItem> items = [];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(MyAppPdf.title),
          centerTitle: true,
        ),
        body: Consumer<HomePageController>(
          builder:
              (BuildContext context, HomePageController value, Widget? child) {
            return Container(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TitleWidget(
                      icon: Icons.picture_as_pdf,
                      text: 'Generate Order',
                    ),
                    const SizedBox(height: 48),
                    ButtonWidget(
                      text: 'Order PDF',
                      onClicked: () async {
                        value.converData();
                        final date = DateTime.now();
                        final dueDate = date.add(const Duration(days: 7));

                        final order = Order.order(
                            supplier: const Supplier(
                              name: 'Eng / Khaled Al-Husseini',
                              address: 'F&B Iraq - Country Manager',
                            ),
                            customer: const Customer(
                              name: 'Ahmed Mohamed.',
                              address: 'Iraq,Ba',
                            ),
                            // info: OrderInfo(
                            //   date: date,
                            //   dueDate: dueDate,
                            //   description: 'Order description...',
                            //   number: '${DateTime.now().year}-9999',
                            // ),
                            items:
                                //  value.orderItems

                                [
                              OrderItem(
                                shopNumber: 1,
                                width: 2,
                                height: 3,
                                totalShopArea: 4,
                                rentValue: 5,
                              )
                            ]);
                        final pdfFile = await PdfOrderApi.generate(order);
                        PdfApi.openFile(pdfFile);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
