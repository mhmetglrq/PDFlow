import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/features/pdflow/presentation/widgets/alert_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> pickImage(BuildContext context, ImageSource source) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Future.delayed(
      Duration.zero,
      () => showSnackBar(context: context, content: e.toString()),
    );
  }
  return image;
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<List<XFile?>> pickImagesFromGallery(BuildContext context) async {
  List<XFile?> images = [];
  try {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
      images = pickedImages;
    }
  } catch (e) {
    Future.delayed(
      Duration.zero,
      () => showSnackBar(context: context, content: e.toString()),
    );
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

Future<List<XFile?>> pickImageFromCamera(BuildContext context) async {
  List<XFile?>? images = [];

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      images.add(XFile(pickedImage.path));
    }
  } catch (e) {
    Future.delayed(
      Duration.zero,
      () => showSnackBar(context: context, content: e.toString()),
    );
    // showSnackBar(context: context, content: e.toString());
  }
  return images;
}

Future<XFile?> addImagesFromCamera(BuildContext context) async {
  XFile? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = pickedImage;
    }
  } catch (e) {
    Future.delayed(
      Duration.zero,
      () => showSnackBar(context: context, content: e.toString()),
    );
    // showSnackBar(context: context, content: e.toString());
  }
  return image;
}

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showDoneDialog({required context, required String filePath}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlert(filePath: filePath);
    },
  );
}
