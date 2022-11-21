import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/utils/utils.dart';

class SelectImageScreen extends StatefulWidget {
  static const String routeName = '/select-image-page';
  const SelectImageScreen({super.key});

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  File? image;
  List<XFile?>? images;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void selectImages() async {
    images = await pickImagesFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image != null
              ? AspectRatio(
                  aspectRatio: 210 / 297,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          image!,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const Center(
            child: Text('Lütfen yükleyeceğiniz resimleri seçin'),
          ),
          CustomButton(text: 'Resim Seç', onPressed: selectImage),
          CustomButton(text: 'Resim Seç', onPressed: selectImages),
          images != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AspectRatio(
                        aspectRatio: 210 / 297,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(images![index]!.path))),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
