import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/features/pdflow/presentation/provider/provider.dart';

import 'package:flutter_img_to_pdf/features/pdflow/presentation/widgets/custom_appbar.dart';
import 'package:flutter_img_to_pdf/features/pdflow/presentation/widgets/pdf/selecting_empty_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/utility/utils.dart';
import '../../../domain/usecases/pdf/create_pdf.dart';
import '../../widgets/custom_button.dart';
import '../../../../../config/items/colors/app_colors.dart';

class SelectImage extends ConsumerStatefulWidget {
  static const String routeName = '/select-images-page';
  const SelectImage({super.key});

  @override
  ConsumerState<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends ConsumerState<SelectImage> {
  XFile? image;
  List<XFile?> images = [];
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

  Future convertToPDF(List<XFile?> images) async {
    return await ref
        .read(createPdfProvider)
        .call(params: ParamsForCreatePdfUseCase(files: images));
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
      body: SafeArea(
        child: Column(
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
                                                setState(() {
                                                  images.removeAt(index);
                                                });
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
                                                  color: AppColors
                                                      .pdfConvertIconColor,
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
                      title: locale!.choosedescription,
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
                      backgroundColor: AppColors.addImageBackgroundColor,
                      icon: Icons.add_rounded,
                      iconColor: AppColors.addImageIconColor,
                      title: locale!.chooseimages,
                    ),
                  ),
                  images.isNotEmpty
                      ? Expanded(
                          child: CustomButton(
                            onTap: () async {
                              filePath = await convertToPDF(
                                images,
                              );
                              Future.delayed(
                                Duration.zero,
                                () => showDoneDialog(
                                  context: context,
                                  filePath: filePath!,
                                ),
                              );
                            },
                            backgroundColor:
                                AppColors.pdfConvertBackgroundColor,
                            icon: Icons.done_rounded,
                            iconColor: AppColors.pdfConvertIconColor,
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
      ),
    );
  }
}
