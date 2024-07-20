import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart';

abstract class PdfRepository {
  Future<String?> createPdfFromImage(
      List<XFile?>? files,);
  Future<String?> savePDF( Document? pdf);
}
