import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatelessWidget {
  const BackgroundVideo({super.key, required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: SizedBox(
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
