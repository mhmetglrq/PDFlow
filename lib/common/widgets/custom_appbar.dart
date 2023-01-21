import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.home,
  }) : super(key: key);
  final bool home;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: home
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
      title: const Text("PDFLOW"),
      centerTitle: true,
    );
  }
}
