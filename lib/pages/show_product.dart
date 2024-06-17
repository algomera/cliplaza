import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({super.key});
  static const route = 'product/show';
  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  int quantity = 1;
  String size = 'S';
  List sizes = ['S', 'M', 'L', 'XL'];
  bool segui = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Row(
            children: [
              Icon(Icons.keyboard_arrow_left_rounded),
              Text(
                'Indietro',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF171717)),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              const CircleAvatar(),
              const SizedBox(width: 9),
              const Text('Zara Milano'),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    segui = !segui;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    segui ? 'Segui già' : 'Segui',
                    style: const TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                  onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 35,
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 16),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFF3F3F3),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: const Row(children: [
                                    Icon(Icons.account_circle),
                                    SizedBox(width: 8),
                                    Text(
                                      'Informazioni su questo account',
                                      style: TextStyle(
                                          color: Color(0xFF0C0C0C),
                                          fontFamily: 'semibold',
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    Icon(Icons.chevron_right_rounded)
                                  ]),
                                ),
                                const SizedBox(height: 20)
                              ],
                            ),
                          );
                        },
                      ),
                  child: const Icon(Icons.linear_scale)),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/AdobeStock_603278877.webp',
            height: 570,
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: 12),
          Row(children: [
            const SizedBox(width: 16),
            SvgPicture.asset('assets/images/Icon heart-empty.svg'),
            const SizedBox(width: 20),
            SvgPicture.asset('assets/images/icona messaggi.svg'),
            const SizedBox(width: 20),
            SvgPicture.asset('assets/images/Icon feather-send.svg')
          ]),
          const SizedBox(height: 20),
          Row(children: [
            const SizedBox(width: 16),
            SvgPicture.asset('assets/images/icon local.svg'),
            const SizedBox(width: 5),
            const Text('Corso Buenos Aires 54',
                style: TextStyle(color: Color(0xFFA13BA7)))
          ]),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at vestibulum nulla. Ut viverra eu quam quis porttitor. Nam lobortis libero et enim vulputate, in pulvinar orci bibendum. Aliquam sodales convallis porta. Praesent varius semper dolor sit amet efficitur. Vestibulum posuere diam tortor, sed sollicitudin justo pretium id. Suspendisse facilisis at sem nec varius. Ut a enim placerat augue cursus blandit et vel justo. Ut ac malesuada augue, eget pellentesque metus. In hac habitasse platea dictumst. Fusce elementum diam quis velit porttitor, sit amet molestie elit semper. Pellentesque malesuada, mi sed varius malesuada, leo mi laoreet metus, sit amet malesuada justo sapien in Leo. Morbi in consequat mauris. Fusce felis leo, lobortis in pellentesque vitae, finibus sit amet elit.'),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              'Taglia',
              style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
              children: List.generate(
                  sizes.length,
                  (index) => TagliaContainer(
                      size: sizes[index],
                      onTap: () {
                        setState(() {
                          size = sizes[index];
                        });
                      },
                      condition: size == sizes[index]))
              // children: [
              //   const SizedBox(width: 16),
              //   GrayContainer(onTap: () {}, size: 'S'),
              //   const SizedBox(width: 12),
              //   GrayContainer(onTap: () {}, size: 'M'),
              //   const SizedBox(width: 12),
              //   GrayContainer(onTap: () {}, size: 'L'),
              //   const SizedBox(width: 12),
              //   GrayContainer(onTap: () {}, size: 'XL')
              // ],
              ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              'Quantità',
              style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFE8E8E8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GrayContainer(
                      onTap: () {
                        if (quantity == 1) {
                          return;
                        }
                        setState(() {
                          quantity--;
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                          color: Color(0xFF171717),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    GrayContainer(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40)
        ],
      ),
      bottomNavigationBar: Container(
        height: 84,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8E8E8), // Color of the border
              width: 2.0, // Thickness of the border
            ),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Totale prezzo',
                    style: TextStyle(fontSize: 14, color: Color(0xFFB9B9B9))),
                Text(
                  '19,99 €',
                  style: TextStyle(
                      color: Color(0xFF171717),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 46,
              width: 123,
              child: CustomButton(
                  paddingX: 32,
                  paddingY: 12,
                  onPressed: () {
                    setState(() {
                      userState.value.cartItems.add(
                        {
                          'company': 'Zara',
                          'image': '4174170250_2_1_1.webp',
                          'name': 'Maglietta',
                          'subtitle': 'Taglia: $size',
                          'price': '19,99',
                          'quantity': quantity
                        },
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Aggiunto al carrello!'),
                        duration: Duration(seconds: 1)));
                  },
                  center: const Text(
                    'Acquista',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  bg: const Color(0xFFA13BA7)),
            ),
            const SizedBox(width: 17),
          ],
        ),
      ),
    );
  }
}

class GrayContainer extends StatelessWidget {
  const GrayContainer({super.key, required this.onTap, required this.icon});
  final void Function()? onTap;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFF3F3F3)),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

class TagliaContainer extends StatelessWidget {
  const TagliaContainer(
      {super.key,
      required this.size,
      required this.onTap,
      required this.condition});
  final void Function()? onTap;
  final String size;
  final bool condition;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color:
                condition ? const Color(0xFFA13BA7) : const Color(0xFFF3F3F3)),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
                color: condition ? Colors.white : const Color(0xFF171717),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
