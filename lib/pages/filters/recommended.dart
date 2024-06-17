import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({super.key});
  static const route = 'recommended';
  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  List categoriesProfessionisti = [
    {
      'title': 'Consulenti',
      'sub': ['c1', 'c2', 'c3']
    },
    {
      'title': 'Green',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Immobiliari',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Green',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Idraulici',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Psicologi',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Terapeuti',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Turistici',
      'sub': ['Museo del \'900', 'Pinacoteca di bara', 'Castello sforzesco']
    }
  ];

  List categoriesShopping = [
    {
      'title': 'Articoli sportivi',
      'sub': ['c1', 'c2', 'c3']
    },
    {
      'title': 'Collezionismo',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Moda',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Lusso',
      'sub': ['g1', 'g2', 'g3']
    },
    {
      'title': 'Telefonia',
      'sub': ['g1', 'g2', 'g3']
    },
  ];

  List categoriesFood = [
    {
      'title': 'Lorem ipsum',
      'sub': ['c1', 'c2', 'c3']
    },
    {
      'title': 'Lorem ipsum',
      'sub': ['Museo del \'900', 'Pinacoteca di bara', 'Castello sforzesco']
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/CLIPLAZA scritta nera.png'),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/X.svg'),
                  ))
            ],
          ),
          const SizedBox(height: 40),
          Box(
            onTap: () => showProfessionisti(
                'PROFESSIONISTI',
                'icona professionisti.svg',
                categoriesProfessionisti,
                const Color(0xFF3884F9)),
            title: 'PROFESSIONISTI',
            color: const Color(0xFF3884F9),
            image: 'icona professionisti.svg',
            subtitle: 'Cerca un servizio',
          ),
          const SizedBox(height: 40),
          Box(
            onTap: () => showProfessionisti('SHOPPING', 'icona shopping.svg',
                categoriesShopping, const Color(0xFF5DCBA9)),
            title: 'SHOPPING',
            color: const Color(0xFF5DCBA9),
            image: 'icona shopping.svg',
            subtitle: 'Cerca un prodotto',
          ),
          const SizedBox(height: 40),
          Box(
            onTap: () => showProfessionisti('FOOD', 'icona food.svg',
                categoriesFood, const Color(0xFFE3B957)),
            title: 'FOOD',
            color: const Color(0xFFE3B957),
            image: 'icona food.svg',
            subtitle: 'Cerca il tuo cibo preferito',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  double calculateExpandedHeight(List<dynamic> subCategories) {
    return subCategories.length * 20;
  }

  void showProfessionisti(
          String title, String image, List categories, Color color) =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: color),
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
                    const Spacer(),
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.disabled_by_default_rounded))
                  ],
                ),
                const SizedBox(height: 23),
                Container(
                  height: 38,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    // color: const Color(0xFFF3F3F3),
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: 'Cerca',
                      border: InputBorder.none, // Remove default border
                      prefixIcon: Icon(Icons.search), // Suffix icon
                    ),
                  ),
                ),
                // const SizedBox(height: 24),
                const Text('Categorie',
                    style: TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontSize: 17,
                        fontFamily: 'bold')),
                const SizedBox(height: 18),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool expanded = false;
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          margin: EdgeInsets.only(bottom: expanded ? 0 : 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(categories[index]['title'],
                                      style: const TextStyle(
                                          fontFamily: 'semibold',
                                          fontSize: 14,
                                          color: Color(0xff0C0C0C))),
                                  InkWell(
                                    onTap: () {
                                      setState(() => expanded = !expanded);
                                    },
                                    child: Icon(
                                        expanded ? Icons.remove : Icons.add),
                                  )
                                ],
                              ),
                              SizedBox(height: expanded ? 16 : 0),
                              expanded
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          categories[index]['sub'].length,
                                          (indexSub) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 26),
                                            child: Text(
                                              categories[index]['sub']
                                                  [indexSub],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF747474)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            );
          });

  void showShopping() => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container();
        });
      });

  void showFood() => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container();
        });
      });
}

class Box extends StatelessWidget {
  const Box(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color,
      required this.image,
      required this.subtitle});
  final void Function()? onTap;
  final String title;
  final Color color;
  final String subtitle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: SvgPicture.asset(
                'assets/images/$image',
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(color: color, fontSize: 17, fontFamily: 'bold'),
            )
          ],
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFFF3F3F3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/Icon ionic-ios-search.svg',
                  width: 12,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0C0C0C), BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                      fontFamily: 'semibold',
                      fontSize: 14,
                      color: Color(0xFF0C0C0C)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
