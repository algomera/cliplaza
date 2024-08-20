import 'package:cliplaza/layout.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});
  static const route = 'favorites';
  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if args are provided and show the modal instantly
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        if (args['args'] == 'pro') {
          showModal('icona professionisti.svg', const Color(0xFF3884F9),
              'PROFESSIONISTI', professionistiItems);
        }
        if (args['args'] == 'shop') {
          showModal('icona shopping.svg', const Color(0xFF5DCBA9), 'SHOPPING',
              shoppingItems);
        }
        if (args['args'] == 'food') {
          showModal(
              'icona food.svg', const Color(0xFFE3B957), 'FOOD', foodItems);
        }
      }
    });
  }

  List professionistiItems = [
    {
      'image': 'AdobeStock_228965780_Preview.webp',
      'title': 'Psicologo',
    },
    {
      'image': 'AdobeStock_481431172_Preview.webp',
      'title': 'Terapeuta',
    },
    {
      'image': 'AdobeStock_647100544_Preview.webp',
      'title': 'Consulente',
    }
  ];
  List shoppingItems = [
    {
      'image': 'AdobeStock_333810258.webp',
      'title': 'Moda',
    },
    {
      'image': 'AdobeStock_533222663.webp',
      'title': 'Adidas',
    }
  ];
  List foodItems = [
    {
      'image': 'AdobeStock_22307550.webp',
      'title': 'Pizzium',
    },
    {
      'image': 'AdobeStock_46015742.webp',
      'title': 'Bottega Valtellina',
    },
    {
      'image': 'AdobeStock_235310178.webp',
      'title': 'Cioccolati italiani',
    }
  ];

  //counter delle card nella home di tipo "food" a cui l'utente ha messo like
  int foodCount =
      userState.value.liked.where((element) => element == 'food').length;
//counter delle card nella home di tipo "shopping" a cui l'utente ha messo like
  int shoppingCount =
      userState.value.liked.where((element) => element == 'shop').length;
//counter delle card nella home di tipo "professionisti" a cui l'utente ha messo like
  int proCount =
      userState.value.liked.where((element) => element == 'pro').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          FavoritesBox(
            onTap: () => showModal('icona professionisti.svg',
                const Color(0xFF3884F9), 'PROFESSIONISTI', professionistiItems),
            color: const Color(0xFF3884F9),
            icon: 'icona professionisti.svg',
            image: 'AdobeStock_228965780_Preview.webp',
            title: 'PROFESSIONISTI',
            counter: proCount,
          ),
          FavoritesBox(
            onTap: () => showModal('icona shopping.svg',
                const Color(0xFF5DCBA9), 'SHOPPING', shoppingItems),
            color: const Color(0xFF5DCBA9),
            icon: 'icona shopping.svg',
            image: 'AdobeStock_333810258.webp',
            title: 'SHOPPING',
            counter: shoppingCount,
          ),
          FavoritesBox(
            onTap: () => showModal(
                'icona food.svg', const Color(0xFFE3B957), 'FOOD', foodItems),
            color: const Color(0xFFE3B957),
            icon: 'icona food.svg',
            image: 'AdobeStock_109039496.webp',
            title: 'FOOD',
            counter: foodCount,
          ),
        ],
      ),
    );
  }

  void showModal(String image, Color color, String title, List items) {
    MainNavigatorState? mainNavigatorState =
        context.findAncestorStateOfType<MainNavigatorState>();
    if (mainNavigatorState != null) {
      mainNavigatorState.toggleAppBar(false);
    }
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Row(children: [
                        Icon(Icons.keyboard_arrow_left_rounded),
                        Text(
                          'Indietro',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF171717)),
                        )
                      ]),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: color),
                          child: SvgPicture.asset(
                            'assets/images/$image',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: TextStyle(
                              color: color, fontSize: 17, fontFamily: 'bold'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return FavoritesTile(
                              image: item['image'], title: item['title']);
                        })
                  ],
                ),
              ),
            ));
  }
}

class FavoritesBox extends StatelessWidget {
  const FavoritesBox(
      {super.key,
      required this.color,
      required this.icon,
      required this.image,
      required this.title,
      required this.onTap,
      required this.counter});
  final String image;
  final String title;
  final String icon;
  final Color color;
  final void Function()? onTap;
  final int counter;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 185,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: .7,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/$image'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/$icon',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  counter == 0
                      ? const SizedBox.shrink()
                      : Positioned(
                          left: 10,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFDCE63)),
                            width: 22,
                            height: 22,
                            child: Center(
                              child: Text(
                                counter.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'semibold',
                                    fontSize: 13,
                                    color: Color(0xFF171717)),
                              ),
                            ),
                          ),
                        ),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontFamily: 'bold',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesTile extends StatelessWidget {
  const FavoritesTile({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFF3F3F3),
      ),
      height: 71,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('assets/images/$image',
                  width: 100, fit: BoxFit.cover)),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
                // SizedBox(height: 5),
                const Text('Lorem ipsum dolor sit ametxxxxx',
                    style: TextStyle(color: Color(0xFF747474), fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1)
              ],
            ),
          ),
          const SizedBox(width: 70),
        ],
      ),
    );
  }
}
