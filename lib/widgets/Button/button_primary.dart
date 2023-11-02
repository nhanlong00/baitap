import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final void Function() onClick;
  final String title;
  final IconData? iconData;
  final double? size;
  final Widget? child;
  const ButtonPrimary({
    Key? key,
    required this.onClick,
    required this.title,
    this.iconData,
    this.size,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              backgroundColor: Colors.red
            ),
            child: Row(
              children: [
                (iconData != null) ? Icon(iconData, size: 16) : const SizedBox(),
                (iconData != null) ? const SizedBox(width: 8,) : const SizedBox(),
                Text(title, style: TextStyle(fontSize: size))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
