import 'package:cliplaza/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterByPrice extends StatefulWidget {
  const FilterByPrice({super.key});
  static const route = 'filter_by_price';
  @override
  State<FilterByPrice> createState() => _FilterByPriceState();
}

class _FilterByPriceState extends State<FilterByPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset('assets/images/X.svg')),
            ],
          ),
          const Text(
            'Prezzo',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 15, fontFamily: 'semibold'),
          ),
          const SizedBox(height: 23),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prezzo a partire da',
                      style: TextStyle(fontSize: 13, color: Color(0xFF515151)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '0,00 €',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFD1D1D1), width: .8)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFA13BA7), width: .8),
                        ),
                        isCollapsed: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('A',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF515151))),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '0,00 €',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFD1D1D1), width: .8)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFA13BA7), width: .8),
                        ),
                        isCollapsed: true, // Collapse the TextField's height
                      ),
                      // Add your text style
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
              marginX: 100,
              paddingX: 32,
              paddingY: 10,
              onPressed: () {},
              center: const Text('Mostra i risultati',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'semibold',
                      color: Colors.white)),
              bg: const Color(0xFFA13BA7)),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
