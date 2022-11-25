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
  void createPdfFromImage(List<XFile?>? files, context, String fileName) async {
    final pdf = pw.Document();
    for (var i = 0; i < files!.length; i++) {
      final image = pw.MemoryImage(File(files[i]!.path).readAsBytesSync());
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.AspectRatio(
              aspectRatio: 210 / 297,
              child: pw.Container(
                margin: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(12),
                  image: pw.DecorationImage(
                      fit: pw.BoxFit.cover, image: pw.Image(image).image),
                ),
              ),
            );
          },
        ),
      );
    }
    savePDF(context, pdf);
  }

  savePDF(context, pdf) async {
    Directory? directory;
    String fileName = getRandomString(5);
    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> folders = directory!.path.split("/");
          for (var i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/PDFlow";
          directory = Directory(newPath);
          await directory.create();
          File file =
              File("${Directory(newPath).path}/files/PDFlow_$fileName.pdf");

          if (file.existsSync()) {
            file = await file.create(recursive: true);
            await file.writeAsBytes(await pdf.save());
          } else {
            file = await file.create(recursive: true);
            await file.writeAsBytes(await pdf.save());
          }
        } else {
          return false;
        }
      }
      
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
