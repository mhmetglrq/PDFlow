import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/assets.dart';
import 'package:lottie/lottie.dart';

class FindWidget extends StatelessWidget {
  const FindWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(findJson);
  }
}
