import 'package:cliplaza/pages/filters/order_by.dart';
import 'package:cliplaza/pages/filters/price.dart';
import 'package:cliplaza/pages/filters/recommended.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  static const route = 'test';
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late String filter = filters[0];
  List filters = ['Suggeriti', 'Ordina per', 'Prezzo'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Container(
            height: 38,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
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
          const Text(
            "Vicino a me",
            style: TextStyle(
                shadows: [
                  Shadow(color: Color(0xFFA13BA7), offset: Offset(0, -1))
                ],
                color: Colors.transparent,
                fontSize: 13,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFA13BA7),
                decorationThickness: 1.6),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 14),
          const Text(
            'Filtri',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontFamily: 'semibold', fontSize: 15),
          ),
          const SizedBox(height: 8),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              filters.length,
              (index) => Filter(
                  onTap: () {
                    setState(() => filter = filters[index]);
                    switch (filter) {
                      case 'Suggeriti':
                        Navigator.pushNamed(context, RecommendedPage.route);
                        break;
                      case 'Ordina per':
                        Navigator.pushNamed(context, OrderByPage.route);
                        break;
                      case 'Prezzo':
                        Navigator.pushNamed(context, FilterByPrice.route);
                        break;
                      default:
                    }
                  },
                  title: filters[index],
                  condition: filter == filters[index]),
            ),
          ),
          const SizedBox(height: 35),
          const Text(
            'Ricerche recenti',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 15, fontFamily: 'semibold'),
          ),
          // const SizedBox(height: 13),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD1D1D1),
                  width: .4,
                ),
              ),
            ),
            child: const Row(children: [
              CircleAvatar(),
              SizedBox(width: 8),
              Text(
                'Zara Milano',
                style:
                    TextStyle(color: Color(0xFF0C0C0C), fontFamily: 'semibold'),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD1D1D1),
                  width: .4,
                ),
              ),
            ),
            child: Row(children: [
              CircleAvatar(),
              const SizedBox(width: 8),
              Text(
                'Nike Milano',
                style:
                    TextStyle(color: Color(0xFF0C0C0C), fontFamily: 'semibold'),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter(
      {super.key,
      required this.onTap,
      required this.title,
      required this.condition});
  final String title;
  final void Function()? onTap;
  final bool condition;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: condition ? const Color(0xFFF4E3F5) : Colors.white,
            border: Border.all(
                color:
                    condition ? Colors.transparent : const Color(0xFFD1D1D1))),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: condition
                    ? const Color(0xFFA13BA7)
                    : const Color(0xFF0C0C0C),
                fontSize: 13),
          ),
        ),
      ),
    );
  }
}
