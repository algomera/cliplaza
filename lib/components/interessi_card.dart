import 'package:flutter/material.dart';

class InteressiCard extends StatelessWidget {
  const InteressiCard(
      {super.key,
      required this.image,
      required this.title,
      this.onTap,
      required this.condition});
  final String title;
  final String image;
  final void Function()? onTap;
  final bool condition;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10), // Adjust the corner radius as needed
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                image,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                color: condition
                    ? const Color(0xFFF4E3F5)
                    : const Color(0xFFF3F3F3),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: condition
                          ? const Color(0xFFD38FD7)
                          : const Color(0xFF3A3A3A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
