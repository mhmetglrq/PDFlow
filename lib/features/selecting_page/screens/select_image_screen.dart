import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/icons.dart';
import 'package:flutter_img_to_pdf/common/utils/images.dart';
import 'package:flutter_img_to_pdf/common/utils/permissions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/custom_button.dart';
import '../controller/convert_controller.dart';

class SelectImageScreen extends ConsumerStatefulWidget {
  static const String routeName = '/select-images-page';
  const SelectImageScreen({super.key});

  @override
  ConsumerState<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends ConsumerState<SelectImageScreen> {
  XFile? image;
  List<XFile?>? images;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void selectImageFromCamera() async {
    images = await pickImageFromCamera(context);
    setState(() {});
  }

  Future<bool> requestStoragePermission() async {
    return await requestPermission(Permission.storage);
  }

  Future<bool> requestCameraAndStoragePermission() async {
    return await requestPermission(Permission.camera);
  }

  Future<bool> requestManageExternalStoragePermission() async {
    return await requestPermission(Permission.manageExternalStorage);
  }

  void selectImages() async {
    images = await pickImagesFromGallery(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void convertToPDF(List<XFile?>? images, String fileName) {
    ref
        .read(convertControllerProvider)
        .createPDFFromImage(images, context, fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("PDFLOW"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          images != null
              ? Expanded(
                  flex: 50,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 210 / 297,
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                color: Colors.white,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(images![index]!.path),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(4),
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                        backgroundColor:
                                            pdfConvertBackgroundColor,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                            color: pdfConvertIconColor,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(emptyImage),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Henüz bir resim seçmemişsin. Resimleri seç başlayalım!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => selectImages(),
                    backgroundColor: addImageBackgroundColor,
                    icon: addIcon,
                    iconColor: addImageIconColor,
                    title: 'Resim/Resimleri Seç',
                  ),
                ),
                images != null
                    ? Expanded(
                        child: CustomButton(
                          onTap: () => convertToPDF(images, 'random'),
                          backgroundColor: pdfConvertBackgroundColor,
                          icon: doneIcon,
                          iconColor: pdfConvertIconColor,
                          title: "PDF'e Çevir",
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
