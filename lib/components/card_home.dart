import 'package:cliplaza/pages/show_product.dart';
import 'package:flutter/material.dart';
import 'package:cliplaza/components/button.dart';
import 'package:video_player/video_player.dart'; // Assuming this is your custom button widget

class CardHome extends StatefulWidget {
  const CardHome({
    super.key,
    required this.image,
    required this.onPressed,
    required this.company,
    required this.description,
  });

  final String image;
  final String company;
  final String description;
  final void Function()? onPressed;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0, // Initially, no rotation
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getRotationAngle(DismissDirection direction) {
    return direction == DismissDirection.endToStart
        ? -0.1
        : 0.1; // Adjust rotation angle based on direction
  }

  bool x = false;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: _rotationAnimation.value,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              margin: const EdgeInsets.only(bottom: 16),
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  50 -
                  100,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/${widget.image}.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 8),
                      Text(
                        widget.company,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.linear_scale_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4), // Adjust opacity as needed
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 20,
              child: SizedBox(
                width: 123,
                child: CustomButton(
                  paddingX: 32,
                  paddingY: 10,
                  onPressed: widget.onPressed,
                  center: const Text(
                    'Acquista',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  bg: const Color(0xFFA13BA7),
                ),
              ),
            ),
          ],
        ) // Your actual widget here

        );
  }
}

class CardHomeTest extends StatelessWidget {
  const CardHomeTest({
    Key? key,
    required this.color,
    required this.isImage,
    this.videoUrl,
  }) : super(key: key);

  final Color color;
  final bool isImage;
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, ShowProduct.route),
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                if (videoUrl != null)
                  Positioned.fill(
                    child: VideoPlayerWidget(videoUrl: videoUrl ?? ''),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      50 -
                      100,
                  decoration: isImage
                      ? BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/AdobeStock_629303194.webp'),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(width: 8),
                          Text(
                            'Pizzium Milao',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consetetur …',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: SizedBox(
                    width: 123,
                    child: CustomButton(
                      paddingX: 32,
                      paddingY: 10,
                      onPressed: () {
                        Navigator.pushNamed(context, ShowProduct.route);
                      },
                      center: const Text(
                        'Acquista',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      bg: const Color(0xFFA13BA7),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.asset(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.play();

    debugPrint('Initializing video: ${widget.videoUrl}');
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _initializeController();
      debugPrint('Updated video: ${widget.videoUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          return FittedBox(
            child: Container(color: Colors.amber),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// import 'dart:math';

// import 'package:cliplaza/components/button.dart';
// import 'package:flutter/material.dart';

// class CardHome extends StatefulWidget {
//   const CardHome({
//     Key? key,
//     required this.image,
//     required this.onPressed,
//     required this.company,
//     required this.description,
//   }) : super(key: key);

//   final String image;
//   final String company;
//   final String description;
//   final void Function()? onPressed;

//   @override
//   _CardHomeState createState() => _CardHomeState();
// }

// class _CardHomeState extends State<CardHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//           margin: const EdgeInsets.only(bottom: 16),
//           height: MediaQuery.of(context).size.height -
//               AppBar().preferredSize.height -
//               MediaQuery.of(context).padding.top -
//               50 -
//               100,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(
//               image: AssetImage('assets/images/${widget.image}.webp'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   const CircleAvatar(),
//                   const SizedBox(width: 8),
//                   Text(
//                     widget.company,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   const Spacer(),
//                   const Icon(
//                     Icons.linear_scale_sharp,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//               Text(
//                 widget.description,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 60),
//             ],
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.transparent,
//                   Colors.black.withOpacity(0.4), // Adjust opacity as needed
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 30,
//           right: 20,
//           child: SizedBox(
//             width: 123,
//             child: CustomButton(
//               paddingX: 32,
//               paddingY: 10,
//               onPressed: widget.onPressed,
//               center: const Text(
//                 'Acquista',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               bg: const Color(0xFFA13BA7),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
