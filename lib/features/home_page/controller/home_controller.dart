import 'dart:io';

import 'package:flutter_img_to_pdf/features/home_page/repository/home_repository.dart';
import 'package:riverpod/riverpod.dart';

final homeControllerProvider = Provider(((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeController(homeRepository: homeRepository, ref: ref);
}));

final fileProvider = StreamProvider<List<FileSystemEntity>>((ref) {
  final homeController = ref.watch(homeControllerProvider);
  return homeController.getFiles().asStream();
});

class HomeController {
  final ProviderRef ref;
  final HomeRepository homeRepository;

  HomeController({required this.ref, required this.homeRepository});

  Future<List<FileSystemEntity>> getFiles() async {
    return await homeRepository.getFiles();
  }
}
