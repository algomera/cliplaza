import 'dart:math';
import 'package:cliplaza/components/background_video.dart';
import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const route = 'landing';
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController? controller;
  List<String> videos = ['video2.mp4', 'video3.mp4', 'video1.mp4'];

  @override
  void initState() {
    super.initState();
    playRandomVideo();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  //funzione che mostra un video random tra i 3 scelti
  void playRandomVideo() {
    int randomIndex = Random().nextInt(videos.length);
    String randomVideo = videos[randomIndex];
    controller = VideoPlayerController.asset("assets/video/$randomVideo")
      ..setVolume(0.0)
      ..initialize().then((_) {
        setState(() {
          controller!.play();
          controller!.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundVideo(controller: controller),
          Positioned(
            top: 50, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 220),
                SvgPicture.asset('assets/images/LOGO B2C.svg'),
                const SizedBox(height: 14),
              ],
            ),
          ),
          Positioned(
            bottom: 130,
            left: 16,
            right: 16,
            child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.route);
              },
              center: const Text(
                'Accedi',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              bg: const Color(0xFFA13BA7),
            ),
          ),
        ],
      ),
    );
  }
}
