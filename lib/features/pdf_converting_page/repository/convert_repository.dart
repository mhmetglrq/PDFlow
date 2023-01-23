import 'dart:io';

import 'package:flutter_img_to_pdf/common/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../common/utils/permissions.dart';

final convertRepositoryProvider = Provider((ref) => ConvertRepository());

class ConvertRepository {
  Future<String?> createPdfFromImage(List<XFile?> files, context) async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.fullscreen,
    );
    for (var i = 0; i < files.length; i++) {
      final image = pw.MemoryImage(File(files[i]!.path).readAsBytesSync());
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(20),
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.AspectRatio(
              aspectRatio: 210 / 297,
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(5),
                  image: pw.DecorationImage(
                      fit: pw.BoxFit.cover, image: pw.Image(image).image),
                ),
              ),
            );
          },
        ),
      );
    }
    return savePDF(context, pdf);
  }

  Future<String?> savePDF(context, pdf) async {
    Directory? directory;
    String fileName = getRandomString(5);
    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();

          File file = File("${directory!.path}/PDFlow_$fileName.pdf");

          if (file.existsSync()) {
            file = await file.create(recursive: true);
            await file.writeAsBytes(await pdf.save());
          } else {
            file = await file.create(recursive: true);
            await file.writeAsBytes(await pdf.save());
          }
          return file.path;
        } else {
          return '';
        }
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    return null;
  }
}
