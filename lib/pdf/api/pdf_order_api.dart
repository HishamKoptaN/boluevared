import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:screenshot/screenshot.dart';
import '../model/customer.dart';
import '../model/oder.dart';
import '../model/supplier.dart';
import '../utils.dart';
import 'pdf_api.dart';

class PdfOrderApi {
  ScreenshotController screenshotController = ScreenshotController();
  void takeScreenshot(context) {
    try {
      screenshotController
          .capture(delay: const Duration(milliseconds: 10))
          .then((capturedImage) async {
        // ShowCapturedWidget(context, capturedImage!);
      }).catchError(
        (onError) {
          print(onError);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<File> generate(Order order) async {
    final pdf = Document();

    final imageJpg = (await rootBundle.load('assets/images/boulevared.PNG'))
        .buffer
        .asUint8List();
    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: Image(MemoryImage(imageJpg), fit: BoxFit.contain),
          );
        } else {
          return Container();
        }
      },
    );
    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(order),
          // SizedBox(height: 3 * PdfPageFormat.cm),
          buildTitle(order),
          buildOrder(order),
          Divider(),
          buildTotal(order),
          Center(
            child: ClipRRect(
              horizontalRadius: 1,
              verticalRadius: 1,
              child: Image(
                MemoryImage(imageJpg),
                width: pageTheme.pageFormat.availableWidth / 2,
              ),
            ),
          ),
        ],
        footer: (context) => buildFooter(order),
      ),
    );

    return PdfApi.saveDocument(name: 'order.pdf', pdf: pdf);
  }

  static Widget buildHeader(Order order) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(order.supplier),
              // buildCustomerAddress(order.customer),

              // Container(
              //   height: 50,
              //   width: 50,
              //   child: BarcodeWidget(
              //     barcode: Barcode.qrCode(),
              // data: invoice.info.number,
              // ),
              // ),
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(order.customer),
              // buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(OrderInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      // 'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        titles.length,
        (index) {
          final title = titles[index];
          final value = data[index];

          return buildText(title: title, width: 200);
        },
      ),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildTitle(Order invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildOrder(Order order) {
    final headers = [
      'Shop Number',
      'Width',
      'Height',
      'Total shop area',
      'Start date',
      'Quantity',
    ];
    final data = order.items.map(
      (item) {
        return [
          item.shopNumber.toString(),
          item.width.toString(),
          item.height.toString(),
          item.totalShopArea.toString(),
          item.height.toString(),
          item.height.toString(),
        ];
      },
    ).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 40,
      tableWidth: TableWidth.max,
      columnWidths: {
        0: const FlexColumnWidth(2), 1: const FlexColumnWidth(2),
        2: const FlexColumnWidth(2), // تكبير عرض العمود الأول بمعامل 2
        3: const FlexColumnWidth(2),
        4: const FlexColumnWidth(2),
        5: const FlexColumnWidth(2),
        6: const FlexColumnWidth(2),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
        6: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Order invoice) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total area',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Net monthly rent',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Order invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
        ],
      ),
    );
  }
}
