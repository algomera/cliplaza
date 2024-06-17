import 'package:cliplaza/components/card_home.dart';
import 'package:cliplaza/components/home_alert_dismissable.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> cards = [
    {
      'color': Colors.transparent,
      'isImage': true,
      'videoUrl': null,
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
      'videoUrl': 'assets/video/video3.mp4',
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(12.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) {
                    return CardHomeTest(
                      key: ValueKey(index), // Ensure unique keys
                      color: colors[index],
                      isImage: true,
                      videoUrl: null,
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
      currentIndexCard++;
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
