// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';



import '../controller/home_controller.dart';

class FileListView extends StatelessWidget {
  const FileListView({
    Key? key,
    required this.ref,
    required this.list,
  }) : super(key: key);
  final WidgetRef ref;
  final List<FileSystemEntity> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: ((context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () {
              OpenFilex.open(list[index].path);
            },
            onLongPress: () {
              List<XFile> files = [];
              var file = XFile(list[index].path);

              files.add(file);
              Share.shareXFiles(files);
            },
            title: Text(
              list[index].path.split('/').last,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => list[index].delete().then(
                    (value) => ref.refresh(fileProvider),
                  ),
            ),
          ),
        );
      }),
    );
  }
}
