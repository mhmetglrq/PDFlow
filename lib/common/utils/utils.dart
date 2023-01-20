import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';

import 'icons.dart';

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
  List<XFile?>? images = [];

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      images.add(XFile(pickedImage.path));
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
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
    showSnackBar(context: context, content: e.toString());
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
      return AlertDialog(
        backgroundColor: scaffoldColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        content: AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Başarılı!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 20),
                ),
                Padding(
                  padding: paddingVertical10,
                  child: Text(
                    "PDF dosyası hazır! Aşağıdaki butona tıklayarak PDF dosyasına ulaşabilirsin.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                ),
                Expanded(child: Lottie.asset('assets/json/done.json')),
                CustomButton(
                  backgroundColor: pdfConvertBackgroundColor,
                  iconColor: pdfConvertIconColor,
                  title: "PDF'i açmak için dokun",
                  icon: openIcon,
                  onTap: () {
                    OpenFilex.open(filePath);
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
