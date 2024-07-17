// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_img_to_pdf/config/widgets/custom_appbar.dart';
import 'package:flutter_img_to_pdf/features/home_page/controller/home_controller.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/widgets/find.dart';
import '../../config/widgets/title_medium.dart';
import '../splash_page/widgets/empty_widget.dart';
import 'widgets/choose_card_listview.dart';
import 'widgets/file_listview.dart';

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
              Expanded(
                flex: 40,
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: TitleMedium(
                        title: locale!.history,
                      ),
                    ),
                    Flexible(
                      flex: 85,
                      child: ref.watch(fileProvider).when(
                            data: (data) {
                              var list = data.reversed.toList();
                              return data.isNotEmpty
                                  ? FileListView(
                                      list: list,
                                      ref: ref,
                                    )
                                  : const EmptyWidget();
                            },
                            error: ((error, stackTrace) =>
                                Text(error.toString())),
                            loading: () => const FindWidget(),
                          ),

                      //  FileStream(ref: ref),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: TitleMedium(
                        title: locale.transactions,
                      ),
                    ),
                    const Expanded(
                      flex: 85,
                      child: ChooseCardListView(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
