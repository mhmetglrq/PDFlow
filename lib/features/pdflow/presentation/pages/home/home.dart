import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../config/items/colors/app_colors.dart';

class Home extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.scaffoldBgColor,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: context.paddingAllDefault,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ready To Learn?",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: context.dynamicHeight(0.038),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
