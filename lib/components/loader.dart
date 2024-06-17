import 'package:cliplaza/pages/home.dart';
import 'package:flutter/material.dart';

class RegistrationLoader extends StatefulWidget {
  const RegistrationLoader({super.key});

  @override
  State<RegistrationLoader> createState() => _RegistrationLoaderState();
}

class _RegistrationLoaderState extends State<RegistrationLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Stiamo creando il tuo profilo...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 2),
            tween: Tween(begin: 0, end: 1),
            builder: (BuildContext context, double value, Widget? child) {
              return SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: value,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFA13BA7)),
                  backgroundColor: Colors.grey[300],
                  strokeWidth: 6,
                ),
              );
            },
            onEnd: () {
              Navigator.pushNamed(context, HomePage.route);
            },
          ),
        ],
      ),
    );
  }
}
