import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final String title;
  final IconData icon;
  final Function onTap;
  const CustomButton({
    Key? key,
    required this.backgroundColor,
    required this.iconColor,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 4,
              ),
              Expanded(
                flex: 15,
                child: CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
              ),
              Expanded(
                flex: 70,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
