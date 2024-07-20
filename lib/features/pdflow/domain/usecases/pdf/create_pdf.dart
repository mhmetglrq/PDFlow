import 'package:image_picker/image_picker.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../repository/pdf_repository.dart';

class CreatePdfUseCase implements UseCase<String?, ParamsForCreatePdfUseCase> {
  final PdfRepository pdfRepository;

  CreatePdfUseCase({required this.pdfRepository});

  @override
  Future<String?> call({ParamsForCreatePdfUseCase? params}) async {
    return await pdfRepository.createPdfFromImage(params?.files);
  }
}

class ParamsForCreatePdfUseCase {
  final List<XFile?> files;

  ParamsForCreatePdfUseCase({
    required this.files,
  });
}
