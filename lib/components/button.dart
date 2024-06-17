import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.center,
      required this.bg,
      this.marginX,
      this.marginY,
      this.paddingX,
      this.paddingY,
      this.opacity});
  final void Function()? onPressed;
  final Widget center;
  final double? marginX;
  final double? marginY;
  final double? paddingX;
  final double? paddingY;
  final double? opacity;
  final Color bg;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: marginX ?? 0, vertical: marginY ?? 0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(
                  horizontal: paddingX ?? 0, vertical: paddingY ?? 0),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(bg),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          child: Center(
            child: center,
          ),
        ),
      ),
    );
  }
}
