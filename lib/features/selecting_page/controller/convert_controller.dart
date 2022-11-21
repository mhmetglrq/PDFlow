// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:riverpod/riverpod.dart';

import 'package:flutter_img_to_pdf/features/selecting_page/repository/convert_repository.dart';

final authControllerProvider = Provider(((ref) {
  final convertRepository = ref.watch(convertRepositoryProvider);

  return ConvertController(convertRepository: convertRepository, ref: ref);
}));

class ConvertController {
  final ConvertRepository convertRepository;
  final ProviderRef ref;
  ConvertController({
    required this.convertRepository,
    required this.ref,
  });

  void createPDFFromImage(File file) {
    convertRepository.createPdfFromImage(file);
  }
}
