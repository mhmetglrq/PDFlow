import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/utils/assets.dart';
import '../../common/utils/colors.dart';
import '../../common/utils/icons.dart';
import '../../common/utils/permissions.dart';
import '../home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/select-splash-page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
            padding: paddingAll,
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
                            padding: paddingVertical10,
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
                        child: Lottie.asset(splashJson),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onTap: () => Navigator.pushNamed(context, HomePage.routeName),
                  backgroundColor: homeBackgroundColor,
                  iconColor: homeIconColor,
                  title: locale.start,
                  icon: homeIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
