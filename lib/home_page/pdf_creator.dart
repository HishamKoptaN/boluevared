import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/foundation.dart';

class PdfGenerator {
  static createPdf() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File(path + "my_pdf.pdf");
    Document pdf = Document();
    pdf.addPage(createPage());
    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  static Page createPage() {
    return Page(
      build: (context) {
        return Center(
          child: Column(
            children: [
              Text('text'),
            ],
          ),
        );
      },
    );
  }
}
