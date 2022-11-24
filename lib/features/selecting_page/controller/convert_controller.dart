// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flutter_img_to_pdf/features/selecting_page/repository/convert_repository.dart';

final convertControllerProvider = Provider(((ref) {
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

  void createPDFFromImage(
      List<XFile?>? files, BuildContext context, String fileName) {
    convertRepository.createPdfFromImage(files, context, fileName);
  }
}
