import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/icons.dart';
import 'package:flutter_img_to_pdf/common/utils/images.dart';
import 'package:flutter_img_to_pdf/common/utils/permissions.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_appbar.dart';
import 'package:flutter_img_to_pdf/features/home_page/controller/home_controller.dart';
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
  String? filePath;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Future<bool> requestStoragePermission() async {
    return await requestPermission(Permission.storage);
  }

  void selectImages() async {
    images = await pickImagesFromGallery(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
      body: SafeArea(
        child: Column(
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
                      onTap: () async {
                        await requestStoragePermission();
                        selectImages();
                      },
                      backgroundColor: addImageBackgroundColor,
                      icon: addIcon,
                      iconColor: addImageIconColor,
                      title: 'Resim/Resimleri Seç',
                    ),
                  ),
                  images != null
                      ? Expanded(
                          child: CustomButton(
                            onTap: () async {
                              filePath = await convertToPDF(
                                images,
                              );
                              showDoneDialog(
                                  context: context, filePath: filePath!);
                              ref
                                  .refresh(fileProvider)
                                  .whenData((value) => null);
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
      ),
    );
  }
}
