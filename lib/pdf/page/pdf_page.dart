import 'package:flutter/material.dart';
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

final List<OrderItem> items = [];

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(MyAppPdf.title),
          centerTitle: true,
        ),
        body: Container(
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
                    final date = DateTime.now();
                    final dueDate = date.add(const Duration(days: 7));
                    final order = Order.order(
                      supplier: const Supplier(
                        name: 'Eng / Khaled Al-Husseini',
                        address: 'F&B Iraq - Country Manager',
                      ),
                      customer: const Customer(
                        name: 'Ahmed Mohamed.',
                        address: 'Iraq,Baghdad',
                      ),
                      info: OrderInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'Order description...',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items: items, // تمرير قائمة العناصر هنا
                    );
                    final pdfFile = await PdfOrderApi.generate(order);
                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
