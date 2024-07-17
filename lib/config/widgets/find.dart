import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utility/enum/json_enum.dart';

class FindWidget extends StatelessWidget {
  const FindWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(JsonEnum.find.getPath);
  }
}
