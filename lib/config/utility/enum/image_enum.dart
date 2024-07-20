import 'package:flutter/material.dart';

enum ImageEnum {
  emptyImage('empty_image'),
  chooseImage('choose_image'),
  takePicImage('take_picture_image'),
  dialogBackground('dialog_background'),
  ;

  final String value;
  const ImageEnum(this.value);

  String get toPng => 'assets/images/$value.png';

  Image get toPngImage => Image.asset(toPng);
}
