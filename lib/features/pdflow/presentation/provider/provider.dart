import 'dart:io';

import 'package:flutter_img_to_pdf/features/pdflow/data/repository/home_repository_impl.dart';
import 'package:flutter_img_to_pdf/features/pdflow/data/repository/pdf_repository_impl.dart';
import 'package:flutter_img_to_pdf/features/pdflow/domain/usecases/home/get_files.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart';

import '../../domain/usecases/pdf/create_pdf.dart';
import '../../domain/usecases/pdf/save_pdf.dart';

final getFilesProvider = StreamProvider<List<FileSystemEntity>>((ref) {
  final homeRepository = HomeRepositoryImpl();
  final getFilesUseCase = GetFilesUseCase(homeRepository: homeRepository);
  return getFilesUseCase.call().asStream();
});

// final createPdfProvider =
//     FutureProvider.family<String?, List<XFile?>>((ref, files) {
//   final pdfRepository = PdfRepositoryImpl();
//   final createPdfUseCase = CreatePdfUseCase(pdfRepository: pdfRepository);
//   return createPdfUseCase.call(params: ParamsForCreatePdfUseCase(files: files));
// });

final createPdfProvider = Provider((ref) {
  final pdfRepository = PdfRepositoryImpl();
  final createPdfUseCase = CreatePdfUseCase(pdfRepository: pdfRepository);
  return createPdfUseCase;
});

final savePdfProvider =
    FutureProvider.autoDispose.family<String?, Document>((ref, pdf) async {
  final pdfRepository = PdfRepositoryImpl();
  final savePdfUseCase = SavePdfUseCase(pdfRepository: pdfRepository);
  return await savePdfUseCase.call(params: SavePdfUseCaseParams(pdf: pdf));
});
