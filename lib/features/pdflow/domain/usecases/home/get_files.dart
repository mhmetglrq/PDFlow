import 'dart:io';

import '../../../../../core/usecase/usecase.dart';
import '../../repository/home_repository.dart';

class GetFilesUseCase implements UseCase<List<FileSystemEntity>, void> {
  HomeRepository homeRepository;
  GetFilesUseCase({required this.homeRepository});

  @override
  Future<List<FileSystemEntity>> call({void params}) {
    return homeRepository.getFiles();
  }
}
