import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/icons.dart';
import 'package:flutter_img_to_pdf/common/utils/images.dart';
import 'package:flutter_img_to_pdf/common/utils/permissions.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/custom_button.dart';
import '../../home_page/controller/home_controller.dart';
import '../controller/convert_controller.dart';
import '../../../common/widgets/custom_appbar.dart';

class TakePictureScreen extends ConsumerStatefulWidget {
  static const String routeName = '/select-take-picture-page';
  const TakePictureScreen({super.key});

  @override
  ConsumerState<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends ConsumerState<TakePictureScreen> {
  List<XFile?>? images;
  List<XFile?>? cameraImages;
  final TextEditingController _nameController = TextEditingController();
  String? filePath;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void addImageFromCamera() async {
    var image = await addImagesFromCamera(context);
    if (image != null) {
      setState(() {
        images!.add(XFile(image.path));
      });
    }
  }

  void selectImageFromCamera() async {
    images = await pickImageFromCamera(context);
    setState(() {});
  }

  Future<bool> requestCameraPermission() async {
    return await requestPermission(Permission.camera);
  }

  Future<String?> convertToPDF(List<XFile?>? images) async {
    return await ref
        .read(convertControllerProvider)
        .createPDFFromImage(images, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: preferredSize, child: CustomAppBar()),
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
                                      ),
                                    ),
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
                              'Henüz bir resim çekmemişsin. Resim çek ve başlayalım!',
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
                  child: images != null
                      ? CustomButton(
                          onTap: () => addImageFromCamera(),
                          backgroundColor: addImageBackgroundColor,
                          icon: addIcon,
                          iconColor: addImageIconColor,
                          title: 'Resim Çek/Ekle',
                        )
                      : CustomButton(
                          onTap: () async {
                            await requestCameraPermission();
                            setState(() {
                              selectImageFromCamera();
                            });
                          },
                          backgroundColor: addImageBackgroundColor,
                          icon: addIcon,
                          iconColor: addImageIconColor,
                          title: 'Resim Çek',
                        ),
                ),
                images != null
                    ? Expanded(
                        child: CustomButton(
                          onTap: () async {
                            filePath = await convertToPDF(
                              images,
                            ).then((value) => value);
                            showDoneDialog(
                                context: context, filePath: filePath!);

                            ref.refresh(fileProvider).whenData((value) => null);
                          },
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
