import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/sizes.dart';
import 'custom_button.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({super.key, required this.filePath});
  final String filePath;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return AlertDialog(
      backgroundColor: scaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                locale!.done,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
              ),
              Padding(
                padding: paddingVertical10,
                child: Text(
                  locale.donedescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
              Expanded(
                child: Lottie.asset(doneJson),
              ),
              CustomButton(
                backgroundColor: pdfConvertBackgroundColor,
                iconColor: pdfConvertIconColor,
                title: locale.openpdf,
                icon: openIcon,
                onTap: () {
                  OpenFilex.open(filePath);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
