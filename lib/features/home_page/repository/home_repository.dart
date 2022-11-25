import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

class HomeRepository {
  
  Future<List<FileSystemEntity>> getFiles() async {
    var root = Directory("/storage/emulated/0/PDFlow/files");
    final List<FileSystemEntity> entities = await root.list().toList();
    return entities;
  }
}
