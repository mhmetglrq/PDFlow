import 'package:flutter_img_to_pdf/features/pdflow/domain/repository/pdf_repository.dart';
import 'package:pdf/widgets.dart';

import '../../../../../core/usecase/usecase.dart';

class SavePdfUseCase implements UseCase<String?, SavePdfUseCaseParams> {
  PdfRepository pdfRepository;
  SavePdfUseCase({required this.pdfRepository});
  @override
  Future<String?> call({SavePdfUseCaseParams? params}) {
    return pdfRepository.savePDF(params?.pdf);
  }
}

class SavePdfUseCaseParams {
  final Document pdf;
  SavePdfUseCaseParams({required this.pdf});
}
