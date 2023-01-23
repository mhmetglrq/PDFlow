// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/icons.dart';
import 'package:flutter_img_to_pdf/common/utils/permissions.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../home_page/controller/home_controller.dart';
import '../controller/convert_controller.dart';
import '../widgets/selecting_empty_widget.dart';

class TakePictureScreen extends ConsumerStatefulWidget {
  static const String routeName = '/select-take-picture-page';
  const TakePictureScreen({super.key});

  @override
  ConsumerState<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends ConsumerState<TakePictureScreen> {
  List<XFile?> images = [];
  List<XFile?> cameraImages = [];
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
        images.add(XFile(image.path));
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

  Future<String?> convertToPDF(List<XFile?> images) async {
    return await ref
        .read(convertControllerProvider)
        .createPDFFromImage(images, context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
          home: false,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          images.isNotEmpty
              ? Expanded(
                  flex: 50,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                          File(images[index]!.path),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(4),
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  images.removeAt(index);
                                                },
                                              );
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  addImageIconColor,
                                              child: Icon(
                                                Icons.delete_outline_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  flex: 50,
                  child: SelectingEmptyWidget(
                    title: locale!.takepicturedescription,
                  ),
                ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  child: images.isNotEmpty
                      ? CustomButton(
                          onTap: () => addImageFromCamera(),
                          backgroundColor: addImageBackgroundColor,
                          icon: addIcon,
                          iconColor: addImageIconColor,
                          title: locale!.takepictures,
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
                          title: locale!.takepicture,
                        ),
                ),
                images.isNotEmpty
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
                          title: locale.convertpdf,
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
