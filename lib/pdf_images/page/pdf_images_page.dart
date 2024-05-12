import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../pdf/widget/button_widget.dart';
import '../../home_page/home_page_controller.dart';
import '../main.dart';
import '../pdf_images_api/pdf_images_api.dart';

class PdfImagesPage extends StatefulWidget {
  @override
  _PdfImagesPageState createState() => _PdfImagesPageState();
}

class _PdfImagesPageState extends State<PdfImagesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyAppPdfImages.title),
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
                    ButtonWidget(
                      text: 'Table PDF',
                      onClicked: () async {
                        final pdfFile = await PdfImagesApi.generateTable();

                        PdfImagesApi.openFile(pdfFile);
                      },
                    ),
                    const SizedBox(height: 24),
                    ButtonWidget(
                      text: 'Image PDF',
                      onClicked: () async {
                        final pdfFile = await PdfImagesApi.generateImage(
                            value.bluevaredScreenshot, value.pdfScreenshot);
                        PdfImagesApi.openFile(pdfFile);
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
