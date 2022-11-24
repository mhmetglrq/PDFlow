import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/permissions.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/utils/utils.dart';
import '../controller/convert_controller.dart';

class SelectImageScreen extends ConsumerStatefulWidget {
  static const String routeName = '/select-image-page';
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
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () => Navigator.pushNamedAndRemoveUntil(
        //       context, HomePage.routeName, (route) => false),
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     color: Color(0xFF8E9AAF),
        //   ),
        // ),
        title: const Text("PDFLOW"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          images != null
              ? Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 97,
                            child: AspectRatio(
                              aspectRatio: 210 / 297,
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                color: Colors.white,
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(images![index]!.path),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  (index + 1).toString(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              if (await requestStoragePermission()) {
                                selectImages();
                              }
                            },
                            child: Container()

                            // const PickImageCard(
                            //   iconData: Icons.photo_rounded,
                            //   title:
                            //       "Lütfen resmi veya resimleri seçmek için dokunun",
                            // ),
                            ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (await requestCameraAndStoragePermission()) {
                              selectImageFromCamera();
                            }
                          },
                          child: Container(),

                          // const PickImageCard(
                          //   iconData: Icons.photo_camera_rounded,
                          //   title: "Lütfen fotoğraf çekmek için dokunun",
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
          images != null
              ? Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Lütfen dosya adını giriniz..",
                    ),
                  ),
                )
              : const SizedBox(),
          images != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: "PDF'e Çevir",
                      onPressed: () async {
                        if (await requestManageExternalStoragePermission()) {
                          convertToPDF(images, _nameController.text);
                          setState(() {
                            images = null;
                            _nameController.clear();
                          });
                        }
                      },
                    ),
                    CustomButton(
                      text: "Başka Resim Çek veya Seç",
                      onPressed: () {
                        setState(() {
                          images = null;
                          _nameController.clear();
                        });
                      },
                    )
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
