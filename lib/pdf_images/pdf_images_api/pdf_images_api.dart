import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfImagesApi {
  static Future<File> generateTable() async {
    final pdf = Document();
    final headers = ['Name', 'Age'];
    final users = [
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
    ];
    final data = users.map((user) => [user.name, user.age]).toList();

    pdf.addPage(
      Page(
        build: (context) => Table.fromTextArray(
          headers: headers,
          data: data,
        ),
      ),
    );
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> generateImage(
      Uint8List boluevaredImageJpg, Uint8List pdfImageJpg) async {
    final pdf = Document();
    // final pageTheme = PageTheme(
    //   pageFormat: PdfPageFormat.a4,
    //   buildBackground: (context) {
    //     if (context.pageNumber == 1) {
    //       return FullPage(
    //         ignoreMargins: true,
    //         child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
    //       );
    //     } else {
    //       return Container();
    //     }
    //   },
    // );

    pdf.addPage(
      MultiPage(
        // pageTheme: pageTheme,
        build: (context) => [
          // Container(
          //   height: pageTheme.pageFormat.availableHeight - 1,
          //   child: Center(
          //     child: Text(
          //       'Foreground Text',
          //       style: TextStyle(color: PdfColors.white, fontSize: 48),
          //     ),
          //   ),
          // ),
          Image(MemoryImage(boluevaredImageJpg)),
          Image(fit: BoxFit.contain, MemoryImage(pdfImageJpg)),
          // Center(
          //   child: ClipRRect(
          //     horizontalRadius: 32,
          //     verticalRadius: 32,
          //     child: Image(
          //       MemoryImage(imageJpg),
          //       width: pageTheme.pageFormat.availableWidth / 2,
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
