// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PickImageCard extends StatelessWidget {
  final String title;
  final String backgroundImg;
  final Function() onTap;
  const PickImageCard({
    Key? key,
    required this.title,
    required this.backgroundImg,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.55,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                backgroundImg,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
