import 'package:flutter_img_to_pdf/common/utils/images.dart';

import '../../features/selecting_page/widgets/pick_image_card.dart';

List<PickImageCard> pickImageCards = [
  const PickImageCard(
    title: "Galeriden Resim/Resimleri Seç",
    backgroundImg: chooseImage,
  ),
  const PickImageCard(
    title: "Resim Çek",
    backgroundImg: takePicImage,
  ),
];
