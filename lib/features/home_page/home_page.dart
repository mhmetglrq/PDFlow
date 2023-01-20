import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/lists/card_list.dart';
import 'package:flutter_img_to_pdf/common/utils/sizes.dart';
import 'package:flutter_img_to_pdf/features/home_page/controller/home_controller.dart';
import 'package:flutter_img_to_pdf/features/pdf_converting_page/screens/select_image_screen.dart';
import 'package:flutter_img_to_pdf/features/pdf_converting_page/screens/take_picture_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';

import '../../common/utils/images.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
      body: SafeArea(
        child: Padding(
          padding: paddingAll,
          child: Column(
            children: [
              Expanded(
                flex: 40,
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

                      child: ref.watch(fileProvider).when(
                            skipLoadingOnReload: true,
                            data: (data) {
                              return data.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: data.length,
                                      itemBuilder: ((context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              OpenFilex.open(data[index].path);
                                            },
                                            title: Text(
                                              data[index].path.split('/').last,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
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
                                            fit: BoxFit.cover),
                                      ),
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
                                    );
                            },
                            error: ((error, stackTrace) =>
                                Text(error.toString())),
                            loading: () =>
                                Lottie.asset('assets/json/loader.json'),
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
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: pickImageCards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: index == 0
                                  ? () => Navigator.pushNamed(
                                      context, SelectImageScreen.routeName)
                                  : () => Navigator.pushNamed(
                                      context, TakePictureScreen.routeName),
                              child: pickImageCards[index]);
                        },
                      ),
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

class FileStream extends StatelessWidget {
  const FileStream({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FileSystemEntity>>(
      stream: ref
          .watch(homeControllerProvider)
          .getFiles()
          .asStream()
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset('assets/json/loader.json', fit: BoxFit.fitWidth);
        }
        var fileList = snapshot.data;

        return snapshot.data!.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: fileList!.length,
                itemBuilder: ((context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {
                        OpenFilex.open(fileList[index].path);
                      },
                      title: Text(
                        fileList[index].path.split('/').last,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }),
              )
            : Container(
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(emptyImage), fit: BoxFit.cover),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Şu anlık boş gözüküyor. Hemen PDF'leri oluşturalım!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
      },
    );
  }
}
