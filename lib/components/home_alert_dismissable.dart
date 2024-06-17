import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDismissable extends StatelessWidget {
  const HomeDismissable(
      {super.key,
      required this.direction,
      required this.image,
      required this.color,
      required this.text,
      required this.onDismissed});
  final String image;
  final Color color;
  final String text;
  final void Function(DismissDirection)? onDismissed;
  final DismissDirection direction;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: direction,
        onDismissed: onDismissed,
        child: AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            icon: Container(
              padding: const EdgeInsets.all(4),
              width: 35,
              height: 35,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: SvgPicture.asset(
                'assets/images/$image.svg',
                width: 26,
                height: 26,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(100)),
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                      child: Text(text,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center))
                ]))));
  }
}
