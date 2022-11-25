import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/lists/card_list.dart';
import 'package:flutter_img_to_pdf/common/utils/images.dart';
import 'package:flutter_img_to_pdf/features/home_page/controller/home_controller.dart';
import 'package:flutter_img_to_pdf/features/selecting_page/screens/select_image_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widgets/error.dart';
import '../../common/widgets/loader.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDFLOW"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 40,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Geçmiş',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.list_alt_rounded),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 85,
                    child: ref.watch(getFileListProvider).when(
                          data: (fileList) => fileList.isNotEmpty
                              ? ListView.builder(
                                  reverse: true,
                                  itemCount: fileList.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            fileList[index]
                                                .path
                                                .split('/')
                                                .last,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(emptyImage),
                                          fit: BoxFit.cover)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "Şu anlık boş gözüküyor. Hemen PDF'leri oluşturalım!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                          error: (error, stackTrace) =>
                              ErrorScreen(error: error.toString()),
                          loading: () => const Loader(),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'PDF İşlemleri',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 85,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: pickImageCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: index == 0
                                ? () => Navigator.pushNamed(
                                    context, SelectImageScreen.routeName)
                                : () => Navigator.pushNamed(
                                    context, SelectImageScreen.routeName),
                            child: pickImageCards[index]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
