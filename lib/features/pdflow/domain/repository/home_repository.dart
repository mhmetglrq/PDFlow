import 'dart:io';

// final homeRepositoryProvider = Provider((ref) => HomeRepository());

// final fileProvider = StreamProvider<List<FileSystemEntity>>((ref) {
//   HomeRepository homeRepository = HomeRepository();
//   return homeRepository.getFiles().asStream();
// });

abstract class HomeRepository {
  Future<List<FileSystemEntity>> getFiles();
}
