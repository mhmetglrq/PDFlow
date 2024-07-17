import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/widgets/custom_button.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/items/colors/app_colors.dart';
import '../../config/utility/enum/json_enum.dart';
import '../../config/utility/utils.dart';
import '../home_page/home_page.dart';

class Onboarding extends StatefulWidget {
  static const String routeName = '/select-splash-page';

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Future<bool> requestManageExternalStoragePermission() async {
    return await requestPermission(Permission.manageExternalStorage);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: context.paddingAllDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: context.paddingVerticalLow,
                            child: Text(
                              'PDFLOW',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                          ),
                          Text(
                            locale!.splashtitle,
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Lottie.asset(JsonEnum.splash.getPath),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onTap: () => Navigator.pushNamed(context, Home.routeName),
                  backgroundColor: AppColors.homeBackgroundColor,
                  iconColor: AppColors.homeIconColor,
                  title: locale.start,
                  icon: Icons.favorite_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
