import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/utils/assets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(emptyImage), fit: BoxFit.cover),
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        alignment: Alignment.bottomCenter,
        child: Text(
          locale!.homeEmpty,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
