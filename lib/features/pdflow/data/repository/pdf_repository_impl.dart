import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../config/utility/utils.dart';
import '../../domain/repository/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  @override
  Future<String?> createPdfFromImage(List<XFile?>? files) async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.fullscreen,
    );
    for (var file in files ?? []) {
      final image = pw.MemoryImage(File(file.path).readAsBytesSync());
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
    return await savePDF(pdf);
  }

  @override
  Future<String?> savePDF(Document? pdf) async {
    Directory? directory;
    String fileName = getRandomString(5);
    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();

          File file = File("${directory!.path}/PDFlow_$fileName.pdf");

          if (file.existsSync()) {
            file = await file.create(recursive: true);

            pdf != null ? await file.writeAsBytes(await pdf.save()) : null;
          } else {
            file = await file.create(recursive: true);
            await file.writeAsBytes(pdf != null ? await pdf.save() : []);
          }
          return file.path;
        } else {
          return '';
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
