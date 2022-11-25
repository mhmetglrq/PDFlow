import 'package:flutter_img_to_pdf/features/home_page/repository/home_repository.dart';
import 'package:riverpod/riverpod.dart';

final getFileListProvider = FutureProvider(((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.getFiles();
}));

final homeControllerProvider = Provider(((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeController(homeRepository: homeRepository, ref: ref);
}));

class HomeController {
  final ProviderRef ref;
  final HomeRepository homeRepository;

  HomeController({required this.ref, required this.homeRepository});
}
