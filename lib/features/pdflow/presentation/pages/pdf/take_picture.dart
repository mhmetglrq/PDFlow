import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';
import 'package:flutter_img_to_pdf/features/pdflow/domain/usecases/pdf/create_pdf.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/utility/utils.dart';
import '../../provider/provider.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../../../../config/items/colors/app_colors.dart';
import '../../widgets/pdf/selecting_empty_widget.dart';

class TakePicture extends ConsumerStatefulWidget {
  static const String routeName = '/select-take-picture-page';
  const TakePicture({super.key});

  @override
  ConsumerState<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends ConsumerState<TakePicture> {
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
    return await ref.read(createPdfProvider).call(
          params: ParamsForCreatePdfUseCase(files: images),
        );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          home: false,
        ),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Stack(
          children: [
            images.isNotEmpty
                ? PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
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
                                                AppColors.addImageIconColor,
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
                                          backgroundColor: AppColors
                                              .pdfConvertBackgroundColor,
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                              color:
                                                  AppColors.pdfConvertIconColor,
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
                      );
                    },
                  )
                : SelectingEmptyWidget(
                    title: locale!.takepicturedescription,
                  ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  images.isNotEmpty
                      ? CustomButton(
                          onTap: () => addImageFromCamera(),
                          backgroundColor: AppColors.addImageBackgroundColor,
                          icon: Icons.add_rounded,
                          iconColor: AppColors.addImageIconColor,
                          title: locale!.takepictures,
                        )
                      : CustomButton(
                          onTap: () async {
                            await requestCameraPermission();
                            setState(() {
                              selectImageFromCamera();
                            });
                          },
                          backgroundColor: AppColors.addImageBackgroundColor,
                          icon: Icons.add_rounded,
                          iconColor: AppColors.addImageIconColor,
                          title: locale!.takepicture,
                        ),
                  images.isNotEmpty
                      ? CustomButton(
                          onTap: () async {
                            filePath = await convertToPDF(images);
                            Future.delayed(
                              Duration.zero,
                              () => showDoneDialog(
                                  context: context, filePath: filePath!),
                            );

                            // ref.refresh(fileProvider).whenData((value) => null);
                          },
                          backgroundColor: AppColors.pdfConvertBackgroundColor,
                          icon: Icons.done_rounded,
                          iconColor: AppColors.pdfConvertIconColor,
                          title: locale.convertpdf,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
