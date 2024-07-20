import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl();

  @override
  Future<List<FileSystemEntity>> getFiles() async {
    List<FileSystemEntity> fileList = [];
    try {
      var root = await getExternalStorageDirectory();
      fileList = await root!.list().toList();
      return fileList;
    } catch (e) {
      log(e.toString());
    }
    return fileList;
  }
}
