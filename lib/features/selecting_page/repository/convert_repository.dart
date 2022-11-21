import 'dart:io';

import 'package:flutter_img_to_pdf/common/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final convertRepositoryProvider = Provider((ref) => ConvertRepository());

class ConvertRepository {
  final pdf = pw.Document();

  void createPdfFromImage(File files) async {
    final image = pw.MemoryImage(files.readAsBytesSync());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(image));
        }));
  }

  savePDF(context) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/filename.pdf');
      await file.writeAsBytes(await pdf.save());
      showSnackBar(context: context, content: 'Başarıyla Kaydedildi!');
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
