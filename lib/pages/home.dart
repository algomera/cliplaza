import 'package:cliplaza/components/card_home.dart';
import 'package:cliplaza/components/home_alert_dismissable.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const route = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<HomeDismissable> dismissables;
  HomeDismissable? dismissable;
  final CardSwiperController controller = CardSwiperController();
  late List<Color> colors;
  int currentIndexCard = 0;

  // Video Controllers
  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, Future<void>> _initializeVideoPlayerFutures = {};

  @override
  void initState() {
    super.initState();
    colors = List.generate(10, (index) => Colors.transparent);

    if (userState.value.firstTime) {
      dismissables = [
        HomeDismissable(
          direction: DismissDirection.startToEnd,
          image: 'swipe1',
          color: const Color(0xFFA13BA7),
          text: 'Swipe a destra per mettere “like”',
          onDismissed: (direction) {
            setState(() {
              dismissable = dismissables[1];
            });
          },
        ),
        HomeDismissable(
          direction: DismissDirection.endToStart,
          image: 'swipe2',
          color: const Color(0xFFDC5A48),
          text: 'Swipe a sinistra per mettere “non mi piace”',
          onDismissed: (direction) {
            setState(() {
              dismissable = null;
            });
          },
        ),
      ];

      dismissable = dismissables[0];

      setState(() {
        userState.value.firstTime = false;
      });
    }

    _preloadNextTwoVideos(currentIndexCard);
  }

  @override
  void dispose() {
    _disposeAllVideoControllers();
    controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(int index, String? videoUrl) async {
    if (videoUrl != null && !_videoControllers.containsKey(index)) {
      final videoController =
          VideoPlayerController.asset(cards[index]['videoUrl'])
            ..setLooping(true);
      _videoControllers[index] = videoController;
      _initializeVideoPlayerFutures[index] =
          videoController.initialize().then((value) => videoController.play());
    }
  }

  void _disposeVideoController(int index) {
    if (_videoControllers.containsKey(index)) {
      _videoControllers[index]?.dispose();
      _videoControllers.remove(index);
      _initializeVideoPlayerFutures.remove(index);
    }
  }

  void _disposeAllVideoControllers() {
    _videoControllers.forEach((index, controller) {
      controller.dispose();
    });
    _videoControllers.clear();
    _initializeVideoPlayerFutures.clear();
  }

  Future<void> _preloadNextTwoVideos(int currentIndex) async {
    final nextIndex1 = currentIndex + 1;

    if (nextIndex1 < cards.length) {
      await _initializeVideo(nextIndex1, cards[nextIndex1]['videoUrl']);
    }
  }

  void _onSwipeDirectionChanged(CardSwiperDirection direction, int index) {
    setState(() {
      if (direction == CardSwiperDirection.left) {
        colors[index] = Colors.yellow.withOpacity(0.2);
      } else if (direction == CardSwiperDirection.right) {
        colors[index] = Colors.purple.withOpacity(0.2);
      } else {
        colors[index] = Colors.transparent;
      }
    });
  }

  List<Map<String, dynamic>> cards = [
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
    },
    {
      'color': Colors.transparent,
      'isImage': false,
      'videoUrl': 'assets/video/video1.mp4',
    },
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
    },
    {
      'color': Colors.transparent,
      'isImage': false,
      'videoUrl': 'assets/video/video2.mp4',
    },
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
    },
    {
      'color': Colors.transparent,
      'isImage': false,
      'videoUrl': 'assets/video/video1.mp4',
    },
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
    },
    {
      'color': Colors.transparent,
      'isImage': false,
      'videoUrl': 'assets/video/video2.mp4',
    },
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
    },
    {
      'color': Colors.transparent,
      'isImage': false,
      'videoUrl': 'assets/video/video1.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    //altezza appbar
    double appBarHeight = AppBar().preferredSize.height;

    // altezza schermo
    double screenHeight = MediaQuery.of(context).size.height;

    // altezza body scaffold
    double bodyHeight =
        screenHeight - appBarHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          currentIndexCard >= cards.length
              ? const Center(
                  child: Text('Prodotti terminati, torna più tardi.'))
              : CardSwiper(
                  isLoop: false,
                  onSwipeDirectionChange:
                      (horizontalDirection, verticalDirection) {
                    _onSwipeDirectionChanged(
                        horizontalDirection, currentIndexCard);
                  },
                  allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
                      horizontal: true, vertical: false),
                  controller: controller,
                  cardsCount: cards.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  numberOfCardsDisplayed: 2,
                  backCardOffset: Offset(0, bodyHeight - 180),
                  scale: 1,
                  padding: const EdgeInsets.all(12.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) {
                    return SizedBox(
                      height: bodyHeight - 200,
                      child: CardHomeTest(
                        key: ValueKey(index),
                        color: colors[index],
                        isImage: cards[index]['isImage'],
                        videoUrl: cards[index]['videoUrl'],
                        videoController: _videoControllers[index],
                        videoInitializationFuture:
                            _initializeVideoPlayerFutures[index],
                      ),
                    );
                  },
                ),
          if (dismissable != null)
            Positioned.fill(
              child: dismissable!,
            ),
        ],
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    setState(() {
      _disposeVideoController(
          previousIndex); // Dispose of the previous video's controller
      currentIndexCard++;
      _preloadNextTwoVideos(currentIndexCard);
      if (direction == CardSwiperDirection.right) {
        userState.value.liked.add('food');
      }
    });
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undone from the ${direction.name}',
    );
    setState(() {
      colors[currentIndex] = Colors.transparent;
    });

    return true;
  }
}
