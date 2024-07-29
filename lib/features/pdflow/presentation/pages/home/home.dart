import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/title_medium.dart';

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          home: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              TitleMedium(
                title: locale?.transactions ?? "",
              ),
              SizedBox(
                height: context.height * 0.3,
                child: PageView.builder(
                    padEnds: false,
                    controller: PageController(viewportFraction: 0.5),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: context.paddingRightLow,
                            child: Container(
                              width: context.height * 0.23,
                              height: context.height * 0.23,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              // TitleMedium(
              //   title: locale!.history,
              // ),
              // Expanded(
              //   child: ref.watch(getFilesProvider).when(
              //         data: (data) {
              //           var list = data.reversed.toList();
              //           return data.isNotEmpty
              //               ? FileListView(
              //                   list: list,
              //                   ref: ref,
              //                 )
              //               : const EmptyWidget();
              //         },
              //         error: ((error, stackTrace) => Text(error.toString())),
              //         loading: () => const FindWidget(),
              //       ),

              // ),

              // const Expanded(
              //   child: ChooseCardListView(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
