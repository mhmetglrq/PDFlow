import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_img_to_pdf/config/routes/route_names.dart';

import '../../../../../config/utility/enum/image_enum.dart';
import '../pdf/pick_image_card.dart';

class ChooseCardListView extends StatelessWidget {
  const ChooseCardListView({
    super.key,
  });

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
                    Navigator.pushNamed(context, RouteNames.selectImage),
                title: locale!.homechooseimg,
                backgroundImg: ImageEnum.chooseImage.toPng,
              )
            : PickImageCard(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.takePicture),
                title: locale!.hometakeimg,
                backgroundImg: ImageEnum.takePicImage.toPng,
              );
      },
    );
  }
}
