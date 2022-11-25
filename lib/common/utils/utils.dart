import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(BuildContext context, ImageSource source) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<List<XFile?>?> pickImagesFromGallery(BuildContext context) async {
  List<XFile?>? images;
  try {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
      images = pickedImages;
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return images;
}

Future<List<FileSystemEntity>> getFiles() async {
  var root = Directory("/storage/emulated/0/PDFlow/files");
  final List<FileSystemEntity> entities = await root.list().toList();
  return entities;
}

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}

Future<List<XFile?>?> pickImageFromCamera(BuildContext context) async {
  List<XFile?>? images;
  List<XFile> imageList = [];

  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      imageList.add(pickedImage);
      images = imageList;
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return images;
}

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showDoneDialog({required context}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 2,
          content: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      });
}
