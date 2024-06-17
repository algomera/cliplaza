import 'package:cliplaza/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderByPage extends StatefulWidget {
  const OrderByPage({super.key});
  static const route = 'orderBy';
  @override
  State<OrderByPage> createState() => _OrderByPageState();
}

class _OrderByPageState extends State<OrderByPage> {
  String _selectedSort = 'recent'; // initial value
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
                icon: SvgPicture.asset('assets/images/X.svg'),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          const Text(
            'Ordina per',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 15, fontFamily: 'semibold'),
          ),
          const SizedBox(height: 12),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 4),
                Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: 1.5,
                  child: Radio<String>(
                    visualDensity: const VisualDensity(horizontal: -4),
                    value: 'recent',
                    groupValue: _selectedSort,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSort = value!;
                      });
                    },
                    activeColor: const Color(0xFFA13BA7),
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFFA13BA7);
                        }
                        return const Color(
                            0xFFB0B7BE); // Return null to use default unselected color
                      },
                    ),
                  ),
                ),
                const Text(
                  'Dal più recente',
                  style: TextStyle(fontSize: 13, color: Color(0xFF515151)),
                ),
              ],
            ),
            onTap: () {
              if (_selectedSort != 'recent') {
                setState(() {
                  _selectedSort = 'recent';
                });
              }
            },
          ),
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 4),
                Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: 1.5,
                  child: Radio<String>(
                    visualDensity: const VisualDensity(horizontal: -4),
                    value: 'relevance',
                    groupValue: _selectedSort,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSort = value!;
                      });
                    },
                    activeColor: const Color(0xFFA13BA7),
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFFA13BA7);
                        }
                        return const Color(
                            0xFFB0B7BE); // Return null to use default unselected color
                      },
                    ),
                  ),
                ),
                const Text(
                  'Rilevanza',
                  style: TextStyle(fontSize: 13, color: Color(0xFF515151)),
                ),
              ],
            ),
            onTap: () {
              if (_selectedSort != 'relevance') {
                setState(() {
                  _selectedSort = 'relevance';
                });
              }
            },
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
