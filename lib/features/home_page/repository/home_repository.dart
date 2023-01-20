import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

class HomeRepository {
  Future<List<FileSystemEntity>> getFiles() async {
    List<FileSystemEntity> fileList = [];
    try {
      var root = await getExternalStorageDirectory();
      fileList = await root!.list().toList();
      return fileList;
    } catch (e) {
      debugPrint(e.toString());
    }
    return fileList;
  }

}
