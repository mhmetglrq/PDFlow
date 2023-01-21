import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/features/pdf_converting_page/widgets/pick_image_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/utils/assets.dart';
import '../../pdf_converting_page/screens/select_image_screen.dart';
import '../../pdf_converting_page/screens/take_picture_screen.dart';

class ChooseCardListView extends StatelessWidget {
  const ChooseCardListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? PickImageCard(
                onTap: () =>
                    Navigator.pushNamed(context, SelectImageScreen.routeName),
                title: locale!.homechooseimg,
                backgroundImg: chooseImage,
              )
            : PickImageCard(
                onTap: () =>
                    Navigator.pushNamed(context, TakePictureScreen.routeName),
                title: locale!.hometakeimg,
                backgroundImg: takePicImage,
              );
      },
    );
  }
}
