import 'package:flutter/material.dart';

import '../../../common/utils/assets.dart';

class SelectingEmptyWidget extends StatelessWidget {
  const SelectingEmptyWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(emptyImage),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
