import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/lists/card_list.dart';

import '../../common/utils/utils.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FileSystemEntity> files = [];

  void launchUrl(Uri url) async {
    launchInBrowser(url);
  }

  @override
  void initState() {
    // TODO: implement initState
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
                    child: FutureBuilder<List<FileSystemEntity>>(
                        future: getFiles(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            files = snapshot.data!.toList();
                          }
                          if (files.isEmpty) {
                            return Container(
                              margin: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/empty.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Şu anlık boş gözüküyor. Hemen PDF'leri oluşturalım!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            );
                          } else if (files.isNotEmpty) {
                            return ListView.builder(
                              itemCount: files.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: () => launchUrl(files[index].uri),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        files[index].path.split('/').last,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
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
                        return pickImageCards[index];
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
